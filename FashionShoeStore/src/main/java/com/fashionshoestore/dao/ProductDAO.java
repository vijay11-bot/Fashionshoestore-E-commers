package com.fashionshoestore.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionshoestore.model.Product;
import com.fashionshoestore.util.DBConnection;

public class ProductDAO {

    // Get all products
    public List<Product> getAllProducts() {

        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM products";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                products.add(mapProduct(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    // Search products and filter by category
    public List<Product> searchProducts(String search, String category) {

        List<Product> products = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT * FROM products WHERE 1=1"
        );

        List<String> parameters = new ArrayList<>();

        // Search by product name or description
        if (search != null && !search.trim().isEmpty()) {

            sql.append(
                " AND (name LIKE ? OR description LIKE ?)"
            );

            String searchValue = "%" + search.trim() + "%";

            parameters.add(searchValue);
            parameters.add(searchValue);
        }

        // Filter by category
        if (category != null && !category.trim().isEmpty()) {

            sql.append(" AND category = ?");

            parameters.add(category.trim());
        }

        sql.append(" ORDER BY id DESC");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            // Set parameters
            for (int i = 0; i < parameters.size(); i++) {
                ps.setString(i + 1, parameters.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    products.add(mapProduct(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }
 // Get product by ID
    public Product getProductById(int productId) {

        Product product = null;

        String sql = "SELECT * FROM products WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    product = mapProduct(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return product;
    }


    // Convert database row into Product object
    private Product mapProduct(ResultSet rs) throws Exception {

        Product product = new Product();

        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setQuantity(rs.getInt("quantity"));
        product.setCategory(rs.getString("category"));
        product.setImage(rs.getString("image"));

        return product;
    }
}