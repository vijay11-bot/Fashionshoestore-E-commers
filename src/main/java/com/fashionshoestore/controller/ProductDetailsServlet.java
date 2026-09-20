package com.fashionshoestore.controller;

import java.io.IOException;

import com.fashionshoestore.model.Product;
import com.fashionshoestore.model.User;
import com.fashionshoestore.service.ProductService;
import com.fashionshoestore.service.WishlistService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({"/product-details", "/product"})
public class ProductDetailsServlet extends HttpServlet {

    private ProductService productService = new ProductService();
    private WishlistService wishlistService = new WishlistService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("products");
            return;
        }

        try {
            int productId = Integer.parseInt(idParam.trim());
            Product product = productService.getProductById(productId);

            if (product == null) {
                response.sendRedirect("products");
                return;
            }

            request.setAttribute("product", product);

            // Check if product is in wishlist
            HttpSession session = request.getSession(false);
            boolean inWishlist = false;
            if (session != null && session.getAttribute("user") != null) {
                User user = (User) session.getAttribute("user");
                inWishlist = wishlistService.isInWishlist(user.getId(), productId);
            }
            request.setAttribute("inWishlist", inWishlist);

            request.getRequestDispatcher("product-details.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("products");
        }
    }
}