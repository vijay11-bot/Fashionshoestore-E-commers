package com.fashionshoestore.service;

import java.util.List;
import com.fashionshoestore.dao.ProductDAO;
import com.fashionshoestore.model.Product;
import com.fashionshoestore.model.ProductSize;

public class ProductService {

    private ProductDAO productDAO = new ProductDAO();

    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }

    public List<Product> getProductsByCategory(int categoryId) {
        return productDAO.getProductsByCategory(categoryId);
    }

    public List<Product> getProductsByCategoryName(String categoryName) {
        return productDAO.getProductsByCategoryName(categoryName);
    }

    public Product getProductById(int id) {
        return productDAO.getProductById(id);
    }

    public List<ProductSize> getSizesByProductId(int productId) {
        return productDAO.getSizesByProductId(productId);
    }

    public List<Product> getFeaturedProducts(int limit) {
        return productDAO.getFeaturedProducts(limit);
    }

    public List<Product> filterProducts(Integer categoryId, String search, Double minPrice, Double maxPrice, String sort) {
        return productDAO.filterProducts(categoryId, search, minPrice, maxPrice, sort);
    }
}
