package com.fashionshoestore.dao;

import com.fashionshoestore.model.Product;
import com.fashionshoestore.model.ProductSize;
import com.fashionshoestore.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM products p " +
                     "JOIN categories c ON p.category_id = c.category_id " +
                     "WHERE p.is_active = TRUE ORDER BY p.product_id ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM products p " +
                     "JOIN categories c ON p.category_id = c.category_id " +
                     "WHERE p.is_active = TRUE AND p.category_id = ? ORDER BY p.product_id ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapProduct(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsByCategoryName(String categoryName) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM products p " +
                     "JOIN categories c ON p.category_id = c.category_id " +
                     "WHERE p.is_active = TRUE AND LOWER(c.category_name) = LOWER(?) ORDER BY p.product_id ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, categoryName);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapProduct(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Product getProductById(int productId) {
        String sql = "SELECT p.*, c.category_name FROM products p " +
                     "JOIN categories c ON p.category_id = c.category_id " +
                     "WHERE p.product_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Product product = mapProduct(rs);
                    product.setSizes(getSizesByProductId(productId));
                    return product;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<ProductSize> getSizesByProductId(int productId) {
        List<ProductSize> sizes = new ArrayList<>();
        String sql = "SELECT * FROM product_sizes WHERE product_id = ? AND is_available = TRUE ORDER BY product_size_id ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    sizes.add(new ProductSize(
                            rs.getInt("product_size_id"),
                            rs.getInt("product_id"),
                            rs.getString("size_label"),
                            rs.getInt("stock_quantity"),
                            rs.getString("sku_code"),
                            rs.getBoolean("is_available")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sizes;
    }

    public List<Product> getFeaturedProducts(int limit) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM products p " +
                     "JOIN categories c ON p.category_id = c.category_id " +
                     "WHERE p.is_active = TRUE ORDER BY p.discount_percent DESC, p.product_id ASC LIMIT ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapProduct(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> filterProducts(Integer categoryId, String search, Double minPrice, Double maxPrice, String sort) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT p.*, c.category_name FROM products p " +
                "JOIN categories c ON p.category_id = c.category_id " +
                "WHERE p.is_active = TRUE "
        );

        List<Object> params = new ArrayList<>();

        if (categoryId != null && categoryId > 0) {
            sql.append("AND p.category_id = ? ");
            params.add(categoryId);
        }

        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND (LOWER(p.product_name) LIKE ? OR LOWER(p.description) LIKE ?) ");
            String kw = "%" + search.trim().toLowerCase() + "%";
            params.add(kw);
            params.add(kw);
        }

        if (minPrice != null && minPrice > 0) {
            sql.append("AND p.price >= ? ");
            params.add(minPrice);
        }

        if (maxPrice != null && maxPrice > 0) {
            sql.append("AND p.price <= ? ");
            params.add(maxPrice);
        }

        if ("price_asc".equalsIgnoreCase(sort)) {
            sql.append("ORDER BY p.price ASC");
        } else if ("price_desc".equalsIgnoreCase(sort)) {
            sql.append("ORDER BY p.price DESC");
        } else if ("discount".equalsIgnoreCase(sort)) {
            sql.append("ORDER BY p.discount_percent DESC");
        } else {
            sql.append("ORDER BY p.product_id ASC");
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapProduct(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private Product mapProduct(ResultSet rs) throws Exception {
        Product p = new Product(
                rs.getInt("product_id"),
                rs.getInt("category_id"),
                rs.getString("product_name"),
                rs.getString("description"),
                rs.getDouble("price"),
                rs.getDouble("discount_percent"),
                rs.getString("image_url"),
                rs.getBoolean("is_active")
        );
        try {
            p.setCategoryName(rs.getString("category_name"));
        } catch (Exception ignored) {
        }
        return p;
    }
}
