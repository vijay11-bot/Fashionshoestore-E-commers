package com.fashionshoestore.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.fashionshoestore.model.Cart;
import com.fashionshoestore.model.User;
import com.fashionshoestore.service.CartService;
import com.fashionshoestore.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    private CartService cartService = new CartService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        String paymentMethod = request.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            paymentMethod = "Credit Card";
        }

        List<Cart> cartItems = cartService.getCartItems(userId);
        if (cartItems.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        Connection con = null;
        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // 1. Calculate total and verify stock
            double totalAmount = 0;
            for (Cart item : cartItems) {
                if (item.getProduct() != null) {
                    if (item.getProduct().getQuantity() < item.getQuantity()) {
                        con.rollback();
                        response.sendRedirect("cart?error=outofstock");
                        return;
                    }
                    totalAmount += item.getQuantity() * item.getProduct().getPrice();
                }
            }

            // 2. Insert into orders table
            String orderSql = "INSERT INTO orders (user_id, total_amount, status, payment_method, order_date) "
                            + "VALUES (?, ?, 'Confirmed', ?, CURRENT_TIMESTAMP)";
            int orderId = -1;
            try (PreparedStatement orderPs = con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                orderPs.setInt(1, userId);
                orderPs.setDouble(2, totalAmount);
                orderPs.setString(3, paymentMethod);
                orderPs.executeUpdate();

                try (ResultSet rs = orderPs.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                    }
                }
            }

            if (orderId == -1) {
                con.rollback();
                response.sendRedirect("checkout?error=failed");
                return;
            }

            // 3. Insert order items & reduce stock
            String itemSql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            String stockSql = "UPDATE products SET quantity = quantity - ? WHERE id = ?";

            try (PreparedStatement itemPs = con.prepareStatement(itemSql);
                 PreparedStatement stockPs = con.prepareStatement(stockSql)) {

                for (Cart item : cartItems) {
                    if (item.getProduct() != null) {
                        itemPs.setInt(1, orderId);
                        itemPs.setInt(2, item.getProductId());
                        itemPs.setInt(3, item.getQuantity());
                        itemPs.setDouble(4, item.getProduct().getPrice());
                        itemPs.addBatch();

                        stockPs.setInt(1, item.getQuantity());
                        stockPs.setInt(2, item.getProductId());
                        stockPs.addBatch();
                    }
                }

                itemPs.executeBatch();
                stockPs.executeBatch();
            }

            // 4. Clear user's cart
            String clearCartSql = "DELETE FROM cart WHERE user_id = ?";
            try (PreparedStatement clearPs = con.prepareStatement(clearCartSql)) {
                clearPs.setInt(1, userId);
                clearPs.executeUpdate();
            }

            // Commit all changes
            con.commit();

            response.sendRedirect("order-success.jsp?id=" + orderId);

        } catch (Exception e) {
            e.printStackTrace();
            if (con != null) {
                try {
                    con.rollback();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            response.sendRedirect("checkout?error=servererror");
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}