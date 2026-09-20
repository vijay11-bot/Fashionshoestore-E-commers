<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.fashionshoestore.model.User" %>
<%@ page import="com.fashionshoestore.service.CartService" %>

<%
    com.fashionshoestore.model.User loggedUser =
        (com.fashionshoestore.model.User)
        session.getAttribute("user");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Checkout - Sole Mate</title>

    <link rel="stylesheet" href="css/style.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap"
          rel="stylesheet">

    <style>

        .checkout-page {
            max-width: 1100px;
            margin: 60px auto;
            padding: 0 25px;
        }

        .checkout-title {
            text-align: center;
            margin-bottom: 45px;
        }

        .checkout-title h1 {
            font-family: 'DM Serif Display', serif;
            font-size: 46px;
            margin-bottom: 10px;
        }

        .checkout-title p {
            color: #777;
        }

        .checkout-grid {
            display: grid;
            grid-template-columns: 1.4fr 0.8fr;
            gap: 30px;
        }

        .checkout-card {
            background: #fff;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.08);
        }

        .checkout-card h2 {
            font-family: 'DM Serif Display', serif;
            font-size: 28px;
            margin-bottom: 25px;
        }

        .customer-row {
            margin-bottom: 20px;
        }

        .customer-label {
            display: block;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #888;
            margin-bottom: 6px;
        }

        .customer-value {
            font-size: 16px;
            font-weight: 500;
        }

        .address-box {
            background: #f8f5f0;
            padding: 15px;
            border-radius: 8px;
            line-height: 1.6;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }

        .summary-row.total {
            border-bottom: none;
            padding-top: 25px;
            font-size: 20px;
            font-weight: 700;
        }

        .place-order-btn {
            width: 100%;
            border: none;
            background: #222;
            color: #fff;
            padding: 16px;
            border-radius: 7px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 20px;
        }

        .place-order-btn:hover {
            opacity: 0.85;
        }

        .secure-note {
            text-align: center;
            color: #777;
            font-size: 13px;
            margin-top: 15px;
        }

        .checkout-links {
            text-align: center;
            margin-top: 30px;
        }

        .checkout-links a {
            color: #222;
            text-decoration: none;
            font-weight: 600;
            margin: 0 10px;
        }

        .error-message {
            max-width: 600px;
            margin: 20px auto;
            padding: 14px;
            background: #f8eaea;
            color: #a33;
            border-radius: 8px;
            text-align: center;
        }

        @media (max-width: 750px) {

            .checkout-page {
                margin-top: 35px;
            }

            .checkout-grid {
                grid-template-columns: 1fr;
            }

            .checkout-title h1 {
                font-size: 38px;
            }

        }

    </style>

</head>

<body>


<!-- NAVBAR -->

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


<%

    User user =
        (User) session.getAttribute("user");

    if (user == null) {

        response.sendRedirect("login.jsp");

        return;
    }


    CartService cartService =
        new CartService();

    double totalAmount =
        cartService.getCartTotal(user.getId());

%>


<!-- CHECKOUT -->

<section class="checkout-page">


    <div class="checkout-title">

        <h1>Checkout</h1>

        <p>
            Review your details and place your order.
        </p>

    </div>


    <%

        String error =
            request.getParameter("error");

        if (error != null) {

    %>

        <div class="error-message">

            Unable to place your order.
            Please check your cart and try again.

        </div>

    <%

        }

    %>


    <div class="checkout-grid">


        <!-- CUSTOMER DETAILS -->

        <div class="checkout-card">

            <h2>Customer Details</h2>


            <div class="customer-row">

                <span class="customer-label">
                    Name
                </span>

                <div class="customer-value">
                    <%= user.getName() %>
                </div>

            </div>


            <div class="customer-row">

                <span class="customer-label">
                    Email
                </span>

                <div class="customer-value">
                    <%= user.getEmail() %>
                </div>

            </div>


            <div class="customer-row">

                <span class="customer-label">
                    Phone
                </span>

                <div class="customer-value">
                    <%= user.getPhone() %>
                </div>

            </div>


            <div class="customer-row">

                <span class="customer-label">
                    Delivery Address
                </span>

                <div class="address-box">
                    <%= user.getAddress() %>
                </div>

            </div>

        </div>


        <!-- ORDER SUMMARY -->

        <div class="checkout-card">

            <h2>Order Summary</h2>


            <div class="summary-row">

                <span>Subtotal</span>

                <span>
                    &#8377;<%= String.format("%.2f", totalAmount) %>
                </span>

            </div>


            <div class="summary-row">

                <span>Shipping</span>

                <span>FREE</span>

            </div>


            <div class="summary-row total">

                <span>Total</span>

                <span>
                    &#8377;<%= String.format("%.2f", totalAmount) %>
                </span>

            </div>


            <% if (totalAmount > 0) { %>

                <form action="order" method="post">

                    <!--
                        OrderServlet gets the user and
                        total directly from the server.
                        These hidden values are not trusted.
                    -->

                    <button type="submit"
                            class="place-order-btn">

                        PLACE ORDER

                    </button>

                </form>

            <% } else { %>

                <button type="button"
                        class="place-order-btn"
                        disabled>

                    CART IS EMPTY

                </button>

            <% } %>


            <p class="secure-note">

                Your order is securely processed.

            </p>

        </div>

    </div>


    <div class="checkout-links">

        <a href="cart">
            &#8592; Back to Cart
        </a>

        <a href="index.jsp">
            Home
        </a>

    </div>

</section>


<!-- FOOTER -->

<footer>

    <div class="footer-logo">

        <h2>SOLE MATE</h2>

        <p>
            Step into style. Walk with confidence.
        </p>

    </div>


    <div class="footer-links">

        <a href="products">Shop</a>

        <a href="cart">Cart</a>

        <a href="my-orders">My Orders</a>

        <a href="login.jsp">Login</a>

        <a href="register.jsp">Register</a>

    </div>


    <p class="copyright">

        &copy; 2026 Sole Mate. All rights reserved.

    </p>

</footer>


</body>
</html>