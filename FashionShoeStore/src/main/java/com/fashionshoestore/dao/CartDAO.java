package com.fashionshoestore.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionshoestore.model.Cart;
import com.fashionshoestore.util.DBConnection;

public class CartDAO {

    // =========================
    // ADD TO CART
    // =========================

    public boolean addToCart(Cart cart) {

        String sql = "INSERT INTO cart "
                   + "(user_id, product_id, quantity) "
                   + "VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cart.getUserId());
            ps.setInt(2, cart.getProductId());
            ps.setInt(3, cart.getQuantity());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================
    // GET USER CART
    // =========================

    public List<Cart> getCartItems(int userId) {

        List<Cart> cartItems = new ArrayList<>();

        String sql = "SELECT * FROM cart "
                   + "WHERE user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Cart cart = new Cart();

                    cart.setId(rs.getInt("id"));
                    cart.setUserId(rs.getInt("user_id"));
                    cart.setProductId(rs.getInt("product_id"));
                    cart.setQuantity(rs.getInt("quantity"));

                    cartItems.add(cart);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cartItems;
    }


    // =========================
    // GET CART BY ID
    // =========================

    public Cart getCartById(int cartId) {

        Cart cart = null;

        String sql = "SELECT * FROM cart "
                   + "WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    cart = new Cart();

                    cart.setId(rs.getInt("id"));
                    cart.setUserId(rs.getInt("user_id"));
                    cart.setProductId(rs.getInt("product_id"));
                    cart.setQuantity(rs.getInt("quantity"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cart;
    }


    // =========================
    // GET CART TOTAL
    // =========================

    public double getCartTotal(int userId) {

        double total = 0;

        String sql = "SELECT c.quantity, p.price "
                   + "FROM cart c "
                   + "JOIN products p "
                   + "ON c.product_id = p.id "
                   + "WHERE c.user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    int quantity =
                            rs.getInt("quantity");

                    double price =
                            rs.getDouble("price");

                    total += quantity * price;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }


    // =========================
    // UPDATE QUANTITY
    // =========================

    public boolean updateQuantity(int cartId,
                                  int quantity) {

        String sql = "UPDATE cart "
                   + "SET quantity = ? "
                   + "WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, cartId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================
    // REMOVE FROM CART
    // =========================

    public boolean removeFromCart(int cartId) {

        String sql = "DELETE FROM cart "
                   + "WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}