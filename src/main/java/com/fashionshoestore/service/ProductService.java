package com.fashionshoestore.service;

import java.util.List;
import com.fashionshoestore.dao.ProductDAO;
import com.fashionshoestore.model.Product;

public class ProductService {

    private ProductDAO productDAO = new ProductDAO();

    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }

    public List<Product> getProducts(String category, String type, String search) {
        return productDAO.getProducts(category, type, search);
    }

    public List<Product> searchProducts(String search, String category) {
        return productDAO.searchProducts(search, category);
    }

    public List<Product> getNewArrivals(int limit) {
        return productDAO.getNewArrivals(limit);
    }

    public Product getProductById(int id) {
        return productDAO.getProductById(id);
    }
}
