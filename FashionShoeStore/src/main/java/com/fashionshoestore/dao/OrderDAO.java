package com.fashionshoestore.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionshoestore.model.Order;
import com.fashionshoestore.util.DBConnection;

public class OrderDAO {

    // =========================
    // CREATE ORDER
    // =========================

    public int placeOrder(Order order) {

        String sql = "INSERT INTO orders "
                   + "(user_id, total_amount, status, order_date) "
                   + "VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     sql,
                     PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, order.getUserId());
            ps.setDouble(2, order.getTotalAmount());
            ps.setString(3, order.getStatus());
            ps.setString(4, order.getOrderDate());

            int result = ps.executeUpdate();

            if (result > 0) {

                ResultSet rs = ps.getGeneratedKeys();

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }


    // =========================
    // GET ORDERS BY USER
    // =========================

    public List<Order> getOrdersByUser(int userId) {

        List<Order> orders = new ArrayList<>();

        String sql = "SELECT * FROM orders "
                   + "WHERE user_id = ? "
                   + "ORDER BY order_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Order order = new Order();

                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalAmount(
                        rs.getDouble("total_amount")
                );
                order.setStatus(
                        rs.getString("status")
                );
                order.setOrderDate(
                        rs.getString("order_date")
                );

                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }
    public Order getOrderByIdAndUser(int orderId, int userId) {

        Order order = null;

        String sql = "SELECT * FROM orders "
                   + "WHERE id = ? AND user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ps.setInt(2, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    order = new Order();

                    order.setId(rs.getInt("id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setTotalAmount(
                            rs.getDouble("total_amount"));
                    order.setStatus(
                            rs.getString("status"));
                    order.setOrderDate(
                            rs.getString("order_date"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return order;
    }
}