package com.fashionshoestore.controller;

import java.io.IOException;

import com.fashionshoestore.model.Order;
import com.fashionshoestore.model.User;
import com.fashionshoestore.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/order-details")
public class OrderDetailsServlet extends HttpServlet {

    private OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("my-orders");
            return;
        }

        try {
            int orderId = Integer.parseInt(idParam.trim());
            Order order = orderService.getOrderByIdAndUser(orderId, user.getId());

            if (order == null) {
                response.sendRedirect("my-orders");
                return;
            }

            request.setAttribute("order", order);
            request.getRequestDispatcher("order-details.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("my-orders");
        }
    }
}