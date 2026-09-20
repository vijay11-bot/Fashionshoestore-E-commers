package com.fashionshoestore.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionshoestore.model.Cart;
import com.fashionshoestore.model.Product;
import com.fashionshoestore.util.DBConnection;

public class CartDAO {

    public boolean addToCart(Cart cart) {
        String checkSql = "SELECT id, quantity FROM cart WHERE user_id = ? AND product_id = ?";
        String updateSql = "UPDATE cart SET quantity = quantity + ? WHERE id = ?";
        String insertSql = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection()) {
            try (PreparedStatement checkPs = con.prepareStatement(checkSql)) {
                checkPs.setInt(1, cart.getUserId());
                checkPs.setInt(2, cart.getProductId());
                try (ResultSet rs = checkPs.executeQuery()) {
                    if (rs.next()) {
                        int cartId = rs.getInt("id");
                        try (PreparedStatement updatePs = con.prepareStatement(updateSql)) {
                            updatePs.setInt(1, cart.getQuantity() > 0 ? cart.getQuantity() : 1);
                            updatePs.setInt(2, cartId);
                            return updatePs.executeUpdate() > 0;
                        }
                    }
                }
            }

            try (PreparedStatement insertPs = con.prepareStatement(insertSql)) {
                insertPs.setInt(1, cart.getUserId());
                insertPs.setInt(2, cart.getProductId());
                insertPs.setInt(3, cart.getQuantity() > 0 ? cart.getQuantity() : 1);
                return insertPs.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Cart> getCartItems(int userId) {
        List<Cart> cartItems = new ArrayList<>();
        String sql = "SELECT c.id AS cart_id, c.user_id, c.product_id, c.quantity, "
                   + "p.name, p.description, p.price, p.quantity AS stock, p.category, p.type, p.image "
                   + "FROM cart c "
                   + "JOIN products p ON c.product_id = p.id "
                   + "WHERE c.user_id = ? "
                   + "ORDER BY c.id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cart cart = new Cart();
                    cart.setId(rs.getInt("cart_id"));
                    cart.setUserId(rs.getInt("user_id"));
                    cart.setProductId(rs.getInt("product_id"));
                    cart.setQuantity(rs.getInt("quantity"));

                    Product p = new Product();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getDouble("price"));
                    p.setQuantity(rs.getInt("stock"));
                    p.setCategory(rs.getString("category"));
                    p.setType(rs.getString("type"));
                    p.setImage(rs.getString("image"));

                    cart.setProduct(p);
                    cartItems.add(cart);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    public Cart getCartById(int cartId) {
        String sql = "SELECT c.id AS cart_id, c.user_id, c.product_id, c.quantity, "
                   + "p.name, p.description, p.price, p.quantity AS stock, p.category, p.type, p.image "
                   + "FROM cart c "
                   + "JOIN products p ON c.product_id = p.id "
                   + "WHERE c.id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Cart cart = new Cart();
                    cart.setId(rs.getInt("cart_id"));
                    cart.setUserId(rs.getInt("user_id"));
                    cart.setProductId(rs.getInt("product_id"));
                    cart.setQuantity(rs.getInt("quantity"));

                    Product p = new Product();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getDouble("price"));
                    p.setQuantity(rs.getInt("stock"));
                    p.setCategory(rs.getString("category"));
                    p.setType(rs.getString("type"));
                    p.setImage(rs.getString("image"));

                    cart.setProduct(p);
                    return cart;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateQuantity(int cartId, int quantity) {
        if (quantity <= 0) {
            return deleteCartItem(cartId);
        }
        String sql = "UPDATE cart SET quantity = ? WHERE id = ?";
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

    public boolean deleteCartItem(int cartId) {
        String sql = "DELETE FROM cart WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean removeFromCart(int userId, int productId) {
        String sql = "DELETE FROM cart WHERE user_id = ? AND product_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean clearCart(int userId) {
        String sql = "DELETE FROM cart WHERE user_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() >= 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public double getCartTotal(int userId) {
        double total = 0.0;
        String sql = "SELECT SUM(c.quantity * p.price) AS total "
                   + "FROM cart c "
                   + "JOIN products p ON c.product_id = p.id "
                   + "WHERE c.user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getDouble("total");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public int getCartCount(int userId) {
        int count = 0;
        String sql = "SELECT SUM(quantity) AS total_items FROM cart WHERE user_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt("total_items");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}