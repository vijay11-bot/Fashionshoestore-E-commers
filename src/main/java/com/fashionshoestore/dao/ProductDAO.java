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
        String sql = "SELECT * FROM products ORDER BY id ASC";

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

    // Filter products by category, type, and/or search term
    public List<Product> getProducts(String category, String type, String search) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE 1=1");
        List<Object> parameters = new ArrayList<>();

        if (category != null && !category.trim().isEmpty() && !"All".equalsIgnoreCase(category.trim())) {
            sql.append(" AND category = ?");
            parameters.add(category.trim());
        }

        if (type != null && !type.trim().isEmpty() && !"All".equalsIgnoreCase(type.trim())) {
            sql.append(" AND type = ?");
            parameters.add(type.trim());
        }

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (name LIKE ? OR description LIKE ?)");
            String searchPattern = "%" + search.trim() + "%";
            parameters.add(searchPattern);
            parameters.add(searchPattern);
        }

        sql.append(" ORDER BY id ASC");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
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

    // Overload for backward compatibility
    public List<Product> searchProducts(String search, String category) {
        return getProducts(category, null, search);
    }

    // Get New Arrivals for Homepage
    public List<Product> getNewArrivals(int limit) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products ORDER BY id DESC LIMIT ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);
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

    // Map ResultSet to Product
    private Product mapProduct(ResultSet rs) throws Exception {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setQuantity(rs.getInt("quantity"));
        product.setCategory(rs.getString("category"));
        product.setType(rs.getString("type"));
        product.setImage(rs.getString("image"));
        return product;
    }
}
