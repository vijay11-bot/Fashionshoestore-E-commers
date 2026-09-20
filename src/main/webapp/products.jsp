<%@ page language="java"

         contentType="text/html; charset=UTF-8"

         pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>

<%@ page import="com.fashionshoestore.model.Product" %>

<%@ page import="com.fashionshoestore.model.User" %>

<%

    List<Product> products =

        (List<Product>) request.getAttribute("products");

    User loggedUser =

        (User) session.getAttribute("user");

%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"

          content="width=device-width, initial-scale=1.0">

    <title>Shop - Sole Mate</title>



    <!-- GOOGLE FONTS -->

    <link rel="preconnect"

          href="https://fonts.googleapis.com">

    <link rel="preconnect"

          href="https://fonts.gstatic.com"

          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap"

          rel="stylesheet">



    <!-- MAIN CSS -->

    <link rel="stylesheet"

          href="<%= request.getContextPath() %>/css/style.css">



    <style>
        /* =====================================================
           HEADER - SAME LAYOUT AS HOME PAGE
           ===================================================== */

        .site-header {
            width: 100%;
            background: #ffffff;
            border-bottom: 1px solid #e7ddd4;
        }

        .header-container {
            width: 92%;
            max-width: 1400px;
            min-height: 105px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 30px;
        }

        .brand {
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 18px;
            text-decoration: none;
            color: #241c18;
            flex-shrink: 0;
        }

        .brand-box {
            width: 56px;
            height: 56px;
            border: 1px solid #2d2926;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-family: "Inter", sans-serif;
            font-size: 18px;
            font-weight: 600;
            letter-spacing: 1px;
            color: #241c18;
        }

        .brand-text {
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .brand-name {
            font-family: "DM Serif Display", serif;
            font-size: 32px;
            line-height: 1;
            letter-spacing: 1px;
            color: #241c18;
        }

        .brand-tagline {
            margin-top: 8px;
            font-family: "Inter", sans-serif;
            font-size: 10px;
            font-weight: 500;
            letter-spacing: 3px;
            color: #a06b45;
        }

        .main-nav {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 28px;
            height: 105px;
            margin-left: auto;
            white-space: nowrap;
        }

        .main-nav a {
            position: relative;
            height: 105px;
            display: flex;
            align-items: center;
            text-decoration: none;
            font-family: "Inter", sans-serif;
            font-size: 14px;
            font-weight: 500;
            color: #241c18;
            transition: 0.3s ease;
        }

        .main-nav a:hover {
            color: #a06b45;
        }

        .main-nav a.active {
            color: #a06b45;
        }

        .main-nav a.active::after {
            content: "";
            position: absolute;
            left: 0;
            bottom: 24px;
            width: 100%;
            height: 2px;
            background: #a06b45;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 18px;
            flex-shrink: 0;
            white-space: nowrap;
        }

        .header-actions a,
        .header-user {
            font-family: "Inter", sans-serif;
            font-size: 13px;
            text-decoration: none;
            color: #241c18;
            white-space: nowrap;
        }

        .header-actions a:hover {
            color: #a06b45;
        }

        @media (max-width: 1200px) {
            .header-container {
                width: 94%;
                gap: 18px;
            }

            .brand {
                gap: 12px;
            }

            .brand-name {
                font-size: 28px;
            }

            .main-nav {
                gap: 16px;
            }

            .main-nav a {
                font-size: 13px;
            }

            .header-actions {
                gap: 10px;
            }

            .header-actions a,
            .header-user {
                font-size: 11px;
            }
        }

        @media (max-width: 900px) {
            .header-container {
                flex-wrap: wrap;
                padding: 15px 0;
            }

            .main-nav {
                order: 3;
                width: 100%;
                height: 48px;
                justify-content: flex-start;
                overflow-x: auto;
                margin-left: 0;
            }

            .main-nav a {
                height: 48px;
                flex-shrink: 0;
            }

            .main-nav a.active::after {
                bottom: 4px;
            }
        }

        @media (max-width: 600px) {
            .brand-box {
                width: 48px;
                height: 48px;
            }

            .brand-name {
                font-size: 25px;
            }

            .brand-tagline {
                font-size: 9px;
                letter-spacing: 2px;
            }

            .header-actions {
                gap: 8px;
            }

            .header-actions a,
            .header-user {
                font-size: 10px;
            }
        }

        /* =====================================================

           SHOP PAGE

           ===================================================== */

        .shop-page {

            width: 92%;

            max-width: 1400px;

            margin: 0 auto;

            padding: 55px 0 80px;

        }



        .shop-heading {

            text-align: center;

            margin-bottom: 35px;

        }



        .shop-small {

            font-family: "Inter", sans-serif;

            font-size: 11px;

            letter-spacing: 3px;

            color: #a06b45;

            margin-bottom: 10px;

        }



        .shop-heading h1 {

            font-family: "DM Serif Display", serif;

            font-size: 44px;

            font-weight: 400;

            line-height: 1.1;

            color: #241c18;

            margin: 0;

        }



        .shop-heading > p:last-child {

            font-family: "Inter", sans-serif;

            font-size: 14px;

            color: #766c66;

            margin-top: 12px;

        }



        /* =====================================================

           SEARCH

           ===================================================== */

        .search-form {

            width: 100%;

            max-width: 650px;

            margin: 0 auto 30px;

            display: flex;

            gap: 10px;

        }



        .search-form input {

            flex: 1;

            height: 45px;

            padding: 0 15px;

            border: 1px solid #d9cec6;

            outline: none;

            font-family: "Inter", sans-serif;

            font-size: 13px;

            color: #241c18;

            background: #ffffff;

        }



        .search-form input:focus {

            border-color: #a06b45;

        }



        .search-form button {

            height: 45px;

            padding: 0 25px;

            border: none;

            background: #2d2926;

            color: #ffffff;

            font-family: "Inter", sans-serif;

            font-size: 13px;

            font-weight: 600;

            cursor: pointer;

            transition: 0.3s ease;

        }



        .search-form button:hover {

            background: #a06b45;

        }



        /* =====================================================

           CATEGORY FILTER

           ===================================================== */

        .category-filter {

            display: flex;

            justify-content: center;

            align-items: center;

            gap: 28px;

            margin-bottom: 40px;

            border-bottom: 1px solid #e7ddd4;

            padding-bottom: 15px;

        }



        .category-filter a {

            position: relative;

            text-decoration: none;

            color: #514842;

            font-family: "Inter", sans-serif;

            font-size: 13px;

            font-weight: 500;

            padding: 5px 0;

        }



        .category-filter a:hover {

            color: #a06b45;

        }



        .category-filter a.active {

            color: #a06b45;

        }



        .category-filter a.active::after {

            content: "";

            position: absolute;

            left: 0;

            right: 0;

            bottom: -1px;

            height: 1px;

            background: #a06b45;

        }



        /* =====================================================

           PRODUCT GRID

           ===================================================== */

        .product-grid {

            display: grid;

            grid-template-columns:

                repeat(4, minmax(0, 1fr));

            gap: 28px;

        }



        .product-card {

            position: relative;

            background: #ffffff;

            border: 1px solid #e7ddd4;

            overflow: hidden;

            transition: 0.3s ease;

        }



        .product-card:hover {

            transform: translateY(-4px);

            box-shadow:

                0 12px 30px rgba(45, 41, 38, 0.08);

        }



        /* =====================================================

           WISHLIST

           ===================================================== */

        .wishlist-form {

            margin: 0;

            padding: 0;

        }



        .wishlist-btn {

            position: absolute;

            top: 15px;

            right: 15px;

            z-index: 5;

            width: 38px;

            height: 38px;

            border: none;

            border-radius: 50%;

            background: #ffffff;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 23px;

            color: #2d2926;

            text-decoration: none;

            cursor: pointer;

            transition: 0.3s ease;

        }



        .wishlist-btn:hover {

            color: #a06b45;

            transform: scale(1.08);

        }



        /* =====================================================

           PRODUCT IMAGE

           ===================================================== */

        .product-image-link {

            display: block;

            text-decoration: none;

        }



        .product-image {

            width: 100%;

            height: 270px;

            background: #f5f0eb;

            overflow: hidden;

        }



        .product-image img {

            width: 100%;

            height: 100%;

            object-fit: cover;

            display: block;

            transition: transform 0.4s ease;

        }



        .product-card:hover .product-image img {

            transform: scale(1.04);

        }



        /* =====================================================

           PRODUCT INFO

           ===================================================== */

        .product-info {

            padding: 20px;

        }



        .product-category {

            margin: 0 0 8px;

            font-family: "Inter", sans-serif;

            font-size: 10px;

            text-transform: uppercase;

            letter-spacing: 1.5px;

            color: #a06b45;

        }



        .product-info h2 {

            margin: 0 0 10px;

            font-family: "DM Serif Display", serif;

            font-size: 22px;

            font-weight: 400;

            line-height: 1.2;

        }



        .product-info h2 a {

            color: #241c18;

            text-decoration: none;

        }



        .product-info h2 a:hover {

            color: #a06b45;

        }



        .product-description {

            margin: 0 0 15px;

            font-family: "Inter", sans-serif;

            font-size: 12px;

            line-height: 1.6;

            color: #766c66;

            min-height: 38px;

        }



        .product-bottom {

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 10px;

            margin-bottom: 15px;

        }



        .product-price {

            font-family: "Inter", sans-serif;

            font-size: 16px;

            font-weight: 700;

            color: #241c18;

        }



        .stock {

            font-family: "Inter", sans-serif;

            font-size: 10px;

            color: #54815d;

            text-transform: uppercase;

            letter-spacing: 0.5px;

        }



        .out-stock {

            font-family: "Inter", sans-serif;

            font-size: 10px;

            color: #a94c38;

            text-transform: uppercase;

            letter-spacing: 0.5px;

        }



        /* =====================================================

           ADD TO CART

           ===================================================== */

        .product-info form {

            margin: 0;

        }



        .add-cart-btn {

            width: 100%;

            height: 42px;

            border: none;

            background: #2d2926;

            color: #ffffff;

            font-family: "Inter", sans-serif;

            font-size: 12px;

            font-weight: 600;

            letter-spacing: 0.8px;

            cursor: pointer;

            transition: 0.3s ease;

        }



        .add-cart-btn:hover {

            background: #a06b45;

        }



        .add-cart-btn:disabled {

            background: #c7beb8;

            cursor: not-allowed;

        }



        /* =====================================================

           NO PRODUCTS

           ===================================================== */

        .no-products {

            grid-column: 1 / -1;

            text-align: center;

            padding: 80px 20px;

            border: 1px solid #e7ddd4;

            background: #fbf7f3;

        }



        .no-products h2 {

            font-family: "DM Serif Display", serif;

            font-size: 32px;

            font-weight: 400;

            color: #241c18;

            margin: 0 0 10px;

        }



        .no-products p {

            font-family: "Inter", sans-serif;

            font-size: 13px;

            color: #766c66;

            margin-bottom: 25px;

        }



        .btn-primary {

            display: inline-block;

            padding: 13px 25px;

            background: #2d2926;

            color: #ffffff;

            text-decoration: none;

            font-family: "Inter", sans-serif;

            font-size: 12px;

            font-weight: 600;

            letter-spacing: 0.8px;

            transition: 0.3s ease;

        }



        .btn-primary:hover {

            background: #a06b45;

        }



        /* =====================================================

           FOOTER

           ===================================================== */

        footer {

            border-top: 1px solid #e7ddd4;

            background: #2d2926;

            color: #ffffff;

            padding: 45px 8% 25px;

            text-align: center;

        }



        .footer-logo h2 {

            font-family: "DM Serif Display", serif;

            font-size: 27px;

            font-weight: 400;

            margin: 0;

        }



        .footer-logo p {

            font-family: "Inter", sans-serif;

            font-size: 12px;

            color: #d7cbc2;

            margin-top: 8px;

        }



        .footer-links {

            display: flex;

            justify-content: center;

            flex-wrap: wrap;

            gap: 25px;

            margin: 25px 0;

        }



        .footer-links a {

            color: #ffffff;

            text-decoration: none;

            font-family: "Inter", sans-serif;

            font-size: 12px;

        }



        .footer-links a:hover {

            color: #d4a27f;

        }



        .copyright {

            border-top: 1px solid #514a45;

            padding-top: 20px;

            margin-top: 20px;

            font-family: "Inter", sans-serif;

            font-size: 11px;

            color: #bfb5ae;

        }



        /* =====================================================

           RESPONSIVE

           ===================================================== */

        @media (max-width: 1150px) {

            .product-grid {

                grid-template-columns:

                    repeat(3, minmax(0, 1fr));

            }



            .brand-container {

                gap: 20px;

            }



            .header-actions {

                gap: 12px;

            }



            .main-nav {

                gap: 24px;

            }

        }



        @media (max-width: 900px) {

            .brand-container {

                min-height: 95px;

            }



            .header-actions {

                flex-wrap: wrap;

                justify-content: flex-end;

            }



            .product-grid {

                grid-template-columns:

                    repeat(2, minmax(0, 1fr));

            }



            .main-nav {

                overflow-x: auto;

                white-space: nowrap;

            }

        }



        @media (max-width: 650px) {

            .brand-container {

                width: 90%;

                flex-direction: column;

                align-items: flex-start;

                padding: 18px 0;

                gap: 18px;

            }



            .header-actions {

                width: 100%;

                justify-content: flex-start;

            }



            .main-nav {

                width: 90%;

                gap: 22px;

                overflow-x: auto;

            }



            .main-nav a {

                font-size: 12px;

            }



            .brand-name {

                font-size: 27px;

            }



            .brand-box {

                width: 52px;

                height: 52px;

            }



            .product-grid {

                grid-template-columns: 1fr;

            }



            .shop-page {

                width: 90%;

                padding-top: 40px;

            }



            .shop-heading h1 {

                font-size: 36px;

            }



            .category-filter {

                gap: 18px;

                overflow-x: auto;

                justify-content: flex-start;

                white-space: nowrap;

            }



            .search-form {

                flex-direction: column;

            }



            .search-form button {

                width: 100%;

            }

        }



        @media (max-width: 450px) {

            .brand-name {

                font-size: 24px;

            }



            .brand-tagline {

                font-size: 8px;

                letter-spacing: 2px;

            }



            .header-actions a,

            .header-user {

                font-size: 11px;

            }

        }

    </style>
    </style>

</head>



<body>



<!-- =====================================================

     HEADER

     ===================================================== -->

<header class="site-header">

    <div class="header-container">

        <!-- LOGO -->
        <a href="index.jsp" class="brand">

            <div class="brand-box">
                SM
            </div>

            <div class="brand-text">
                <div class="brand-name">
                    SOLE MATE
                </div>

                <div class="brand-tagline">
                    STEP INTO STYLE
                </div>
            </div>

        </a>

        <!-- NAVIGATION -->
        <nav class="main-nav">

            <a href="index.jsp">
                HOME
            </a>

            <a href="products"
               class="<%= request.getParameter("category") == null
                       ? "active"
                       : "" %>">
                SHOP
            </a>

            <a href="products?category=Men"
               class="<%= "Men".equals(request.getParameter("category"))
                       ? "active"
                       : "" %>">
                MEN
            </a>

            <a href="products?category=Women"
               class="<%= "Women".equals(request.getParameter("category"))
                       ? "active"
                       : "" %>">
                WOMEN
            </a>

            <a href="products?category=Kids"
               class="<%= "Kids".equals(request.getParameter("category"))
                       ? "active"
                       : "" %>">
                KIDS
            </a>

            <a href="products">
                NEW ARRIVALS
            </a>

            <a href="products">
                OFFERS
            </a>

        </nav>

        <!-- ACCOUNT -->
        <div class="header-actions">

            <% if (loggedUser != null) { %>

                <span class="header-user">
                    Hi, <%= loggedUser.getName() %>
                </span>

                <a href="my-orders">
                    My Orders
                </a>

                <a href="wishlist">
                    Wishlist
                </a>

                <a href="logout">
                    Logout
                </a>

            <% } else { %>

                <a href="login.jsp">
                    Login
                </a>

                <a href="register.jsp">
                    Register
                </a>

            <% } %>

            <a href="cart">
                Cart
            </a>

        </div>

    </div>

</header>





<!-- =====================================================

     SHOP CONTENT

     ===================================================== -->

<section class="shop-page">



    <!-- SHOP HEADING -->

    <div class="shop-heading">



        <p class="shop-small">

            STEP INTO STYLE

        </p>



        <h1>

            Our Collection

        </h1>



        <p>

            Discover shoes designed for every step.

        </p>



    </div>





    <!-- =================================================

         SEARCH

         ================================================= -->

    <form action="products"

          method="get"

          class="search-form">



        <input type="text"

               name="search"

               placeholder="Search shoes..."

               value="<%= request.getParameter("search") != null

                       ? request.getParameter("search")

                       : "" %>">



        <button type="submit">

            Search

        </button>



    </form>





    <!-- =================================================

         CATEGORY FILTER

         ================================================= -->

    <div class="category-filter">



        <a href="products"

           class="<%= request.getParameter("category") == null

                   ? "active"

                   : "" %>">

            All

        </a>



        <a href="products?category=Men"

           class="<%= "Men".equals(

                       request.getParameter("category"))

                   ? "active"

                   : "" %>">

            Men

        </a>



        <a href="products?category=Women"

           class="<%= "Women".equals(

                       request.getParameter("category"))

                   ? "active"

                   : "" %>">

            Women

        </a>



        <a href="products?category=Kids"

           class="<%= "Kids".equals(

                       request.getParameter("category"))

                   ? "active"

                   : "" %>">

            Kids

        </a>



    </div>





    <!-- =================================================

         PRODUCTS

         ================================================= -->

    <div class="product-grid">



        <% if (products != null &&

               !products.isEmpty()) { %>



            <% for (Product product : products) { %>



                <div class="product-card">



                    <!-- WISHLIST -->

                    <% if (loggedUser != null) { %>



                        <form action="wishlist"

                              method="post"

                              class="wishlist-form">



                            <input type="hidden"

                                   name="productId"

                                   value="<%= product.getId() %>">



                            <button type="submit"

                                    class="wishlist-btn"

                                    title="Add to Wishlist">

                                &#9825;

                            </button>



                        </form>



                    <% } else { %>



                        <a href="login.jsp"

                           class="wishlist-btn"

                           title="Login to add Wishlist">

                            &#9825;

                        </a>



                    <% } %>





                    <!-- PRODUCT IMAGE -->

                    <a href="product-details?id=<%= product.getId() %>"

                       class="product-image-link">



                        <div class="product-image">



                            <img src="<%= request.getContextPath() %>/images/<%= product.getImage() %>"

                                 alt="<%= product.getName() %>">



                        </div>



                    </a>





                    <!-- PRODUCT INFORMATION -->

                    <div class="product-info">



                        <p class="product-category">

                            <%= product.getCategory() %>

                        </p>



                        <h2>



                            <a href="product-details?id=<%= product.getId() %>">

                                <%= product.getName() %>

                            </a>



                        </h2>



                        <p class="product-description">

                            <%= product.getDescription() %>

                        </p>



                        <div class="product-bottom">



                            <span class="product-price">

                                &#8377;<%= String.format(

                                    "%.2f",

                                    product.getPrice()

                                ) %>

                            </span>





                            <% if (product.getQuantity() > 0) { %>



                                <span class="stock">

                                    In Stock

                                </span>



                            <% } else { %>



                                <span class="out-stock">

                                    Out of Stock

                                </span>



                            <% } %>



                        </div>





                        <!-- ADD TO CART -->

                        <% if (product.getQuantity() > 0) { %>



                            <form action="cart"

                                  method="post">



                                <input type="hidden"

                                       name="productId"

                                       value="<%= product.getId() %>">



                                <input type="hidden"

                                       name="quantity"

                                       value="1">



                                <button type="submit"

                                        class="add-cart-btn">

                                    Add to Cart

                                </button>



                            </form>



                        <% } else { %>



                            <button type="button"

                                    class="add-cart-btn"

                                    disabled>

                                Out of Stock

                            </button>



                        <% } %>



                    </div>



                </div>



            <% } %>



        <% } else { %>



            <!-- NO PRODUCTS -->

            <div class="no-products">



                <h2>

                    No Products Found

                </h2>



                <p>

                    Try another search or category.

                </p>



                <a href="products"

                   class="btn-primary">

                    View All Products

                </a>



            </div>



        <% } %>



    </div>



</section>





<!-- =====================================================

     FOOTER

     ===================================================== -->

<footer>



    <div class="footer-logo">



        <h2>

            SOLE MATE

        </h2>



        <p>

            Step into style.

            Walk with confidence.

        </p>



    </div>





    <div class="footer-links">



        <a href="index.jsp">

            Home

        </a>



        <a href="products">

            Shop

        </a>



        <a href="wishlist">

            Wishlist

        </a>



        <a href="cart">

            Cart

        </a>



        <a href="my-orders">

            My Orders

        </a>



    </div>





    <p class="copyright">

        &#169; 2026 Sole Mate.

        All rights reserved.

    </p>



</footer>



</body>

</html>