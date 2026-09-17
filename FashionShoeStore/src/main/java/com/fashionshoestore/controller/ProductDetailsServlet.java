package com.fashionshoestore.controller;

import java.io.IOException;

import com.fashionshoestore.dao.ProductDAO;
import com.fashionshoestore.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/product-details")
public class ProductDetailsServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect("products");
            return;
        }

        try {
            int productId = Integer.parseInt(id);

            Product product = productDAO.getProductById(productId);

            if (product == null) {
                response.sendRedirect("products");
                return;
            }

            request.setAttribute("product", product);

            request.getRequestDispatcher("product-details.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("products");
        }
    }
}