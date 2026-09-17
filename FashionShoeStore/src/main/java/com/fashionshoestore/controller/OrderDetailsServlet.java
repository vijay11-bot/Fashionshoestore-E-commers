package com.fashionshoestore.controller;

import java.io.IOException;
import java.util.List;

import com.fashionshoestore.model.Order;
import com.fashionshoestore.model.OrderItem;
import com.fashionshoestore.model.User;
import com.fashionshoestore.service.OrderItemService;
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
    private OrderItemService orderItemService = new OrderItemService();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // User must be logged in
        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User user =
                (User) session.getAttribute("user");

        String orderIdParameter =
                request.getParameter("orderId");

        if (orderIdParameter == null ||
            orderIdParameter.trim().isEmpty()) {

            response.sendRedirect("my-orders");
            return;
        }

        try {

            int orderId =
                    Integer.parseInt(orderIdParameter);

            // IMPORTANT:
            // Check that this order belongs
            // to the logged-in user.
            Order order =
                    orderService.getOrderByIdAndUser(
                            orderId,
                            user.getId()
                    );

            if (order == null) {

                response.sendRedirect("my-orders");
                return;
            }

            // Get order items
            List<OrderItem> items =
                    orderItemService.getOrderItems(orderId);

            request.setAttribute("order", order);
            request.setAttribute("orderId", orderId);
            request.setAttribute("orderItems", items);

            request.getRequestDispatcher(
                    "order-details.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect("my-orders");
        }
    }
}