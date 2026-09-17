<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.fashionshoestore.model.Product" %>

<%
    com.fashionshoestore.model.User loggedUser =
        (com.fashionshoestore.model.User)
        session.getAttribute("user");
%>

<%
    Product product = (Product) request.getAttribute("product");

    if (product == null) {
        response.sendRedirect("products");
        return;
    }

   
%>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title><%= product.getName() %> | Sole Mate</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f7f3ee;
            color: #2d2926;
        }

        /* NAVBAR */

        .navbar {
            height: 78px;
            background: #fffdf9;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 6%;
            border-bottom: 1px solid #e8e0d7;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            color: #2d2926;
        }

        .logo-icon {
            width: 42px;
            height: 42px;
            border: 1px solid #2d2926;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            font-weight: bold;
            letter-spacing: 1px;
        }

        .logo-text h2 {
            font-size: 18px;
            letter-spacing: 2px;
        }

        .logo-text span {
            font-size: 9px;
            letter-spacing: 2px;
            color: #8b8179;
        }

        nav {
            display: flex;
            gap: 25px;
        }

        nav a {
            text-decoration: none;
            color: #514a45;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 1px;
        }

        nav a:hover {
            color: #a06b45;
        }

        .nav-account {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-name {
            font-size: 13px;
            font-weight: 600;
        }

        .nav-account-link {
            text-decoration: none;
            color: #2d2926;
            font-size: 12px;
            font-weight: 600;
        }

        .nav-account-link:hover {
            color: #a06b45;
        }

        .nav-icon {
            color: #2d2926;
            display: flex;
            align-items: center;
        }

        .nav-icon:hover {
            color: #a06b45;
        }

        /* BREADCRUMB */

        .breadcrumb {
            max-width: 1200px;
            margin: 30px auto 0;
            padding: 0 30px;
            font-size: 13px;
            color: #8a817a;
        }

        .breadcrumb a {
            color: #6c625b;
            text-decoration: none;
        }

        /* PRODUCT */

        .product-container {
            max-width: 1200px;
            margin: 30px auto 80px;
            padding: 0 30px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 70px;
            align-items: start;
        }

        .product-image {
            background: #eee8e0;
            min-height: 560px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .product-image img {
            width: 100%;
            height: 560px;
            object-fit: cover;
            transition: transform 0.4s ease;
        }

        .product-image:hover img {
            transform: scale(1.03);
        }

        .product-info {
            padding-top: 25px;
        }

        .category {
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: #a06b45;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .product-info h1 {
            font-family: Georgia, serif;
            font-size: 42px;
            line-height: 1.15;
            font-weight: 400;
            margin-bottom: 18px;
        }

        .description {
            color: #716963;
            font-size: 15px;
            line-height: 1.8;
            margin-bottom: 25px;
        }

        .price {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 25px;
        }

        .divider {
            height: 1px;
            background: #ddd4ca;
            margin: 25px 0;
        }

        .availability {
            font-size: 14px;
            margin-bottom: 25px;
        }

        .available {
            color: #4d7654;
            font-weight: 600;
        }

        .out-stock {
            color: #a44b43;
            font-weight: 600;
        }

        .quantity-label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .quantity {
            width: 90px;
            height: 45px;
            border: 1px solid #cfc5ba;
            background: white;
            padding: 0 12px;
            font-size: 15px;
            margin-bottom: 20px;
        }

        .add-cart-btn {
            width: 100%;
            height: 54px;
            border: none;
            background: #2d2926;
            color: white;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: 1.5px;
            cursor: pointer;
            transition: 0.3s ease;
        }

        .add-cart-btn:hover {
            background: #a06b45;
        }

        .disabled-btn {
            background: #aaa29b;
            cursor: not-allowed;
        }

        .back-link {
            display: inline-block;
            margin-top: 25px;
            color: #514a45;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
        }

        .back-link:hover {
            color: #a06b45;
        }

        /* DETAILS */

        .details-box {
            border-top: 1px solid #ddd4ca;
            margin-top: 30px;
            padding-top: 25px;
        }

        .details-box h3 {
            font-size: 14px;
            letter-spacing: 1px;
            margin-bottom: 15px;
        }

        .details-box p {
            color: #716963;
            font-size: 14px;
            line-height: 1.8;
        }

        /* FOOTER */

        footer {
            background: #2d2926;
            color: #eee7df;
            padding: 45px 6%;
            text-align: center;
        }

        footer h3 {
            letter-spacing: 2px;
            margin-bottom: 10px;
        }

        footer p {
            color: #bcb3aa;
            font-size: 13px;
        }

        /* RESPONSIVE */

        @media (max-width: 900px) {

            nav {
                display: none;
            }

            .product-container {
                grid-template-columns: 1fr;
                gap: 35px;
            }

            .product-image,
            .product-image img {
                min-height: 450px;
                height: 450px;
            }

            .product-info {
                padding-top: 0;
            }

        }

        @media (max-width: 550px) {

            .navbar {
                padding: 0 20px;
            }

            .user-name,
            .nav-account-link {
                display: none;
            }

            .breadcrumb {
                padding: 0 20px;
            }

            .product-container {
                padding: 0 20px;
            }

            .product-info h1 {
                font-size: 32px;
            }

        }

    </style>

</head>

<body>

<!-- ================= NAVBAR ================= -->

<!-- ================= COMMON HEADER ================= -->

<header class="site-header">

    <div class="header-container">

        <!-- LOGO -->
        <a href="index.jsp" class="active">

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

            <a href="products">
                SHOP
            </a>

            <a href="products?category=Men">
                MEN
            </a>

            <a href="products?category=Women">
                WOMEN
            </a>

            <a href="products?category=Kids">
                KIDS
            </a>

            <a href="products">
                NEW ARRIVALS
            </a>

            <a href="products">
                SALE
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


<!-- ================= BREADCRUMB ================= -->

<div class="breadcrumb">

    <a href="products">Shop</a>

    &nbsp; / &nbsp;

    <%= product.getCategory() %>

    &nbsp; / &nbsp;

    <%= product.getName() %>

</div>


<!-- ================= PRODUCT ================= -->

<section class="product-container">


    <!-- PRODUCT IMAGE -->

    <div class="product-image">

        <img src="<%= request.getContextPath() %>/images/<%= product.getImage() %>"
             alt="<%= product.getName() %>">

    </div>


    <!-- PRODUCT INFORMATION -->

    <div class="product-info">

        <div class="category">
            <%= product.getCategory() %>
        </div>


        <h1>
            <%= product.getName() %>
        </h1>


        <p class="description">
            <%= product.getDescription() %>
        </p>


        <div class="price">

            &#8377;<%= String.format("%.2f", product.getPrice()) %>

        </div>


        <div class="divider"></div>


        <!-- STOCK -->

        <div class="availability">

            <% if (product.getQuantity() > 0) { %>

                <span class="available">
                    &#10003; In Stock
                </span>

            <% } else { %>

                <span class="out-stock">
                    Out of Stock
                </span>

            <% } %>

        </div>


        <!-- ADD TO CART -->

        <% if (product.getQuantity() > 0) { %>

            <form action="cart" method="post">

                <input type="hidden"
                       name="productId"
                       value="<%= product.getId() %>">

                <label class="quantity-label">
                    Quantity
                </label>

                <input type="number"
                       name="quantity"
                       class="quantity"
                       value="1"
                       min="1"
                       max="<%= product.getQuantity() %>"
                       required>

                <button type="submit"
                        class="add-cart-btn">

                    ADD TO CART

                </button>

            </form>

        <% } else { %>

            <button class="add-cart-btn disabled-btn"
                    disabled>

                OUT OF STOCK

            </button>

        <% } %>


        <a href="products"
           class="back-link">

            &#8592; Continue Shopping

        </a>


        <!-- PRODUCT DETAILS -->

        <div class="details-box">

            <h3>PRODUCT DETAILS</h3>

            <p>
                Category:
                <strong><%= product.getCategory() %></strong>
            </p>

            <p>
                Available Quantity:
                <strong><%= product.getQuantity() %></strong>
            </p>

            <p>
                Product ID:
                <strong>#<%= product.getId() %></strong>
            </p>

        </div>

    </div>

</section>


<!-- ================= FOOTER ================= -->

<footer>

    <h3>SOLE MATE</h3>

    <p>
        Step into style. Walk with confidence.
    </p>

</footer>

</body>
</html>