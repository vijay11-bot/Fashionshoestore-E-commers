<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.fashionshoestore.model.OrderItem" %>

<%
    com.fashionshoestore.model.User loggedUser =
        (com.fashionshoestore.model.User)
        session.getAttribute("user");
%>

<%
    Integer orderId = (Integer) request.getAttribute("orderId");

    List<OrderItem> orderItems =
        (List<OrderItem>) request.getAttribute("orderItems");

    double total = 0;

    if (orderItems != null) {
        for (OrderItem item : orderItems) {
            total += item.getPrice() * item.getQuantity();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Order Details | Sole Mate</title>

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
    text-decoration: none;
    color: #2d2926;
    display: flex;
    align-items: center;
    gap: 10px;
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
}

nav a:hover {
    color: #a06b45;
}

.page {
    max-width: 1000px;
    margin: 60px auto;
    padding: 0 25px;
}

.heading {
    margin-bottom: 30px;
}

.heading p {
    color: #a06b45;
    font-size: 12px;
    letter-spacing: 2px;
    font-weight: 600;
    margin-bottom: 10px;
}

.heading h1 {
    font-family: Georgia, serif;
    font-size: 40px;
    font-weight: 400;
}

.order-card {
    background: #fffdf9;
    border: 1px solid #e4dbd1;
}

.order-header {
    padding: 22px 25px;
    border-bottom: 1px solid #e4dbd1;
    display: flex;
    justify-content: space-between;
}

.order-header strong {
    font-size: 15px;
}

.order-header span {
    color: #756d67;
    font-size: 13px;
}

.item {
    padding: 22px 25px;
    border-bottom: 1px solid #eee7df;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.item-info h3 {
    font-size: 16px;
    margin-bottom: 8px;
}

.item-info p {
    color: #77706a;
    font-size: 13px;
    margin: 4px 0;
}

.item-price {
    font-weight: 600;
}

.total {
    padding: 25px;
    display: flex;
    justify-content: space-between;
    font-size: 18px;
    font-weight: 600;
}

.back {
    display: inline-block;
    margin-top: 25px;
    color: #514a45;
    text-decoration: none;
    font-size: 13px;
    font-weight: 600;
}

.back:hover {
    color: #a06b45;
}

.empty {
    padding: 50px;
    text-align: center;
    color: #77706a;
}

footer {
    margin-top: 100px;
    background: #2d2926;
    color: #eee7df;
    text-align: center;
    padding: 45px;
}

footer h3 {
    letter-spacing: 2px;
    margin-bottom: 10px;
}

footer p {
    color: #bcb3aa;
    font-size: 13px;
}

@media (max-width: 700px) {

    nav {
        display: none;
    }

    .page {
        margin: 40px auto;
    }

    .heading h1 {
        font-size: 32px;
    }

    .item {
        align-items: flex-start;
        gap: 20px;
    }

}

</style>

</head>

<body>

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

<main class="page">

    <div class="heading">

        <p>MY ORDER</p>

        <h1>
            Order #<%= orderId %>
        </h1>

    </div>


    <div class="order-card">

        <div class="order-header">

            <strong>
                Order Items
            </strong>

            <span>
                Order #<%= orderId %>
            </span>

        </div>


        <% if (orderItems != null && !orderItems.isEmpty()) { %>

            <% for (OrderItem item : orderItems) { %>

                <div class="item">

    <div class="item-info">

        <img src="<%= request.getContextPath() %>/images/<%= item.getProductImage() %>"
             alt="<%= item.getProductName() %>"
             style="width:80px;height:80px;object-fit:cover;margin-bottom:12px;">

        <h3>
            <%= item.getProductName() %>
        </h3>

        <p>
            Quantity:
            <%= item.getQuantity() %>
        </p>

        <p>
            Unit Price:
            &#8377;<%= String.format("%.2f",
                item.getPrice()) %>
        </p>

    </div>

    <div class="item-price">

        &#8377;<%= String.format("%.2f",
            item.getPrice() * item.getQuantity()) %>

    </div>

</div>

                    <div class="item-price">

                        &#8377;<%= String.format("%.2f",
                            item.getPrice() *
                            item.getQuantity()) %>

                    </div>

                </div>

            <% } %>


            <div class="total">

                <span>Total</span>

                <span>
                    &#8377;<%= String.format("%.2f", total) %>
                </span>

            </div>

        <% } else { %>

            <div class="empty">
                No items found for this order.
            </div>

        <% } %>

    </div>


    <a href="my-orders" class="back">
        &#8592; Back to My Orders
    </a>

</main>


<footer>

    <h3>SOLE MATE</h3>

    <p>
        Step into style. Walk with confidence.
    </p>

</footer>

</body>

</html>