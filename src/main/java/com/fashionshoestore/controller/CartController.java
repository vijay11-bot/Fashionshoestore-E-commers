package com.fashionshoestore.controller;

import com.fashionshoestore.dao.CartDAO;
import com.fashionshoestore.dao.ProductDAO;
import com.fashionshoestore.model.Cart;
import com.fashionshoestore.model.Product;
import com.fashionshoestore.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(urlPatterns = {"/cart", "/cart/add", "/cart/update", "/cart/remove", "/cart/clear"})
public class CartController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CartDAO cartDAO = new CartDAO();
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=Please login to view your cart");
            return;
        }

        String path = request.getServletPath();

        if ("/cart/add".equals(path)) {
            handleAdd(request, response, user);
        } else if ("/cart/update".equals(path)) {
            handleUpdate(request, response);
        } else if ("/cart/remove".equals(path)) {
            handleRemove(request, response);
        } else if ("/cart/clear".equals(path)) {
            handleClear(request, response, user);
        } else {
            handleViewCart(request, response, user);
        }
    }

    private void handleViewCart(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {

        Cart cart = cartDAO.getOrCreateCart(user.getUserId());
        request.setAttribute("cart", cart);
        request.setAttribute("cartItems", cart.getItems());
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String sizeLabel = request.getParameter("sizeLabel");
            int quantity = 1;
            String qtyParam = request.getParameter("quantity");
            if (qtyParam != null && !qtyParam.trim().isEmpty()) {
                quantity = Math.max(1, Integer.parseInt(qtyParam.trim()));
            }

            if (sizeLabel == null || sizeLabel.trim().isEmpty()) {
                sizeLabel = "UK 8"; // default fallback size if none selected
            }

            Product product = productDAO.getProductById(productId);
            if (product != null) {
                double unitPrice = product.getDiscountedPrice();
                cartDAO.addItem(user.getUserId(), productId, sizeLabel, quantity, unitPrice);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            cartDAO.updateQuantity(cartItemId, quantity);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void handleRemove(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
            cartDAO.removeItem(cartItemId);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void handleClear(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {

        Cart cart = cartDAO.getOrCreateCart(user.getUserId());
        if (cart != null) {
            cartDAO.clearCart(cart.getCartId());
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
