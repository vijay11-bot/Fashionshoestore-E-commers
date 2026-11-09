package com.fashionshoestore.dao;

import com.fashionshoestore.model.CartItem;
import com.fashionshoestore.model.Order;
import com.fashionshoestore.model.OrderItem;
import com.fashionshoestore.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public int createOrder(Order order, List<CartItem> items, int cartId) {
        String insertOrderSql = "INSERT INTO orders (user_id, total_amount, payment_method, order_status, delivery_address) " +
                                "VALUES (?, ?, ?, ?, ?)";
        String insertItemSql = "INSERT INTO order_items (order_id, product_id, product_name, quantity, unit_price, subtotal, size_label) " +
                               "VALUES (?, ?, ?, ?, ?, ?, ?)";
        String deductStockSql = "UPDATE product_sizes SET stock_quantity = GREATEST(0, stock_quantity - ?) " +
                                "WHERE product_id = ? AND size_label = ?";
        String clearCartSql = "DELETE FROM cart_items WHERE cart_id = ?";

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            int orderId = 0;
            try (PreparedStatement psOrder = conn.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setInt(1, order.getUserId());
                psOrder.setDouble(2, order.getTotalAmount());
                psOrder.setString(3, order.getPaymentMethod());
                psOrder.setString(4, order.getOrderStatus() != null ? order.getOrderStatus() : "Confirmed");
                psOrder.setString(5, order.getDeliveryAddress());

                psOrder.executeUpdate();
                try (ResultSet rs = psOrder.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                        order.setOrderId(orderId);
                    }
                }
            }

            if (orderId == 0) {
                conn.rollback();
                return 0;
            }

            // Insert each item and deduct size stock
            try (PreparedStatement psItem = conn.prepareStatement(insertItemSql);
                 PreparedStatement psStock = conn.prepareStatement(deductStockSql)) {

                for (CartItem ci : items) {
                    psItem.setInt(1, orderId);
                    psItem.setInt(2, ci.getProductId());
                    psItem.setString(3, ci.getProductName());
                    psItem.setInt(4, ci.getQuantity());
                    psItem.setDouble(5, ci.getUnitPrice());
                    psItem.setDouble(6, ci.getSubtotal());
                    psItem.setString(7, ci.getSizeLabel());
                    psItem.addBatch();

                    psStock.setInt(1, ci.getQuantity());
                    psStock.setInt(2, ci.getProductId());
                    psStock.setString(3, ci.getSizeLabel());
                    psStock.addBatch();
                }

                psItem.executeBatch();
                psStock.executeBatch();
            }

            // Clear items from cart
            if (cartId > 0) {
                try (PreparedStatement psClear = conn.prepareStatement(clearCartSql)) {
                    psClear.setInt(1, cartId);
                    psClear.executeUpdate();
                }
            }

            conn.commit();
            return orderId;

        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return 0;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order(
                            rs.getInt("order_id"),
                            rs.getInt("user_id"),
                            rs.getTimestamp("order_date"),
                            rs.getDouble("total_amount"),
                            rs.getString("payment_method"),
                            rs.getString("order_status"),
                            rs.getString("delivery_address")
                    );
                    order.setItems(getOrderItems(order.getOrderId()));
                    orders.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public Order getOrderById(int orderId) {
        String sql = "SELECT o.*, u.full_name FROM orders o " +
                     "JOIN users u ON o.user_id = u.user_id " +
                     "WHERE o.order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order order = new Order(
                            rs.getInt("order_id"),
                            rs.getInt("user_id"),
                            rs.getTimestamp("order_date"),
                            rs.getDouble("total_amount"),
                            rs.getString("payment_method"),
                            rs.getString("order_status"),
                            rs.getString("delivery_address")
                    );
                    order.setCustomerName(rs.getString("full_name"));
                    order.setItems(getOrderItems(orderId));
                    return order;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT oi.*, p.image_url FROM order_items oi " +
                     "LEFT JOIN products p ON oi.product_id = p.product_id " +
                     "WHERE oi.order_id = ? ORDER BY oi.order_item_id ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem(
                            rs.getInt("order_item_id"),
                            rs.getInt("order_id"),
                            rs.getInt("product_id"),
                            rs.getString("product_name"),
                            rs.getInt("quantity"),
                            rs.getDouble("unit_price"),
                            rs.getDouble("subtotal"),
                            rs.getString("size_label")
                    );
                    item.setImageUrl(rs.getString("image_url"));
                    items.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }
}
