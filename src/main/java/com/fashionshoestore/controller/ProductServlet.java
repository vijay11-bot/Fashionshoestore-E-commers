package com.fashionshoestore.controller;

import java.io.IOException;
import java.util.List;

import com.fashionshoestore.model.Product;
import com.fashionshoestore.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String category = request.getParameter("category");
        String type = request.getParameter("type");
        String search = request.getParameter("search");

        // Clean values
        if (category != null && (category.trim().isEmpty() || "All".equalsIgnoreCase(category.trim()))) {
            category = null;
        }
        if (type != null && (type.trim().isEmpty() || "All".equalsIgnoreCase(type.trim()))) {
            type = null;
        }
        if (search != null && search.trim().isEmpty()) {
            search = null;
        }

        List<Product> products = productService.getProducts(category, type, search);

        request.setAttribute("products", products);
        request.setAttribute("currentCategory", category);
        request.setAttribute("currentType", type);
        request.setAttribute("currentSearch", search);

        request.getRequestDispatcher("products.jsp").forward(request, response);
    }
}