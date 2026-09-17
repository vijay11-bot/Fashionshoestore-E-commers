package com.fashionshoestore.controller;

import java.io.IOException;

import com.fashionshoestore.model.User;
import com.fashionshoestore.service.WishlistService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    private WishlistService wishlistService =
            new WishlistService();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User user =
                (User) session.getAttribute("user");

        request.setAttribute(
                "wishlist",
                wishlistService.getWishlist(user.getId())
        );

        request.getRequestDispatcher(
                "wishlist.jsp"
        ).forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User user =
                (User) session.getAttribute("user");

        String productIdParameter =
                request.getParameter("productId");

        String action =
                request.getParameter("action");

        if (productIdParameter == null ||
            productIdParameter.trim().isEmpty()) {

            response.sendRedirect("products");
            return;
        }

        try {

            int productId =
                    Integer.parseInt(productIdParameter);

            int userId = user.getId();

            if ("remove".equals(action)) {

                wishlistService.removeFromWishlist(
                        userId,
                        productId
                );

            } else {

                if (!wishlistService.isInWishlist(
                        userId,
                        productId)) {

                    wishlistService.addToWishlist(
                            userId,
                            productId
                    );
                }
            }

            response.sendRedirect("wishlist");

        } catch (NumberFormatException e) {

            response.sendRedirect("products");
        }
    }
}