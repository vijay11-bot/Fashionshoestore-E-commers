package com.fashionshoestore.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionshoestore.model.Product;
import com.fashionshoestore.util.DBConnection;

public class WishlistDAO {

    // =========================
    // ADD TO WISHLIST
    // =========================

    public boolean addToWishlist(int userId, int productId) {

        String sql = "INSERT INTO wishlist "
                   + "(user_id, product_id) "
                   + "VALUES (?, ?)";

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


    // =========================
    // REMOVE FROM WISHLIST
    // =========================

    public boolean removeFromWishlist(int userId, int productId) {

        String sql = "DELETE FROM wishlist "
                   + "WHERE user_id = ? AND product_id = ?";

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


    // =========================
    // GET USER WISHLIST
    // =========================

    public List<Product> getWishlist(int userId) {

        List<Product> products = new ArrayList<>();

        String sql =
                "SELECT p.* "
              + "FROM wishlist w "
              + "JOIN products p "
              + "ON w.product_id = p.id "
              + "WHERE w.user_id = ? "
              + "ORDER BY w.id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Product product = new Product();

                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("name"));
                    product.setDescription(
                            rs.getString("description"));
                    product.setPrice(
                            rs.getDouble("price"));
                    product.setQuantity(
                            rs.getInt("quantity"));
                    product.setCategory(
                            rs.getString("category"));
                    product.setImage(
                            rs.getString("image"));

                    products.add(product);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    // =========================
    // CHECK WISHLIST
    // =========================

    public boolean isInWishlist(int userId, int productId) {

        String sql =
                "SELECT id FROM wishlist "
              + "WHERE user_id = ? "
              + "AND product_id = ?";

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
}