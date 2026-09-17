<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.fashionshoestore.model.Product" %>
<%@ page import="com.fashionshoestore.model.User" %>

<%
    List<Product> wishlist =
        (List<Product>) request.getAttribute("wishlist");

    User loggedUser =
        (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Wishlist - Sole Mate</title>

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

        .wishlist-section {
            padding: 70px 7%;
            min-height: 500px;
        }

        .wishlist-header {
            text-align: center;
            margin-bottom: 45px;
        }

        .wishlist-header p {
            font-size: 12px;
            letter-spacing: 3px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .wishlist-header h1 {
            font-family: "DM Serif Display", serif;
            font-size: 48px;
            font-weight: 400;
            margin: 0;
        }

        .wishlist-grid {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(240px, 1fr));
            gap: 28px;
        }

        .wishlist-card {
            background: #fff;
            border: 1px solid #e8dfd7;
            padding-bottom: 22px;
            transition: 0.3s ease;
        }

        .wishlist-card:hover {
            transform: translateY(-5px);
        }

        .wishlist-image {
            width: 100%;
            height: 280px;
            overflow: hidden;
            background: #f5efe9;
        }

        .wishlist-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .wishlist-info {
            padding: 20px;
        }

        .wishlist-category {
            font-size: 11px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #9b806d;
        }

        .wishlist-info h2 {
            font-family: "DM Serif Display", serif;
            font-size: 24px;
            font-weight: 400;
            margin: 8px 0;
        }

        .wishlist-price {
            font-size: 17px;
            font-weight: 700;
            margin-bottom: 18px;
        }

        .wishlist-actions {
            display: flex;
            gap: 10px;
        }

        .wishlist-view,
        .wishlist-remove {
            flex: 1;
            padding: 11px 8px;
            text-align: center;
            text-decoration: none;
            border: 1px solid #2d2926;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .wishlist-view {
            background: #2d2926;
            color: white;
        }

        .wishlist-remove {
            background: white;
            color: #2d2926;
            cursor: pointer;
        }

        .wishlist-empty {
            text-align: center;
            padding: 80px 20px;
        }

        .wishlist-empty h2 {
            font-family: "DM Serif Display", serif;
            font-size: 34px;
            font-weight: 400;
        }

        .wishlist-empty p {
            color: #777;
            margin-bottom: 25px;
        }

        .wishlist-shop-btn {
            display: inline-block;
            padding: 13px 28px;
            background: #2d2926;
            color: white;
            text-decoration: none;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 1px;
        }

        @media (max-width: 600px) {

            .wishlist-section {
                padding: 45px 5%;
            }

            .wishlist-header h1 {
                font-size: 38px;
            }

            .wishlist-image {
                height: 240px;
            }
        }

    </style>

</head>

<body>

<header class="navbar">

    <a href="index.jsp" class="logo">

        <span class="logo-icon">SM</span>

        <div>
            <h2>SOLE MATE</h2>
            <span>Step Into Style</span>
        </div>

    </a>

    <nav>

        <a href="index.jsp">HOME</a>
        <a href="products">SHOP</a>
        <a href="products?category=Men">MEN</a>
        <a href="products?category=Women">WOMEN</a>
        <a href="products?category=Kids">KIDS</a>

    </nav>

    <div class="nav-account">

        <div class="user-menu">

            <span class="user-name">
                Hi, <%= loggedUser.getName() %>
            </span>

            <a href="my-orders"
               class="nav-account-link">
                My Orders
            </a>

            <a href="logout"
               class="nav-account-link">
                Logout
            </a>

        </div>

        <a href="wishlist"
           class="nav-icon"
           title="Wishlist">

            &#9825;

        </a>

        <a href="cart"
           class="nav-icon"
           title="Shopping Cart">

            <svg viewBox="0 0 24 24"
                 width="23"
                 height="23"
                 fill="none"
                 stroke="currentColor"
                 stroke-width="1.8"
                 stroke-linecap="round"
                 stroke-linejoin="round">

                <path d="M6 8h12l1 13H5L6 8z"></path>

                <path d="M9 8V6a3 3 0 0 1 6 0v2"></path>

            </svg>

        </a>

    </div>

</header>


<section class="wishlist-section">

    <div class="wishlist-header">

        <p>YOUR FAVORITES</p>

        <h1>My Wishlist</h1>

    </div>


<%
    if (wishlist != null && !wishlist.isEmpty()) {
%>

    <div class="wishlist-grid">

<%
        for (Product product : wishlist) {
%>

        <div class="wishlist-card">

            <div class="wishlist-image">

                <img
                    src="<%= request.getContextPath() %>/images/<%= product.getImage() %>"
                    alt="<%= product.getName() %>">

            </div>


            <div class="wishlist-info">

                <div class="wishlist-category">
                    <%= product.getCategory() %>
                </div>

                <h2>
                    <%= product.getName() %>
                </h2>

                <div class="wishlist-price">
                    &#8377;<%= String.format("%.2f",
                            product.getPrice()) %>
                </div>


                <div class="wishlist-actions">

                    <a href="product-details?id=<%= product.getId() %>"
                       class="wishlist-view">
                        VIEW
                    </a>


                    <form action="wishlist"
                          method="post"
                          style="flex:1;">

                        <input type="hidden"
                               name="action"
                               value="remove">

                        <input type="hidden"
                               name="productId"
                               value="<%= product.getId() %>">

                        <button type="submit"
                                class="wishlist-remove"
                                style="width:100%; height:100%;">
                            REMOVE
                        </button>

                    </form>

                </div>

            </div>

        </div>

<%
        }
%>

    </div>

<%
    } else {
%>

    <div class="wishlist-empty">

        <h2>Your wishlist is empty</h2>

        <p>
            Save your favorite shoes here
            and come back to them later.
        </p>

        <a href="products"
           class="wishlist-shop-btn">
            EXPLORE PRODUCTS
        </a>

    </div>

<%
    }
%>

</section>


<footer>

    <div class="footer-logo">

        <h2>SOLE MATE</h2>

        <p>
            Step into style.
            Walk with confidence.
        </p>

    </div>


    <div class="footer-links">

        <a href="index.jsp">Home</a>
        <a href="products">Shop</a>
        <a href="wishlist">Wishlist</a>
        <a href="cart">Cart</a>
        <a href="my-orders">My Orders</a>

    </div>


    <p class="copyright">

        &#169; 2026 Sole Mate.
        All rights reserved.

    </p>

</footer>

</body>
</html>