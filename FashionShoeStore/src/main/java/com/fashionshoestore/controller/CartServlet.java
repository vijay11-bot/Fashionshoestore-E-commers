package com.fashionshoestore.controller;

import java.io.IOException;

import com.fashionshoestore.dao.CartDAO;
import com.fashionshoestore.dao.ProductDAO;
import com.fashionshoestore.model.Cart;
import com.fashionshoestore.model.Product;
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
    private CartDAO cartDAO = new CartDAO();
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        request.setAttribute(
                "cartItems",
                cartService.getCartItems(user.getId())
        );

        request.setAttribute(
                "products",
                productDAO.getAllProducts()
        );

        request.getRequestDispatcher("cart.jsp")
               .forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        String action = request.getParameter("action");


        // =========================
        // ADD TO CART
        // =========================

        if (action == null || "add".equals(action)) {

            try {

                int productId =
                        Integer.parseInt(
                                request.getParameter("productId")
                        );

                int quantity =
                        Integer.parseInt(
                                request.getParameter("quantity")
                        );

                if (quantity <= 0) {
                    response.sendRedirect("products");
                    return;
                }

                Product product =
                        productDAO.getProductById(productId);

                if (product == null) {
                    response.sendRedirect("products");
                    return;
                }

                if (product.getQuantity() < quantity) {
                    response.sendRedirect(
                            "cart?error=stock"
                    );
                    return;
                }

                Cart cart = new Cart();

                cart.setUserId(user.getId());
                cart.setProductId(productId);
                cart.setQuantity(quantity);

                cartService.addToCart(cart);

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("products");
                return;
            }
        }


        // =========================
        // UPDATE QUANTITY
        // =========================

        else if ("update".equals(action)) {

            try {

                int cartId =
                        Integer.parseInt(
                                request.getParameter("cartId")
                        );

                int quantity =
                        Integer.parseInt(
                                request.getParameter("quantity")
                        );

                if (quantity <= 0) {
                    response.sendRedirect("cart");
                    return;
                }

                /*
                 * IMPORTANT:
                 * Verify that this cart item belongs
                 * to the logged-in user.
                 */
                Cart cart =
                        cartDAO.getCartById(cartId);

                if (cart == null ||
                    cart.getUserId() != user.getId()) {

                    response.sendRedirect("cart");
                    return;
                }

                Product product =
                        productDAO.getProductById(
                                cart.getProductId()
                        );

                if (product == null) {
                    response.sendRedirect("cart");
                    return;
                }

                if (quantity > product.getQuantity()) {

                    response.sendRedirect(
                            "cart?error=stock"
                    );
                    return;
                }

                cartService.updateQuantity(
                        cartId,
                        quantity
                );

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("cart");
                return;
            }
        }


        // =========================
        // REMOVE FROM CART
        // =========================

        else if ("remove".equals(action)) {

            try {

                int cartId =
                        Integer.parseInt(
                                request.getParameter("cartId")
                        );

                /*
                 * Security check:
                 * User can remove only their own cart item.
                 */
                Cart cart =
                        cartDAO.getCartById(cartId);

                if (cart == null ||
                    cart.getUserId() != user.getId()) {

                    response.sendRedirect("cart");
                    return;
                }

                cartService.removeFromCart(cartId);

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("cart");
                return;
            }
        }


        response.sendRedirect("cart");
    }
}