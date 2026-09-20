package com.fashionshoestore.controller;

import java.io.IOException;
import java.util.List;

import com.fashionshoestore.model.Cart;
import com.fashionshoestore.model.User;
import com.fashionshoestore.model.Wishlist;
import com.fashionshoestore.service.CartService;
import com.fashionshoestore.service.WishlistService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    private WishlistService wishlistService = new WishlistService();
    private CartService cartService = new CartService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        List<Wishlist> wishlistItems = wishlistService.getWishlistItems(user.getId());

        request.setAttribute("wishlistItems", wishlistItems);
        request.getRequestDispatcher("wishlist.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        if (action == null) {
            action = "add";
        }

        String productIdParam = request.getParameter("productId");
        if (productIdParam != null && !productIdParam.trim().isEmpty()) {
            try {
                int productId = Integer.parseInt(productIdParam.trim());

                if ("add".equalsIgnoreCase(action)) {
                    wishlistService.addToWishlist(user.getId(), productId);
                    String redirect = request.getParameter("redirect");
                    if (redirect != null && !redirect.trim().isEmpty()) {
                        response.sendRedirect(redirect);
                        return;
                    }
                    response.sendRedirect("wishlist");
                    return;
                } else if ("remove".equalsIgnoreCase(action)) {
                    wishlistService.removeFromWishlist(user.getId(), productId);
                    response.sendRedirect("wishlist");
                    return;
                } else if ("moveToCart".equalsIgnoreCase(action)) {
                    Cart cart = new Cart();
                    cart.setUserId(user.getId());
                    cart.setProductId(productId);
                    cart.setQuantity(1);
                    cartService.addToCart(cart);
                    wishlistService.removeFromWishlist(user.getId(), productId);
                    response.sendRedirect("cart");
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("wishlist");
    }
}