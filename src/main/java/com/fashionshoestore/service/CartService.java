package com.fashionshoestore.service;

import java.util.List;
import com.fashionshoestore.dao.CartDAO;
import com.fashionshoestore.model.Cart;
import com.fashionshoestore.model.CartItem;

public class CartService {

    private CartDAO cartDAO = new CartDAO();

    public Cart getOrCreateCart(int userId) {
        return cartDAO.getOrCreateCart(userId);
    }

    public List<CartItem> getCartItems(int cartId) {
        return cartDAO.getCartItems(cartId);
    }

    public boolean addItem(int userId, int productId, String sizeLabel, int quantity, double unitPrice) {
        return cartDAO.addItem(userId, productId, sizeLabel, quantity, unitPrice);
    }

    public boolean updateQuantity(int cartItemId, int quantity) {
        return cartDAO.updateQuantity(cartItemId, quantity);
    }

    public boolean removeItem(int cartItemId) {
        return cartDAO.removeItem(cartItemId);
    }

    public boolean clearCart(int cartId) {
        return cartDAO.clearCart(cartId);
    }

    public int getCartCount(int userId) {
        return cartDAO.getCartCount(userId);
    }
}