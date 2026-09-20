package com.fashionshoestore.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionshoestore.model.Product;
import com.fashionshoestore.model.Wishlist;
import com.fashionshoestore.util.DBConnection;

public class WishlistDAO {

    // Add product to wishlist (only if not already present)
    public boolean addToWishlist(int userId, int productId) {
        if (isInWishlist(userId, productId)) {
            return true;
        }

        String sql = "INSERT INTO wishlist (user_id, product_id) VALUES (?, ?)";

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

    // Remove product from wishlist
    public boolean removeFromWishlist(int userId, int productId) {
        String sql = "DELETE FROM wishlist WHERE user_id = ? AND product_id = ?";

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

    // Check if product is in user's wishlist
    public boolean isInWishlist(int userId, int productId) {
        String sql = "SELECT id FROM wishlist WHERE user_id = ? AND product_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all wishlist items with joined product details
    public List<Wishlist> getWishlistItems(int userId) {
        List<Wishlist> items = new ArrayList<>();
        String sql = "SELECT w.id AS wishlist_id, w.user_id, w.product_id, "
                   + "p.name, p.description, p.price, p.quantity AS stock, p.category, p.type, p.image "
                   + "FROM wishlist w "
                   + "JOIN products p ON w.product_id = p.id "
                   + "WHERE w.user_id = ? "
                   + "ORDER BY w.id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Wishlist w = new Wishlist();
                    w.setId(rs.getInt("wishlist_id"));
                    w.setUserId(rs.getInt("user_id"));
                    w.setProductId(rs.getInt("product_id"));

                    Product p = new Product();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getDouble("price"));
                    p.setQuantity(rs.getInt("stock"));
                    p.setCategory(rs.getString("category"));
                    p.setType(rs.getString("type"));
                    p.setImage(rs.getString("image"));

                    w.setProduct(p);
                    items.add(w);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }

    // Get wishlist count
    public int getWishlistCount(int userId) {
        String sql = "SELECT COUNT(*) FROM wishlist WHERE user_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
