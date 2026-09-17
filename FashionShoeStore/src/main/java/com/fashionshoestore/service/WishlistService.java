package com.fashionshoestore.service;

import java.util.List;

import com.fashionshoestore.dao.WishlistDAO;
import com.fashionshoestore.model.Product;

public class WishlistService {

    private WishlistDAO wishlistDAO = new WishlistDAO();

    public boolean addToWishlist(int userId, int productId) {
        return wishlistDAO.addToWishlist(userId, productId);
    }

    public boolean removeFromWishlist(int userId, int productId) {
        return wishlistDAO.removeFromWishlist(userId, productId);
    }

    public List<Product> getWishlist(int userId) {
        return wishlistDAO.getWishlist(userId);
    }

    public boolean isInWishlist(int userId, int productId) {
        return wishlistDAO.isInWishlist(userId, productId);
    }
}