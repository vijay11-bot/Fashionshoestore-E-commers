package com.fashionshoestore.controller;

import com.fashionshoestore.dao.OrderDAO;
import com.fashionshoestore.dao.UserDAO;
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

@WebServlet(urlPatterns = {"/profile"})
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=Please login to view profile");
            return;
        }

        // Fresh user details from DB
        User freshUser = userDAO.getUserById(user.getUserId());
        if (freshUser != null) {
            session.setAttribute("user", freshUser);
            user = freshUser;
        }

        List<Order> orders = orderDAO.getOrdersByUserId(user.getUserId());
        request.setAttribute("user", user);
        request.setAttribute("recentOrders", orders);

        request.getRequestDispatcher("/profile.jsp").forward(request, response);
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

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");

        if (fullName != null && !fullName.trim().isEmpty()) {
            user.setFullName(fullName.trim());
        }
        user.setPhone(phone != null ? phone.trim() : "");
        user.setGender(gender != null ? gender.trim() : "");
        user.setAddress(address != null ? address.trim() : "");

        boolean success = userDAO.updateProfile(user);
        if (success) {
            session.setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/profile?success=Profile updated successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/profile?error=Failed to update profile");
        }
    }
}
