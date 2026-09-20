package com.fashionshoestore.service;

import java.util.List;
import com.fashionshoestore.dao.CartDAO;
import com.fashionshoestore.model.Cart;

public class CartService {

    private CartDAO cartDAO = new CartDAO();

    public boolean addToCart(Cart cart) {
        return cartDAO.addToCart(cart);
    }

    public List<Cart> getCartItems(int userId) {
        return cartDAO.getCartItems(userId);
    }

    public Cart getCartById(int cartId) {
        return cartDAO.getCartById(cartId);
    }

    public boolean updateQuantity(int cartId, int quantity) {
        return cartDAO.updateQuantity(cartId, quantity);
    }

    public boolean deleteCartItem(int cartId) {
        return cartDAO.deleteCartItem(cartId);
    }

    public boolean removeFromCart(int cartId) {
        return cartDAO.deleteCartItem(cartId);
    }

    public boolean removeFromCart(int userId, int productId) {
        return cartDAO.removeFromCart(userId, productId);
    }

    public boolean clearCart(int userId) {
        return cartDAO.clearCart(userId);
    }

    public double getCartTotal(int userId) {
        return cartDAO.getCartTotal(userId);
    }

    public int getCartCount(int userId) {
        return cartDAO.getCartCount(userId);
    }
}