package com.fashionshoestore.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.fashionshoestore.model.Order;
import com.fashionshoestore.util.DBConnection;

public class OrderDAO {

    private OrderItemDAO orderItemDAO = new OrderItemDAO();

    // Place an order and return generated order ID
    public int placeOrder(Order order) {
        String sql = "INSERT INTO orders (user_id, total_amount, status, payment_method, order_date) "
                   + "VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, order.getUserId());
            ps.setDouble(2, order.getTotalAmount());
            ps.setString(3, order.getStatus() != null ? order.getStatus() : "Confirmed");
            ps.setString(4, order.getPaymentMethod() != null ? order.getPaymentMethod() : "Credit Card");

            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Get order by ID with items populated
    public Order getOrderById(int orderId) {
        Order order = null;
        String sql = "SELECT * FROM orders WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    order.setPaymentMethod(rs.getString("payment_method"));

                    java.sql.Timestamp ts = rs.getTimestamp("order_date");
                    if (ts != null) {
                        order.setOrderDate(new SimpleDateFormat("dd MMM yyyy, hh:mm a").format(ts));
                    }

                    order.setItems(orderItemDAO.getOrderItems(orderId));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }

    // Get all orders by user ID
    public List<Order> getOrdersByUser(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    order.setPaymentMethod(rs.getString("payment_method"));

                    java.sql.Timestamp ts = rs.getTimestamp("order_date");
                    if (ts != null) {
                        order.setOrderDate(new SimpleDateFormat("dd MMM yyyy, hh:mm a").format(ts));
                    }

                    order.setItems(orderItemDAO.getOrderItems(order.getId()));
                    orders.add(order);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }
}
