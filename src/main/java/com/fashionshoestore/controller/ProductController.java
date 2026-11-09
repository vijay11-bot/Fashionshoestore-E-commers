package com.fashionshoestore.controller;

import com.fashionshoestore.dao.CategoryDAO;
import com.fashionshoestore.dao.ProductDAO;
import com.fashionshoestore.model.Category;
import com.fashionshoestore.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/products", "/product-details", "/home"})
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/product-details".equals(path)) {
            handleProductDetails(request, response);
        } else if ("/home".equals(path)) {
            handleHome(request, response);
        } else {
            handleProductList(request, response);
        }
    }

    private void handleProductList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String categoryParam = request.getParameter("category");
        String categoryIdParam = request.getParameter("categoryId");
        String search = request.getParameter("search");
        String minPriceParam = request.getParameter("minPrice");
        String maxPriceParam = request.getParameter("maxPrice");
        String sort = request.getParameter("sort");

        Integer categoryId = null;
        if (categoryIdParam != null && !categoryIdParam.trim().isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdParam.trim());
            } catch (NumberFormatException ignored) {
            }
        } else if (categoryParam != null && !categoryParam.trim().isEmpty()) {
            Category cat = categoryDAO.getCategoryByName(categoryParam.trim());
            if (cat != null) {
                categoryId = cat.getCategoryId();
            }
        }

        Double minPrice = null;
        if (minPriceParam != null && !minPriceParam.trim().isEmpty()) {
            try {
                minPrice = Double.parseDouble(minPriceParam.trim());
            } catch (NumberFormatException ignored) {
            }
        }

        Double maxPrice = null;
        if (maxPriceParam != null && !maxPriceParam.trim().isEmpty()) {
            try {
                maxPrice = Double.parseDouble(maxPriceParam.trim());
            } catch (NumberFormatException ignored) {
            }
        }

        List<Product> products = productDAO.filterProducts(categoryId, search, minPrice, maxPrice, sort);
        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("selectedCategoryId", categoryId);
        request.setAttribute("selectedCategoryName", categoryParam);
        request.setAttribute("searchQuery", search);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);
        request.setAttribute("sort", sort);

        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }

    private void handleProductDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("products");
            return;
        }

        try {
            int productId = Integer.parseInt(idParam.trim());
            Product product = productDAO.getProductById(productId);

            if (product == null) {
                response.sendRedirect("products");
                return;
            }

            // Related products in the same category
            List<Product> relatedProducts = productDAO.getProductsByCategory(product.getCategoryId());

            request.setAttribute("product", product);
            request.setAttribute("relatedProducts", relatedProducts);
            request.getRequestDispatcher("/product-details.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("products");
        }
    }

    private void handleHome(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Category> categories = categoryDAO.getAllCategories();
        List<Product> featuredProducts = productDAO.getFeaturedProducts(8);
        List<Product> menShoes = productDAO.getProductsByCategory(1);
        List<Product> womenShoes = productDAO.getProductsByCategory(2);
        List<Product> kidsShoes = productDAO.getProductsByCategory(3);

        request.setAttribute("categories", categories);
        request.setAttribute("featuredProducts", featuredProducts);
        request.setAttribute("menShoes", menShoes);
        request.setAttribute("womenShoes", womenShoes);
        request.setAttribute("kidsShoes", kidsShoes);

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
