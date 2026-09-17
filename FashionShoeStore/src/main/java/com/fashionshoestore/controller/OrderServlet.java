package com.fashionshoestore.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;

import com.fashionshoestore.model.User;
import com.fashionshoestore.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        // =========================
        // CHECK LOGIN
        // =========================

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        Connection con = null;

        try {

            con = DBConnection.getConnection();

            // Start transaction
            con.setAutoCommit(false);


            // =========================
            // GET CART ITEMS
            // =========================

            String cartSql =
                    "SELECT c.product_id, c.quantity, p.price, "
                  + "p.quantity AS stock "
                  + "FROM cart c "
                  + "JOIN products p ON c.product_id = p.id "
                  + "WHERE c.user_id = ?";

            PreparedStatement cartPs =
                    con.prepareStatement(cartSql);

            cartPs.setInt(1, userId);

            ResultSet cartRs =
                    cartPs.executeQuery();


            // =========================
            // CALCULATE TOTAL
            // AND CHECK STOCK
            // =========================

            double totalAmount = 0;
            boolean hasItems = false;

            while (cartRs.next()) {

                hasItems = true;

                int quantity =
                        cartRs.getInt("quantity");

                int stock =
                        cartRs.getInt("stock");

                double price =
                        cartRs.getDouble("price");


                // Check stock
                if (quantity > stock) {

                    cartRs.close();
                    cartPs.close();

                    con.rollback();

                    response.sendRedirect(
                            "cart?error=stock"
                    );

                    return;
                }


                totalAmount += price * quantity;
            }

            cartRs.close();
            cartPs.close();


            // =========================
            // CHECK EMPTY CART
            // =========================

            if (!hasItems) {

                con.rollback();

                response.sendRedirect(
                        "cart?error=empty"
                );

                return;
            }


            // =========================
            // INSERT ORDER
            // =========================

            String orderSql =
                    "INSERT INTO orders "
                  + "(user_id, total_amount, status, order_date) "
                  + "VALUES (?, ?, ?, ?)";

            PreparedStatement orderPs =
                    con.prepareStatement(
                            orderSql,
                            Statement.RETURN_GENERATED_KEYS
                    );

            orderPs.setInt(1, userId);

            orderPs.setDouble(
                    2,
                    totalAmount
            );

            orderPs.setString(
                    3,
                    "Pending"
            );

            orderPs.setTimestamp(
                    4,
                    new Timestamp(
                            System.currentTimeMillis()
                    )
            );


            int orderResult =
                    orderPs.executeUpdate();


            if (orderResult == 0) {

                orderPs.close();

                con.rollback();

                response.sendRedirect(
                        "checkout.jsp?error=failed"
                );

                return;
            }


            // =========================
            // GET GENERATED ORDER ID
            // =========================

            int orderId = 0;

            ResultSet generatedKeys =
                    orderPs.getGeneratedKeys();


            if (generatedKeys.next()) {

                orderId =
                        generatedKeys.getInt(1);

            } else {

                generatedKeys.close();
                orderPs.close();

                con.rollback();

                response.sendRedirect(
                        "checkout.jsp?error=failed"
                );

                return;
            }


            generatedKeys.close();
            orderPs.close();


            // =========================
            // INSERT ORDER ITEMS
            // =========================

            String itemSql =
                    "INSERT INTO order_items "
                  + "(order_id, product_id, quantity, price) "
                  + "VALUES (?, ?, ?, ?)";

            PreparedStatement itemPs =
                    con.prepareStatement(itemSql);


            String itemsSql =
                    "SELECT c.product_id, c.quantity, p.price "
                  + "FROM cart c "
                  + "JOIN products p "
                  + "ON c.product_id = p.id "
                  + "WHERE c.user_id = ?";


            PreparedStatement itemsSelectPs =
                    con.prepareStatement(itemsSql);

            itemsSelectPs.setInt(
                    1,
                    userId
            );


            ResultSet itemsRs =
                    itemsSelectPs.executeQuery();


            while (itemsRs.next()) {

                int productId =
                        itemsRs.getInt("product_id");

                int quantity =
                        itemsRs.getInt("quantity");

                double price =
                        itemsRs.getDouble("price");


                itemPs.setInt(
                        1,
                        orderId
                );

                itemPs.setInt(
                        2,
                        productId
                );

                itemPs.setInt(
                        3,
                        quantity
                );

                itemPs.setDouble(
                        4,
                        price
                );

                itemPs.addBatch();
            }


            itemPs.executeBatch();


            itemsRs.close();
            itemsSelectPs.close();
            itemPs.close();


            // =========================
            // REDUCE PRODUCT STOCK
            // =========================

            String stockSql =
                    "SELECT product_id, quantity "
                  + "FROM cart "
                  + "WHERE user_id = ?";


            PreparedStatement stockSelectPs =
                    con.prepareStatement(stockSql);

            stockSelectPs.setInt(
                    1,
                    userId
            );


            ResultSet stockRs =
                    stockSelectPs.executeQuery();


            String updateStockSql =
                    "UPDATE products "
                  + "SET quantity = quantity - ? "
                  + "WHERE id = ? "
                  + "AND quantity >= ?";


            PreparedStatement stockUpdatePs =
                    con.prepareStatement(updateStockSql);


            while (stockRs.next()) {

                int productId =
                        stockRs.getInt("product_id");

                int quantity =
                        stockRs.getInt("quantity");


                stockUpdatePs.setInt(
                        1,
                        quantity
                );

                stockUpdatePs.setInt(
                        2,
                        productId
                );

                stockUpdatePs.setInt(
                        3,
                        quantity
                );


                int updated =
                        stockUpdatePs.executeUpdate();


                // Stock changed between
                // initial check and update
                if (updated == 0) {

                    stockRs.close();
                    stockSelectPs.close();
                    stockUpdatePs.close();

                    con.rollback();

                    response.sendRedirect(
                            "cart?error=stock"
                    );

                    return;
                }
            }


            stockRs.close();
            stockSelectPs.close();
            stockUpdatePs.close();


            // =========================
            // CLEAR CART
            // =========================

            String clearCartSql =
                    "DELETE FROM cart "
                  + "WHERE user_id = ?";


            PreparedStatement clearPs =
                    con.prepareStatement(
                            clearCartSql
                    );


            clearPs.setInt(
                    1,
                    userId
            );


            clearPs.executeUpdate();

            clearPs.close();


            // =========================
            // COMMIT TRANSACTION
            // =========================

            con.commit();


            // =========================
            // ORDER SUCCESS
            // =========================

            response.sendRedirect(
                    "order-success.jsp?orderId="
                    + orderId
            );


        } catch (Exception e) {

            e.printStackTrace();


            // =========================
            // ROLLBACK
            // =========================

            try {

                if (con != null) {
                    con.rollback();
                }

            } catch (Exception rollbackError) {

                rollbackError.printStackTrace();
            }


            response.sendRedirect(
                    "checkout.jsp?error=failed"
            );


        } finally {

            // =========================
            // CLOSE CONNECTION
            // =========================

            try {

                if (con != null) {

                    con.setAutoCommit(true);
                    con.close();
                }

            } catch (Exception e) {

                e.printStackTrace();
            }
        }
    }
}