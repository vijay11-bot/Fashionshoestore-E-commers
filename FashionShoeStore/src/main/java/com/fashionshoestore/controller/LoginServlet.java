package com.fashionshoestore.controller;

import java.io.IOException;

import com.fashionshoestore.model.User;
import com.fashionshoestore.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userService.loginUser(email, password);
        
        
        System.out.println("LOGIN EMAIL: " + email);
        System.out.println("LOGIN USER: " + user);

        if (user != null) {

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            response.sendRedirect("index.jsp");

        } else {

            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}