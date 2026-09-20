<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.fashionshoestore.model.Order" %>

<%
    com.fashionshoestore.model.User loggedUser =
        (com.fashionshoestore.model.User)
        session.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>My Orders - Sole Mate</title>

    <link rel="stylesheet" href="css/style.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap"
          rel="stylesheet">

    <style>

        .orders-page {
            max-width: 1200px;
            margin: 60px auto;
            padding: 0 30px;
        }

        .orders-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .orders-header h1 {
            font-family: 'DM Serif Display', serif;
            font-size: 46px;
            margin-bottom: 10px;
        }

        .orders-header p {
            color: #777;
            font-size: 16px;
        }

        .orders-table-wrapper {
            background: #fff;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 8px 30px rgba(0,0,0,0.08);
        }

        .orders-table {
            width: 100%;
            border-collapse: collapse;
        }

        .orders-table th {
            background: #222;
            color: #fff;
            padding: 18px;
            text-align: left;
            font-size: 14px;
            letter-spacing: 0.5px;
        }

        .orders-table td {
            padding: 20px 18px;
            border-bottom: 1px solid #eee;
            font-size: 15px;
        }

        .orders-table tr:last-child td {
            border-bottom: none;
        }

        .order-id {
            font-weight: 700;
        }

        .order-amount {
            font-weight: 700;
        }

        .status {
            display: inline-block;
            padding: 7px 14px;
            border-radius: 20px;
            background: #f3eadf;
            color: #8a5a2b;
            font-size: 13px;
            font-weight: 600;
        }

        .empty-orders {
            text-align: center;
            padding: 70px 20px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.08);
        }

        .empty-orders h2 {
            font-family: 'DM Serif Display', serif;
            font-size: 32px;
            margin-bottom: 12px;
        }

        .empty-orders p {
            color: #777;
            margin-bottom: 25px;
        }

        .shop-btn {
            display: inline-block;
            padding: 13px 28px;
            background: #222;
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
        }

        .shop-btn:hover {
            opacity: 0.85;
        }

        .orders-actions {
            text-align: center;
            margin-top: 35px;
        }

        .home-link {
            color: #222;
            text-decoration: none;
            font-weight: 600;
        }

        @media (max-width: 700px) {

            .orders-page {
                padding: 0 15px;
                margin-top: 35px;
            }

            .orders-header h1 {
                font-size: 36px;
            }

            .orders-table-wrapper {
                overflow-x: auto;
            }

            .orders-table {
                min-width: 650px;
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


<!-- ORDERS -->

<section class="orders-page">

    <div class="orders-header">

        <h1>My Orders</h1>

        <p>
            View your recent orders and purchase history.
        </p>

    </div>


    <%

        List<Order> orders =
            (List<Order>) request.getAttribute("orders");

    %>


    <% if (orders == null || orders.isEmpty()) { %>


        <div class="empty-orders">

            <h2>No Orders Yet</h2>

            <p>
                You haven't placed any orders yet.
                Start shopping and your orders will appear here.
            </p>

            <a href="products" class="shop-btn">
                SHOP NOW
            </a>

        </div>


    <% } else { %>


        <div class="orders-table-wrapper">

            <table class="orders-table">

                <thead>

                    <tr>

                        <th>Order ID</th>

                        <th>Total Amount</th>

                        <th>Status</th>

                        <th>Order Date</th>

                    </tr>

                </thead>


                <tbody>

                    <% for (Order order : orders) { %>

                        <tr>

                            <td>
    <a href="order-details?orderId=<%= order.getId() %>">
        #<%= order.getId() %>
    </a>
</td>

                            <td class="order-amount">

                                &#8377;<%= String.format("%.2f",
                                        order.getTotalAmount()) %>

                            </td>


                            <td>

                                <span class="status">

                                    <%= order.getStatus() %>

                                </span>

                            </td>


                            <td>

                                <%= order.getOrderDate() %>

                            </td>

                        </tr>

                    <% } %>

                </tbody>

            </table>

        </div>


    <% } %>


    <div class="orders-actions">

        <a href="index.jsp" class="home-link">
            &#8592; Back to Home
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