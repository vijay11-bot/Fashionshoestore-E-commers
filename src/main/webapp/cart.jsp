<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.fashionshoestore.model.Cart" %>
<%@ page import="com.fashionshoestore.model.Product" %>
<%@ page import="com.fashionshoestore.model.User" %>

<%
    com.fashionshoestore.model.User loggedUser =
        (com.fashionshoestore.model.User)
        session.getAttribute("user");
%>

<%
    List<Cart> cartItems =
        (List<Cart>) request.getAttribute("cartItems");

    List<Product> products =
        (List<Product>) request.getAttribute("products");

    String error = request.getParameter("error");

    
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Shopping Cart - Sole Mate</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap"
          rel="stylesheet">


    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #f7f3ee;
            color: #2d2926;
            font-family: 'Inter', Arial, sans-serif;
        }


        /* ================= NAVBAR ================= */

        .navbar {
            min-height: 78px;
            padding: 0 6%;
            background: #fffdf9;
            border-bottom: 1px solid #e7dfd7;

            display: flex;
            align-items: center;
            justify-content: space-between;

            gap: 30px;
        }


        .logo {
            display: flex;
            align-items: center;
            gap: 11px;

            text-decoration: none;
            color: #2d2926;

            flex-shrink: 0;
        }


        .logo-icon {
            width: 42px;
            height: 42px;

            border: 1px solid #2d2926;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 12px;
            font-weight: 700;
            letter-spacing: 1px;
        }


        .logo-text h2 {
            margin: 0;

            font-family: 'DM Serif Display', Georgia, serif;
            font-size: 20px;
            font-weight: 400;
            letter-spacing: 2px;
        }


        .logo-text span {
            display: block;

            margin-top: 2px;

            color: #8a8179;

            font-size: 8px;
            letter-spacing: 2px;
            text-transform: uppercase;
        }


        nav {
            display: flex;
            align-items: center;
            gap: 24px;
        }


        nav a {
            color: #514a45;
            text-decoration: none;

            font-size: 11px;
            font-weight: 600;
            letter-spacing: 1px;

            transition: 0.25s ease;
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
            gap: 14px;
        }


        .user-name {
            color: #2d2926;

            font-size: 13px;
            font-weight: 600;
        }


        .nav-account-link {
            color: #514a45;

            text-decoration: none;

            font-size: 11px;
            font-weight: 600;

            transition: 0.25s ease;
        }


        .nav-account-link:hover {
            color: #a06b45;
        }


        .nav-icon {
            color: #2d2926;

            display: flex;
            align-items: center;
            justify-content: center;

            text-decoration: none;

            transition: 0.25s ease;
        }


        .nav-icon:hover {
            color: #a06b45;
        }


        /* ================= PAGE HEADER ================= */

        .page-header {
            text-align: center;

            padding: 65px 20px 45px;
        }


        .page-header p {
            margin: 0 0 10px;

            color: #a06b45;

            font-size: 11px;
            font-weight: 700;
            letter-spacing: 3px;
        }


        .page-header h1 {
            margin: 0 0 12px;

            font-family: 'DM Serif Display', Georgia, serif;

            font-size: 48px;
            font-weight: 400;
        }


        .page-header span {
            color: #817870;

            font-size: 14px;
        }


        /* ================= CART SECTION ================= */

        .cart-section {
            max-width: 1250px;

            margin: 0 auto;

            padding: 0 25px 80px;
        }


        /* ================= ERROR MESSAGE ================= */

        .stock-error {
            margin: 0 auto 25px;

            padding: 17px 20px;

            background: #fff1ef;

            border: 1px solid #e2b8b1;

            color: #8f4038;

            display: flex;
            flex-direction: column;

            gap: 5px;

            font-size: 13px;
            line-height: 1.5;
        }


        .stock-error strong {
            font-size: 14px;
        }


        /* ================= CART CONTAINER ================= */

        .cart-container {
            display: grid;

            grid-template-columns: minmax(0, 1fr) 340px;

            gap: 30px;

            align-items: start;
        }


        /* ================= CART ITEMS ================= */

        .cart-items {
            background: #fffdf9;

            border: 1px solid #e5ddd5;
        }


        .cart-title {
            padding: 25px 28px;

            border-bottom: 1px solid #e5ddd5;

            display: flex;
            align-items: center;
            justify-content: space-between;
        }


        .cart-title h2 {
            margin: 0;

            font-family: 'DM Serif Display', Georgia, serif;

            font-size: 26px;
            font-weight: 400;
        }


        .cart-title span {
            color: #827970;

            font-size: 12px;
        }


        /* ================= SINGLE ITEM ================= */

        .cart-item {
            padding: 25px;

            border-bottom: 1px solid #eee7df;

            display: grid;

            grid-template-columns: 125px minmax(180px, 1fr) 110px 110px 30px;

            gap: 22px;

            align-items: center;
        }


        .cart-item:last-child {
            border-bottom: none;
        }


        /* ================= PRODUCT IMAGE ================= */

        .cart-product-image {
            width: 125px;
            height: 135px;

            background: #eee8e0;

            overflow: hidden;
        }


        .cart-product-image img {
            width: 100%;
            height: 100%;

            object-fit: cover;

            display: block;

            transition: transform 0.35s ease;
        }


        .cart-product-image:hover img {
            transform: scale(1.04);
        }


        /* ================= PRODUCT DETAILS ================= */

        .cart-product-details {
            min-width: 0;
        }


        .cart-category {
            margin: 0 0 7px;

            color: #a06b45;

            font-size: 10px;
            font-weight: 700;

            letter-spacing: 1.5px;

            text-transform: uppercase;
        }


        .cart-product-details h3 {
            margin: 0 0 8px;

            font-family: 'DM Serif Display', Georgia, serif;

            font-size: 22px;
            font-weight: 400;
        }


        .cart-product-details p:not(.cart-category) {
            margin: 0 0 10px;

            color: #817870;

            font-size: 12px;

            line-height: 1.6;

            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;

            overflow: hidden;
        }


        .cart-product-details strong {
            font-size: 15px;
        }


        /* ================= STOCK STATUS ================= */

        .stock-warning {
            margin-top: 10px;

            color: #a44b43;

            font-size: 12px;
            font-weight: 700;

            line-height: 1.5;
        }


        .stock-available {
            margin-top: 10px;

            color: #4d7654;

            font-size: 12px;
            font-weight: 600;
        }


        /* ================= QUANTITY ================= */

        .cart-quantity {
            text-align: center;
        }


        .cart-quantity > span {
            display: block;

            margin-bottom: 9px;

            color: #817870;

            font-size: 10px;
            font-weight: 600;

            letter-spacing: 1px;
            text-transform: uppercase;
        }


        .quantity-box {
            width: 92px;
            height: 38px;

            margin: 0 auto;

            border: 1px solid #d8cec4;

            background: #fff;

            display: flex;
            align-items: center;
            justify-content: space-between;
        }


        .quantity-box form {
            margin: 0;
            padding: 0;
        }


        .quantity-box button {
            width: 30px;
            height: 36px;

            border: none;

            background: transparent;

            color: #2d2926;

            font-size: 16px;

            cursor: pointer;

            transition: 0.2s ease;
        }


        .quantity-box button:hover:not(:disabled) {
            background: #f1ebe5;
        }


        .quantity-box button:disabled {
            opacity: 0.3;

            cursor: not-allowed;
        }


        .quantity-number {
            min-width: 25px;

            text-align: center;

            font-size: 13px;
            font-weight: 600;
        }


        /* ================= SUBTOTAL ================= */

        .cart-subtotal {
            text-align: right;
        }


        .cart-subtotal span {
            display: block;

            margin-bottom: 6px;

            color: #817870;

            font-size: 10px;

            letter-spacing: 1px;
            text-transform: uppercase;
        }


        .cart-subtotal strong {
            font-size: 15px;
        }


        /* ================= REMOVE ================= */

        .cart-remove {
            text-align: center;
        }


        .cart-remove form {
            margin: 0;
        }


        .cart-remove button {
            width: 28px;
            height: 28px;

            border: none;

            background: transparent;

            color: #817870;

            font-size: 20px;

            line-height: 1;

            cursor: pointer;

            transition: 0.2s ease;
        }


        .cart-remove button:hover {
            color: #a44b43;

            background: #fff1ef;
        }


        /* ================= ORDER SUMMARY ================= */

        .cart-summary {
            position: sticky;
            top: 20px;

            padding: 28px;

            background: #fffdf9;

            border: 1px solid #e5ddd5;
        }


        .cart-summary h2 {
            margin: 0 0 25px;

            font-family: 'DM Serif Display', Georgia, serif;

            font-size: 26px;
            font-weight: 400;
        }


        .summary-row {
            display: flex;

            justify-content: space-between;
            align-items: center;

            margin-bottom: 16px;

            color: #716963;

            font-size: 13px;
        }


        .summary-row strong {
            color: #2d2926;

            font-size: 13px;
        }


        .summary-line {
            height: 1px;

            margin: 22px 0;

            background: #ded5cc;
        }


        .summary-total {
            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-bottom: 25px;
        }


        .summary-total span {
            font-size: 15px;
            font-weight: 600;
        }


        .summary-total strong {
            font-size: 20px;
        }


        .checkout-btn {
            width: 100%;

            min-height: 52px;

            background: #2d2926;
            color: #fff;

            display: flex;
            align-items: center;
            justify-content: center;

            text-decoration: none;

            font-size: 11px;
            font-weight: 700;

            letter-spacing: 1.5px;

            transition: 0.3s ease;
        }


        .checkout-btn:hover {
            background: #a06b45;
        }


        .continue-shopping {
            display: block;

            margin-top: 18px;

            color: #514a45;

            text-align: center;

            text-decoration: none;

            font-size: 12px;
            font-weight: 600;
        }


        .continue-shopping:hover {
            color: #a06b45;
        }


        /* ================= EMPTY CART ================= */

        .empty-cart {
            max-width: 600px;

            margin: 20px auto 50px;

            padding: 70px 30px;

            background: #fffdf9;

            border: 1px solid #e5ddd5;

            text-align: center;
        }


        .empty-cart-icon {
            width: 70px;
            height: 70px;

            margin: 0 auto 25px;

            border: 1px solid #d7cec5;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 26px;
        }


        .empty-cart h2 {
            margin: 0 0 12px;

            font-family: 'DM Serif Display', Georgia, serif;

            font-size: 32px;
            font-weight: 400;
        }


        .empty-cart p {
            margin: 0 auto 25px;

            max-width: 380px;

            color: #817870;

            font-size: 13px;

            line-height: 1.7;
        }


        .btn-primary {
            display: inline-flex;

            min-height: 48px;

            padding: 0 25px;

            align-items: center;
            justify-content: center;

            background: #2d2926;
            color: white;

            text-decoration: none;

            font-size: 11px;
            font-weight: 700;

            letter-spacing: 1.5px;

            transition: 0.3s ease;
        }


        .btn-primary:hover {
            background: #a06b45;
        }


        /* ================= FOOTER ================= */

        footer {
            padding: 50px 25px;

            background: #2d2926;

            color: #eee7df;

            text-align: center;
        }


        .footer-logo h2 {
            margin: 0 0 8px;

            font-family: 'DM Serif Display', Georgia, serif;

            font-size: 24px;
            font-weight: 400;

            letter-spacing: 2px;
        }


        .footer-logo p {
            margin: 0;

            color: #bcb3aa;

            font-size: 12px;
        }


        .footer-links {
            margin: 25px 0;

            display: flex;
            justify-content: center;

            flex-wrap: wrap;

            gap: 20px;
        }


        .footer-links a {
            color: #d8d0c8;

            text-decoration: none;

            font-size: 11px;
        }


        .footer-links a:hover {
            color: #fff;
        }


        .copyright {
            margin: 0;

            color: #8f8780;

            font-size: 10px;
        }


        /* ================= RESPONSIVE ================= */

        @media (max-width: 1050px) {

            .cart-item {
                grid-template-columns:
                    105px
                    minmax(150px, 1fr)
                    95px
                    95px
                    25px;

                gap: 15px;
            }


            .cart-product-image {
                width: 105px;
                height: 120px;
            }

        }


        @media (max-width: 850px) {

            nav {
                display: none;
            }


            .cart-container {
                grid-template-columns: 1fr;
            }


            .cart-summary {
                position: static;
            }

        }


        @media (max-width: 650px) {

            .navbar {
                padding: 0 20px;
            }


            .user-name,
            .nav-account-link {
                display: none;
            }


            .page-header {
                padding: 45px 20px 35px;
            }


            .page-header h1 {
                font-size: 38px;
            }


            .cart-section {
                padding: 0 15px 60px;
            }


            .cart-item {
                grid-template-columns: 90px 1fr 25px;

                gap: 15px;

                padding: 20px;
            }


            .cart-product-image {
                width: 90px;
                height: 105px;

                grid-row: span 2;
            }


            .cart-product-details {
                grid-column: 2;
            }


            .cart-quantity {
                grid-column: 2;

                text-align: left;
            }


            .quantity-box {
                margin: 0;
            }


            .cart-subtotal {
                grid-column: 2;

                text-align: left;
            }


            .cart-remove {
                grid-column: 3;
                grid-row: 1;
            }


            .cart-title {
                padding: 20px;
            }

        }


        @media (max-width: 450px) {

            .logo-text {
                display: none;
            }


            .page-header h1 {
                font-size: 34px;
            }


            .cart-product-details h3 {
                font-size: 19px;
            }


            .cart-item {
                grid-template-columns: 75px 1fr 25px;
            }


            .cart-product-image {
                width: 75px;
                height: 90px;
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

<!-- ================= PAGE HEADER ================= -->

<section class="page-header">

    <p>
        YOUR SHOPPING BAG
    </p>

    <h1>
        Your Cart
    </h1>

    <span>
        Review your selected products before checkout.
    </span>

</section>


<!-- ================= CART SECTION ================= -->

<section class="cart-section">


    <!-- ================= ERROR MESSAGE ================= -->

    <% if ("stock".equals(error)) { %>

        <div class="stock-error">

            <strong>
                Stock unavailable
            </strong>

            <span>
                One or more products in your cart exceed
                the available stock. Please reduce the quantity.
            </span>

        </div>

    <% } else if ("empty".equals(error)) { %>

        <div class="stock-error">

            <strong>
                Your cart is empty
            </strong>

            <span>
                Please add a product before placing an order.
            </span>

        </div>

    <% } %>


<%

    if (cartItems != null && !cartItems.isEmpty()) {

%>


    <div class="cart-container">


        <!-- ================= CART ITEMS ================= -->

        <div class="cart-items">


            <div class="cart-title">

                <h2>
                    Shopping Bag
                </h2>

                <span>
                    <%= cartItems.size() %> item(s)
                </span>

            </div>


<%

        double total = 0;


        for (Cart cart : cartItems) {


            Product product = null;


            if (products != null) {

                for (Product p : products) {

                    if (p.getId() == cart.getProductId()) {

                        product = p;

                        break;
                    }
                }
            }


            if (product != null) {


                double subtotal =
                        product.getPrice()
                        * cart.getQuantity();


                total += subtotal;

%>


            <!-- ================= SINGLE CART ITEM ================= -->

            <div class="cart-item">


                <!-- PRODUCT IMAGE -->

                <div class="cart-product-image">

                    <img
                        src="<%= request.getContextPath() %>/images/<%= product.getImage() %>"
                        alt="<%= product.getName() %>">

                </div>


                <!-- PRODUCT DETAILS -->

                <div class="cart-product-details">


                    <p class="cart-category">

                        <%= product.getCategory() %>

                    </p>


                    <h3>

                        <%= product.getName() %>

                    </h3>


                    <p>

                        <%= product.getDescription() %>

                    </p>


                    <strong>

                        &#8377;<%= String.format("%.2f",
                                product.getPrice()) %>

                    </strong>


                    <!-- STOCK STATUS -->

                    <% if (product.getQuantity() <= 0) { %>

                        <div class="stock-warning">

                            Out of stock

                        </div>


                    <% } else if
                        (cart.getQuantity() > product.getQuantity()) { %>

                        <div class="stock-warning">

                            Only
                            <%= product.getQuantity() %>
                            available.
                            You requested
                            <%= cart.getQuantity() %>.

                        </div>


                    <% } else { %>

                        <div class="stock-available">

                            <%= product.getQuantity() %>
                            available

                        </div>

                    <% } %>


                </div>


                <!-- ================= QUANTITY ================= -->

                <div class="cart-quantity">


                    <span>
                        Quantity
                    </span>


                    <div class="quantity-box">


                        <!-- MINUS -->

                        <form action="cart"
                              method="post"
                              style="display:inline;">

                            <input type="hidden"
                                   name="action"
                                   value="update">


                            <input type="hidden"
                                   name="cartId"
                                   value="<%= cart.getId() %>">


                            <input type="hidden"
                                   name="quantity"
                                   value="<%= cart.getQuantity() - 1 %>">


                            <button type="submit"
                                    <%= cart.getQuantity() <= 1
                                        ? "disabled"
                                        : "" %>>

                                &#8722;

                            </button>

                        </form>


                        <!-- CURRENT QUANTITY -->

                        <span class="quantity-number">

                            <%= cart.getQuantity() %>

                        </span>


                        <!-- PLUS -->

                        <form action="cart"
                              method="post"
                              style="display:inline;">

                            <input type="hidden"
                                   name="action"
                                   value="update">


                            <input type="hidden"
                                   name="cartId"
                                   value="<%= cart.getId() %>">


                            <input type="hidden"
                                   name="quantity"
                                   value="<%= cart.getQuantity() + 1 %>">


                            <button type="submit"
                                    <%= cart.getQuantity()
                                        >= product.getQuantity()
                                        ? "disabled"
                                        : "" %>>

                                +

                            </button>

                        </form>


                    </div>

                </div>


                <!-- ================= SUBTOTAL ================= -->

                <div class="cart-subtotal">


                    <span>
                        Subtotal
                    </span>


                    <strong>

                        &#8377;<%= String.format("%.2f",
                                subtotal) %>

                    </strong>


                </div>


                <!-- ================= REMOVE ================= -->

                <div class="cart-remove">


                    <form action="cart"
                          method="post">


                        <input type="hidden"
                               name="action"
                               value="remove">


                        <input type="hidden"
                               name="cartId"
                               value="<%= cart.getId() %>">


                        <button type="submit"
                                title="Remove item">

                            &#215;

                        </button>


                    </form>


                </div>


            </div>


<%

            }

        }

%>


        </div>


        <!-- ================= ORDER SUMMARY ================= -->

        <aside class="cart-summary">


            <h2>
                Order Summary
            </h2>


            <!-- SUBTOTAL -->

            <div class="summary-row">

                <span>
                    Subtotal
                </span>

                <strong>

                    &#8377;<%= String.format("%.2f",
                            total) %>

                </strong>

            </div>


            <!-- SHIPPING -->

            <div class="summary-row">

                <span>
                    Shipping
                </span>

                <strong>
                    FREE
                </strong>

            </div>


            <div class="summary-line">
            </div>


            <!-- TOTAL -->

            <div class="summary-total">

                <span>
                    Total
                </span>

                <strong>

                    &#8377;<%= String.format("%.2f",
                            total) %>

                </strong>

            </div>


            <!-- CHECKOUT -->

            <a href="checkout.jsp"
               class="checkout-btn">

                PROCEED TO CHECKOUT

            </a>


            <!-- CONTINUE SHOPPING -->

            <a href="products"
               class="continue-shopping">

                &#8592; Continue Shopping

            </a>


        </aside>


    </div>


<%

    } else {

%>


    <!-- ================= EMPTY CART ================= -->

    <div class="empty-cart">


        <div class="empty-cart-icon">

            <svg viewBox="0 0 24 24"
                 width="30"
                 height="30"
                 fill="none"
                 stroke="currentColor"
                 stroke-width="1.5"
                 stroke-linecap="round"
                 stroke-linejoin="round">

                <path d="M6 8h12l1 13H5L6 8z">
                </path>

                <path d="M9 8V6a3 3 0 0 1 6 0v2">
                </path>

            </svg>

        </div>


        <h2>
            Your cart is empty
        </h2>


        <p>

            Looks like you haven't added anything
            to your cart yet.

        </p>


        <a href="products"
           class="btn-primary">

            START SHOPPING

        </a>


    </div>


<%

    }

%>


</section>


<!-- ================= FOOTER ================= -->

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

        <a href="cart">
            Cart
        </a>

        <a href="my-orders">
            My Orders
        </a>

        <a href="login.jsp">
            Login
        </a>

    </div>


    <p class="copyright">

        &#169; 2026 Sole Mate.
        All rights reserved.

    </p>


</footer>


</body>

</html>