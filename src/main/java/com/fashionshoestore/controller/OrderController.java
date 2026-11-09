package com.fashionshoestore.controller;

import com.fashionshoestore.dao.OrderDAO;
import com.fashionshoestore.model.Order;
import com.fashionshoestore.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/my-orders", "/order-details", "/order-success"})
public class OrderController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=Please login to view orders");
            return;
        }

        String path = request.getServletPath();

        if ("/order-details".equals(path)) {
            handleOrderDetails(request, response, user);
        } else if ("/order-success".equals(path)) {
            handleOrderSuccess(request, response, user);
        } else {
            handleMyOrders(request, response, user);
        }
    }

    private void handleMyOrders(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {

        List<Order> orders = orderDAO.getOrdersByUserId(user.getUserId());
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/my-orders.jsp").forward(request, response);
    }

    private void handleOrderDetails(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {

        String idParam = request.getParameter("orderId");
        if (idParam == null) {
            idParam = request.getParameter("id");
        }

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/my-orders");
            return;
        }

        try {
            int orderId = Integer.parseInt(idParam.trim());
            Order order = orderDAO.getOrderById(orderId);

            if (order == null || order.getUserId() != user.getUserId()) {
                response.sendRedirect(request.getContextPath() + "/my-orders");
                return;
            }

            request.setAttribute("order", order);
            request.setAttribute("orderId", order.getOrderId());
            request.setAttribute("orderItems", order.getItems());
            request.getRequestDispatcher("/order-details.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/my-orders");
        }
    }

    private void handleOrderSuccess(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {

        String idParam = request.getParameter("orderId");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int orderId = Integer.parseInt(idParam.trim());
                Order order = orderDAO.getOrderById(orderId);
                request.setAttribute("order", order);
                request.setAttribute("orderId", orderId);
            } catch (NumberFormatException ignored) {
            }
        }

        request.getRequestDispatcher("/order-success.jsp").forward(request, response);
    }
}
