package com.fashionshoestore.service;

import java.util.List;

import com.fashionshoestore.dao.ProductDAO;
import com.fashionshoestore.model.Product;

public class ProductService {

    private ProductDAO productDAO = new ProductDAO();

    // Get all products
    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }

    // Search products and filter by category
    public List<Product> searchProducts(String search, String category) {
        return productDAO.searchProducts(search, category);
    }
}