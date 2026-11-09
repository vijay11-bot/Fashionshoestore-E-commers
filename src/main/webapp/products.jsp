<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionshoestore.model.Product" %>
<%@ page import="com.fashionshoestore.model.Category" %>
<%@ page import="com.fashionshoestore.model.User" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    Integer selectedCategoryId = (Integer) request.getAttribute("selectedCategoryId");
    String searchQuery = (String) request.getAttribute("searchQuery");
    String sort = (String) request.getAttribute("sort");

    if (products == null) {
        response.sendRedirect(request.getContextPath() + "/products");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Footwear Collection | Sole Mate</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .shop-page {
            max-width: 1300px;
            margin: 40px auto 80px;
            padding: 0 20px;
        }
        .shop-header {
            text-align: center;
            margin-bottom: 35px;
        }
        .shop-header h1 {
            font-family: 'DM Serif Display', serif;
            font-size: 42px;
            margin-bottom: 8px;
        }
        .shop-toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
            background: #fff;
            padding: 18px 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.04);
            margin-bottom: 35px;
        }
        .category-tabs {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        .cat-tab {
            padding: 8px 18px;
            border-radius: 20px;
            border: 1.5px solid #d5c8be;
            background: #fff;
            color: #444;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.2s ease;
        }
        .cat-tab:hover {
            border-color: #222;
            color: #222;
        }
        .cat-tab.active {
            background: #222;
            color: #fff;
            border-color: #222;
        }
        .filter-controls {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .search-box {
            display: flex;
            align-items: center;
            border: 1.5px solid #d5c8be;
            border-radius: 20px;
            padding: 6px 14px;
            background: #fdfaf6;
        }
        .search-input {
            border: none;
            background: transparent;
            font-size: 14px;
            outline: none;
            width: 170px;
        }
        .sort-select {
            padding: 8px 14px;
            border: 1.5px solid #d5c8be;
            border-radius: 20px;
            background: #fff;
            font-size: 13px;
            font-weight: 600;
            outline: none;
            cursor: pointer;
        }
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(270px, 1fr));
            gap: 30px;
        }
        .product-card {
            background: #fff;
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            display: flex;
            flex-direction: column;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            position: relative;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .card-img-wrapper {
            height: 250px;
            background: #fbf7f2;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
        }
        .card-img-wrapper img {
            max-width: 90%;
            max-height: 90%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }
        .product-card:hover .card-img-wrapper img {
            transform: scale(1.05);
        }
        .badge-discount {
            position: absolute;
            top: 15px;
            left: 15px;
            background: #e74c3c;
            color: #fff;
            font-size: 11px;
            font-weight: 700;
            padding: 4px 8px;
            border-radius: 4px;
        }
        .card-content {
            padding: 22px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }
        .card-cat {
            font-size: 11px;
            font-weight: 700;
            color: #8a5a2b;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 6px;
        }
        .card-title {
            font-size: 16px;
            font-weight: 600;
            color: #222;
            margin-bottom: 12px;
            line-height: 1.4;
            min-height: 44px;
        }
        .card-price-row {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: auto;
            margin-bottom: 16px;
        }
        .card-price-final {
            font-size: 18px;
            font-weight: 700;
            color: #222;
        }
        .card-price-orig {
            font-size: 14px;
            color: #999;
            text-decoration: line-through;
        }
        .btn-card-action {
            display: block;
            text-align: center;
            background: #222;
            color: #fff;
            padding: 11px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            transition: background 0.2s ease;
        }
        .btn-card-action:hover {
            background: #8a5a2b;
        }
        .no-products {
            grid-column: 1 / -1;
            text-align: center;
            padding: 60px 20px;
            background: #fff;
            border-radius: 12px;
        }
    </style>
</head>
<body>

    <jsp:include page="/includes/navbar.jsp" />

    <div class="shop-page">
        <div class="shop-header">
            <h1>Footwear Collection</h1>
            <p style="color: #777;">Browse through <%= products != null ? products.size() : 0 %> premium styles for Men, Women, and Kids.</p>
        </div>

        <!-- Filter & Search Toolbar -->
        <div class="shop-toolbar">
            <div class="category-tabs">
                <a href="<%= request.getContextPath() %>/products" class="cat-tab <%= selectedCategoryId == null ? "active" : "" %>">All Shoes</a>
                <a href="<%= request.getContextPath() %>/products?category=Men" class="cat-tab <%= (selectedCategoryId != null && selectedCategoryId == 1) ? "active" : "" %>">Men</a>
                <a href="<%= request.getContextPath() %>/products?category=Women" class="cat-tab <%= (selectedCategoryId != null && selectedCategoryId == 2) ? "active" : "" %>">Women</a>
                <a href="<%= request.getContextPath() %>/products?category=Kids" class="cat-tab <%= (selectedCategoryId != null && selectedCategoryId == 3) ? "active" : "" %>">Kids</a>
            </div>

            <form action="<%= request.getContextPath() %>/products" method="GET" class="filter-controls">
                <% if (selectedCategoryId != null) { %>
                    <input type="hidden" name="categoryId" value="<%= selectedCategoryId %>">
                <% } %>
                <div class="search-box">
                    <input type="text" name="search" placeholder="Search shoes..." class="search-input" value="<%= searchQuery != null ? searchQuery : "" %>">
                    <button type="submit" style="background:none; border:none; cursor:pointer;">&#128269;</button>
                </div>
                <select name="sort" class="sort-select" onchange="this.form.submit()">
                    <option value="" <%= sort == null || sort.isEmpty() ? "selected" : "" %>>Featured</option>
                    <option value="price_asc" <%= "price_asc".equals(sort) ? "selected" : "" %>>Price: Low to High</option>
                    <option value="price_desc" <%= "price_desc".equals(sort) ? "selected" : "" %>>Price: High to Low</option>
                    <option value="discount" <%= "discount".equals(sort) ? "selected" : "" %>>Highest Discount</option>
                </select>
            </form>
        </div>

        <!-- Products Grid -->
        <div class="products-grid">
            <% if (products != null && !products.isEmpty()) {
                for (Product p : products) {
            %>
                <div class="product-card">
                    <div class="card-img-wrapper">
                        <% if (p.getDiscountPercent() > 0) { %>
                            <span class="badge-discount"><%= (int) p.getDiscountPercent() %>% OFF</span>
                        <% } %>
                        <img src="<%= request.getContextPath() %>/<%= p.getImageUrl() %>" alt="<%= p.getProductName() %>">
                    </div>
                    <div class="card-content">
                        <span class="card-cat"><%= p.getCategory() %></span>
                        <h3 class="card-title"><%= p.getProductName() %></h3>
                        <div class="card-price-row">
                            <span class="card-price-final">&#8377;<%= String.format("%.2f", p.getDiscountedPrice()) %></span>
                            <% if (p.getDiscountPercent() > 0) { %>
                                <span class="card-price-orig">&#8377;<%= String.format("%.2f", p.getPrice()) %></span>
                            <% } %>
                        </div>
                        <a href="<%= request.getContextPath() %>/product-details?id=<%= p.getProductId() %>" class="btn-card-action">Select Size &rarr;</a>
                    </div>
                </div>
            <%   }
               } else { %>
                <div class="no-products">
                    <h3>No shoes matched your selection.</h3>
                    <p style="color: #777; margin-top: 10px;">Try clearing filters or search terms.</p>
                    <a href="<%= request.getContextPath() %>/products" class="cat-tab active" style="display:inline-block; margin-top:15px;">Reset All Filters</a>
                </div>
            <% } %>
        </div>
    </div>

    <jsp:include page="/includes/footer.jsp" />

</body>
</html>