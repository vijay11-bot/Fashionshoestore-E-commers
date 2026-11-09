package com.fashionshoestore.dao;

import java.util.ArrayList;
import java.util.List;

import com.fashionshoestore.model.Wishlist;

public class WishlistDAO {

    public boolean addToWishlist(int userId, int productId) {
        return true;
    }

    public boolean removeFromWishlist(int userId, int productId) {
        return true;
    }

    public boolean isInWishlist(int userId, int productId) {
        return false;
    }

    public List<Wishlist> getWishlistItems(int userId) {
        return new ArrayList<>();
    }

    public int getWishlistCount(int userId) {
        return 0;
    }
}
