package com.fashionshoestore.controller;

import java.io.IOException;
import java.util.List;

import com.fashionshoestore.model.Order;
import com.fashionshoestore.model.User;
import com.fashionshoestore.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/my-orders")
public class MyOrdersServlet extends HttpServlet {

    private OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Get logged-in user
        User user =
                (User) session.getAttribute("user");

        // Get user's orders
        List<Order> orders =
                orderService.getOrdersByUser(user.getId());

        // Send orders to JSP
        request.setAttribute("orders", orders);

        // Open My Orders page
        request.getRequestDispatcher("my-orders.jsp")
               .forward(request, response);
    }
}