package com.fashionshoestore.service;

import java.util.List;
import com.fashionshoestore.dao.WishlistDAO;
import com.fashionshoestore.model.Wishlist;

public class WishlistService {

    private WishlistDAO wishlistDAO = new WishlistDAO();

    public boolean addToWishlist(int userId, int productId) {
        return wishlistDAO.addToWishlist(userId, productId);
    }

    public boolean removeFromWishlist(int userId, int productId) {
        return wishlistDAO.removeFromWishlist(userId, productId);
    }

    public boolean isInWishlist(int userId, int productId) {
        return wishlistDAO.isInWishlist(userId, productId);
    }

    public List<Wishlist> getWishlistItems(int userId) {
        return wishlistDAO.getWishlistItems(userId);
    }

    public List<Wishlist> getWishlist(int userId) {
        return wishlistDAO.getWishlistItems(userId);
    }

    public int getWishlistCount(int userId) {
        return wishlistDAO.getWishlistCount(userId);
    }
}