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
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        String category = request.getParameter("category");

        List<Product> products;

        if ((search != null && !search.trim().isEmpty())
                || (category != null && !category.trim().isEmpty())) {

            products = productService.searchProducts(search, category);

        } else {

            products = productService.getAllProducts();
        }

        request.setAttribute("products", products);

        request.getRequestDispatcher("products.jsp")
               .forward(request, response);
    }
}