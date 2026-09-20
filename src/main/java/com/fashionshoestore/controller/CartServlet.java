package com.fashionshoestore.controller;

import java.io.IOException;
import java.util.List;

import com.fashionshoestore.model.Cart;
import com.fashionshoestore.model.User;
import com.fashionshoestore.service.CartService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

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
        List<Cart> cartItems = cartService.getCartItems(user.getId());
        double cartTotal = cartService.getCartTotal(user.getId());

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", cartTotal);

        request.getRequestDispatcher("cart.jsp").forward(request, response);
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

        switch (action) {
            case "add":
                try {
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    int quantity = 1;
                    if (request.getParameter("quantity") != null) {
                        quantity = Integer.parseInt(request.getParameter("quantity"));
                    }
                    if (quantity < 1) quantity = 1;

                    Cart cart = new Cart();
                    cart.setUserId(user.getId());
                    cart.setProductId(productId);
                    cart.setQuantity(quantity);

                    cartService.addToCart(cart);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;

            case "update":
                try {
                    int cartId = Integer.parseInt(request.getParameter("cartId"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    cartService.updateQuantity(cartId, quantity);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;

            case "remove":
                try {
                    int cartId = Integer.parseInt(request.getParameter("cartId"));
                    cartService.deleteCartItem(cartId);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;

            case "clear":
                cartService.clearCart(user.getId());
                break;
        }

        response.sendRedirect("cart");
    }
}