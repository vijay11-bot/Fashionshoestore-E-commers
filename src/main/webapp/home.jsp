<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionshoestore.model.Product" %>
<%@ page import="com.fashionshoestore.model.Category" %>
<%@ page import="com.fashionshoestore.model.User" %>
<%@ page import="com.fashionshoestore.dao.ProductDAO" %>
<%@ page import="com.fashionshoestore.dao.CategoryDAO" %>
<%
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    List<Product> featuredProducts = (List<Product>) request.getAttribute("featuredProducts");

    if (categories == null || featuredProducts == null) {
        CategoryDAO catDAO = new CategoryDAO();
        ProductDAO prodDAO = new ProductDAO();
        categories = catDAO.getAllCategories();
        featuredProducts = prodDAO.getFeaturedProducts(8);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sole Mate | Premium Fashion Shoe Store</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* Hero Section */
        .hero-section {
            background: linear-gradient(135deg, #f4eee7 0%, #e8ded4 100%);
            padding: 70px 5%;
            border-bottom: 1px solid #dfd3c7;
        }
        .hero-container {
            max-width: 1300px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 1.2fr 1fr;
            align-items: center;
            gap: 50px;
        }
        @media (max-width: 850px) {
            .hero-container {
                grid-template-columns: 1fr;
                text-align: center;
            }
        }
        .hero-tagline {
            display: inline-block;
            font-size: 13px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: #8a5a2b;
            margin-bottom: 15px;
        }
        .hero-title {
            font-family: 'DM Serif Display', serif;
            font-size: 54px;
            line-height: 1.15;
            color: #222;
            margin-bottom: 20px;
        }
        .hero-desc {
            font-size: 17px;
            color: #555;
            line-height: 1.6;
            margin-bottom: 30px;
            max-width: 500px;
        }
        .hero-cta-btn {
            display: inline-block;
            background: #222;
            color: #fff;
            padding: 16px 36px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 700;
            text-decoration: none;
            transition: all 0.2s ease;
        }
        .hero-cta-btn:hover {
            background: #8a5a2b;
            transform: translateY(-2px);
        }
        .hero-img-box {
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .hero-img-box img {
            max-width: 100%;
            height: auto;
            filter: drop-shadow(0 15px 30px rgba(0,0,0,0.15));
            border-radius: 12px;
        }

        /* Categories Section */
        .home-section {
            max-width: 1300px;
            margin: 70px auto;
            padding: 0 20px;
        }
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-bottom: 35px;
        }
        .section-title {
            font-family: 'DM Serif Display', serif;
            font-size: 36px;
            color: #222;
        }
        .view-all-link {
            color: #8a5a2b;
            text-decoration: none;
            font-weight: 700;
            font-size: 15px;
        }
        .categories-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }
        @media (max-width: 768px) {
            .categories-grid {
                grid-template-columns: 1fr;
            }
        }
        .category-card {
            background: #fff;
            border-radius: 14px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            text-decoration: none;
            color: inherit;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 200px;
            border: 1.5px solid transparent;
            transition: all 0.2s ease;
        }
        .category-card:hover {
            border-color: #8a5a2b;
            transform: translateY(-5px);
        }
        .category-card h3 {
            font-family: 'DM Serif Display', serif;
            font-size: 28px;
            margin-bottom: 8px;
        }
        .category-card p {
            color: #777;
            font-size: 14px;
            line-height: 1.5;
        }
        .cat-explore-arrow {
            font-weight: 700;
            color: #8a5a2b;
            font-size: 14px;
            margin-top: 20px;
        }

        /* Featured Shoes Grid */
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
            transition: transform 0.2s ease;
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
    </style>
</head>
<body>

    <jsp:include page="/includes/navbar.jsp" />

    <!-- HERO BANNER -->
    <section class="hero-section">
        <div class="hero-container">
            <div>
                <span class="hero-tagline">Step Into Supreme Style</span>
                <h1 class="hero-title">Crafted for Comfort. Designed for Distinction.</h1>
                <p class="hero-desc">Discover precision-engineered sneakers, handcrafted Italian leather formals, and everyday relaxed loafers built for ultimate durability.</p>
                <a href="<%= request.getContextPath() %>/products" class="hero-cta-btn">Explore Collection &rarr;</a>
            </div>
            <div class="hero-img-box">
                <img src="<%= request.getContextPath() %>/images/shoe5.jpg" alt="Featured Running Shoe">
            </div>
        </div>
    </section>

    <!-- CATEGORIES SHOWCASE -->
    <section class="home-section">
        <div class="section-header">
            <div>
                <h2 class="section-title">Shop by Category</h2>
                <p style="color: #777; font-size: 15px; margin-top: 5px;">Explore curated collections engineered for every foot.</p>
            </div>
        </div>

        <div class="categories-grid">
            <a href="<%= request.getContextPath() %>/products?category=Men" class="category-card">
                <div>
                    <h3>Men's Footwear</h3>
                    <p>Sports runners, wingtip brogues, and streetwear high-tops.</p>
                </div>
                <div class="cat-explore-arrow">Explore Men &rarr;</div>
            </a>

            <a href="<%= request.getContextPath() %>/products?category=Women" class="category-card">
                <div>
                    <h3>Women's Footwear</h3>
                    <p>Featherlight racers, stiletto pumps, and chunky platforms.</p>
                </div>
                <div class="cat-explore-arrow">Explore Women &rarr;</div>
            </a>

            <a href="<%= request.getContextPath() %>/products?category=Kids" class="category-card">
                <div>
                    <h3>Kids' Footwear</h3>
                    <p>School uniforms, playground trainers, and LED light-up shoes.</p>
                </div>
                <div class="cat-explore-arrow">Explore Kids &rarr;</div>
            </a>
        </div>
    </section>

    <!-- FEATURED SHOES GRID -->
    <section class="home-section">
        <div class="section-header">
            <div>
                <h2 class="section-title">Trending Footwear</h2>
                <p style="color: #777; font-size: 15px; margin-top: 5px;">Highest rated styles with limited-time member savings.</p>
            </div>
            <a href="<%= request.getContextPath() %>/products" class="view-all-link">View All Shoes &rarr;</a>
        </div>

        <div class="products-grid">
            <% if (featuredProducts != null) {
                for (Product p : featuredProducts) {
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
               } %>
        </div>
    </section>

    <jsp:include page="/includes/footer.jsp" />

</body>
</html>