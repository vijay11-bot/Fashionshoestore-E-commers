<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    com.fashionshoestore.model.User loggedUser =
        (com.fashionshoestore.model.User)
        session.getAttribute("user");
%>


<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Order Successful - Sole Mate</title>

    <link rel="stylesheet" href="css/style.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap"
          rel="stylesheet">

    <style>

        .success-page {
            min-height: 70vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 70px 20px;
        }

        .success-card {
            max-width: 600px;
            width: 100%;
            background: #ffffff;
            text-align: center;
            padding: 55px 40px;
            border-radius: 18px;
            box-shadow: 0 10px 35px rgba(0, 0, 0, 0.08);
        }

        .success-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 25px;
            border-radius: 50%;
            background: #f3eadf;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .success-icon svg {
            width: 42px;
            height: 42px;
            stroke: #8a5a2b;
        }

        .success-card h1 {
            font-family: 'DM Serif Display', serif;
            font-size: 44px;
            margin-bottom: 15px;
        }

        .success-card p {
            color: #777;
            line-height: 1.7;
            margin-bottom: 10px;
        }

        .order-number {
            margin: 25px 0;
            padding: 15px;
            background: #f8f5f0;
            border-radius: 8px;
            font-weight: 600;
        }

        .success-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .success-buttons a {
            text-decoration: none;
            padding: 13px 25px;
            border-radius: 6px;
            font-weight: 600;
        }

        .primary-btn {
            background: #222;
            color: #fff;
        }

        .secondary-btn {
            border: 1px solid #222;
            color: #222;
            background: #fff;
        }

        .success-buttons a:hover {
            opacity: 0.85;
        }

        @media (max-width: 600px) {

            .success-card {
                padding: 40px 20px;
            }

            .success-card h1 {
                font-size: 36px;
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


<!-- SUCCESS -->

<section class="success-page">

    <div class="success-card">

        <div class="success-icon">

            <svg viewBox="0 0 24 24"
                 fill="none"
                 stroke="currentColor"
                 stroke-width="2">

                <path d="M5 12l4 4L19 6"></path>

            </svg>

        </div>


        <h1>Order Placed!</h1>

        <p>
            Thank you for shopping with Sole Mate.
        </p>

        <p>
            Your order has been successfully placed.
            We will process it shortly.
        </p>


        <%

            String orderId =
                request.getParameter("orderId");

            if (orderId != null) {

        %>

            <div class="order-number">

                Order Number:
                #<%= orderId %>

            </div>

        <%

            }

        %>


        <div class="success-buttons">

            <a href="my-orders"
               class="primary-btn">

                VIEW MY ORDERS

            </a>


            <a href="products"
               class="secondary-btn">

                CONTINUE SHOPPING

            </a>

        </div>

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