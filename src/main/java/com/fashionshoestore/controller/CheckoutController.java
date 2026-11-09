package com.fashionshoestore.controller;

import com.fashionshoestore.dao.CartDAO;
import com.fashionshoestore.dao.OrderDAO;
import com.fashionshoestore.model.Cart;
import com.fashionshoestore.model.Order;
import com.fashionshoestore.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(urlPatterns = {"/checkout"})
public class CheckoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CartDAO cartDAO = new CartDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=Please login to checkout");
            return;
        }

        Cart cart = cartDAO.getOrCreateCart(user.getUserId());
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        request.setAttribute("cart", cart);
        request.setAttribute("cartItems", cart.getItems());
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Cart cart = cartDAO.getOrCreateCart(user.getUserId());
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        String deliveryAddress = request.getParameter("deliveryAddress");
        String paymentMethod = request.getParameter("paymentMethod");

        if (deliveryAddress == null || deliveryAddress.trim().isEmpty()) {
            deliveryAddress = user.getAddress();
        }
        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            paymentMethod = "Cash on Delivery";
        }

        Order order = new Order();
        order.setUserId(user.getUserId());
        order.setTotalAmount(cart.getTotalAmount());
        order.setPaymentMethod(paymentMethod);
        order.setOrderStatus("Confirmed");
        order.setDeliveryAddress(deliveryAddress);

        int orderId = orderDAO.createOrder(order, cart.getItems(), cart.getCartId());

        if (orderId > 0) {
            response.sendRedirect(request.getContextPath() + "/order-success?orderId=" + orderId);
        } else {
            request.setAttribute("error", "Failed to place order. Please try again.");
            request.setAttribute("cart", cart);
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
        }
    }
}
