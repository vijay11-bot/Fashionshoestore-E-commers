<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="com.fashionshoestore.model.User" %>

<%
    User loggedUser =
        (User) session.getAttribute("user");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Sole Mate - Fashion Shoe Store</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap"
          rel="stylesheet">

</head>


<body>


<!-- =====================================================
     COMMON HEADER
     ===================================================== -->

<header class="site-header">

    <div class="header-container">


        <!-- LOGO -->

        <a href="index.jsp"
           class="brand">

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

            <!-- HOME ACTIVE -->

            <a href="index.jsp"
               class="active">
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
                OFFERS
            </a>

        </nav>


        <!-- ACCOUNT / USER ACTIONS -->

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
     HERO SECTION
     ===================================================== -->

<section class="hero">

    <div class="hero-content">

        <p class="hero-small">
            STEP INTO ELEGANCE
        </p>

        <h1>
            Fashion That<br>
            Moves With You
        </h1>

        <p class="hero-description">
            Trendy. Comfortable. You.<br>
            Explore our latest collection of premium shoes.
        </p>


        <div class="hero-buttons">

            <a href="products"
               class="btn-primary">
                SHOP NOW
            </a>

            <a href="products"
               class="btn-secondary">
                EXPLORE COLLECTION
            </a>

        </div>

    </div>


    <div class="hero-image">

        <img src="images/shoe2.jpg"
             alt="Featured Shoe">

    </div>

</section>



<!-- =====================================================
     FEATURES
     ===================================================== -->

<section class="features">


    <div class="feature">

        <span>&#10148;</span>

        <div>

            <strong>
                Free Shipping
            </strong>

            <p>
                On orders over &#8377;499
            </p>

        </div>

    </div>



    <div class="feature">

        <span>&#8635;</span>

        <div>

            <strong>
                Easy Returns
            </strong>

            <p>
                30 days return policy
            </p>

        </div>

    </div>



    <div class="feature">

        <span>&#128274;</span>

        <div>

            <strong>
                Secure Payment
            </strong>

            <p>
                100% secure checkout
            </p>

        </div>

    </div>



    <div class="feature">

        <span>&#9733;</span>

        <div>

            <strong>
                Quality Products
            </strong>

            <p>
                Premium &amp; durable
            </p>

        </div>

    </div>



    <div class="feature">

        <span>&#9742;</span>

        <div>

            <strong>
                24/7 Support
            </strong>

            <p>
                We are here to help
            </p>

        </div>

    </div>


</section>



<!-- =====================================================
     SHOP BY CATEGORY
     ===================================================== -->

<section class="categories">


    <div class="section-heading">

        <h2>
            Shop by Category
        </h2>

        <a href="products">
            View All &#8594;
        </a>

    </div>



    <div class="category-grid">


        <!-- MEN -->

        <a href="products?category=Men"
           class="category">

            <div class="category-image">

                <img src="images/shoe2.jpg"
                     alt="Men Shoes">

            </div>

            <h3>
                Men
            </h3>

        </a>



        <!-- WOMEN -->

        <a href="products?category=Women"
           class="category">

            <div class="category-image">

                <img src="images/shoe3.jpg"
                     alt="Women Shoes">

            </div>

            <h3>
                Women
            </h3>

        </a>



        <!-- KIDS -->

        <a href="products?category=Kids"
           class="category">

            <div class="category-image">

                <img src="images/shoe4.jpg"
                     alt="Kids Shoes">

            </div>

            <h3>
                Kids
            </h3>

        </a>



        <!-- SPORTS -->

        <a href="products"
           class="category">

            <div class="category-image">

                <img src="images/shoe5.jpg"
                     alt="Sports Shoes">

            </div>

            <h3>
                Sports
            </h3>

        </a>



        <!-- FORMAL -->

        <a href="products"
           class="category">

            <div class="category-image">

                <img src="images/shoe6.jpg"
                     alt="Formal Shoes">

            </div>

            <h3>
                Formal
            </h3>

        </a>



        <!-- CASUAL -->

        <a href="products"
           class="category">

            <div class="category-image">

                <img src="images/shoe7.jpg"
                     alt="Casual Shoes">

            </div>

            <h3>
                Casual
            </h3>

        </a>


    </div>

</section>



<!-- =====================================================
     NEW ARRIVALS
     ===================================================== -->

<section class="new-arrivals">


    <div class="section-heading">

        <h2>
            New Arrivals
        </h2>

        <a href="products">
            View All &#8594;
        </a>

    </div>



    <div class="home-products">


        <!-- PRODUCT 1 -->

        <div class="home-product">

            <a href="product-details?id=1"
               class="wishlist"
               title="View Product">

                &#9825;

            </a>

            <img src="images/shoe2.jpg"
                 alt="Classic White Sneakers">

            <div class="product-info">

                <h3>
                    Classic White Sneakers
                </h3>

                <p class="home-price">
                    &#8377;1,999
                </p>

                <div class="rating">

                    &#9733;&#9733;&#9733;&#9733;&#9734;

                    <span>
                        (128)
                    </span>

                </div>

            </div>

        </div>



        <!-- PRODUCT 2 -->

        <div class="home-product">

            <a href="product-details?id=2"
               class="wishlist"
               title="View Product">

                &#9825;

            </a>

            <img src="images/shoe3.jpg"
                 alt="Women Fashion Shoes">

            <div class="product-info">

                <h3>
                    Women Fashion Shoes
                </h3>

                <p class="home-price">
                    &#8377;2,199
                </p>

                <div class="rating">

                    &#9733;&#9733;&#9733;&#9733;&#9734;

                    <span>
                        (96)
                    </span>

                </div>

            </div>

        </div>



        <!-- PRODUCT 3 -->

        <div class="home-product">

            <a href="product-details?id=3"
               class="wishlist"
               title="View Product">

                &#9825;

            </a>

            <img src="images/shoe4.jpg"
                 alt="Men Running Shoes">

            <div class="product-info">

                <h3>
                    Men Running Shoes
                </h3>

                <p class="home-price">
                    &#8377;2,499
                </p>

                <div class="rating">

                    &#9733;&#9733;&#9733;&#9733;&#9733;

                    <span>
                        (143)
                    </span>

                </div>

            </div>

        </div>



        <!-- PRODUCT 4 -->

        <div class="home-product">

            <a href="product-details?id=4"
               class="wishlist"
               title="View Product">

                &#9825;

            </a>

            <img src="images/shoe5.jpg"
                 alt="Kids Casual Shoes">

            <div class="product-info">

                <h3>
                    Kids Casual Shoes
                </h3>

                <p class="home-price">
                    &#8377;1,499
                </p>

                <div class="rating">

                    &#9733;&#9733;&#9733;&#9733;&#9734;

                    <span>
                        (78)
                    </span>

                </div>

            </div>

        </div>



        <!-- PRODUCT 5 -->

        <div class="home-product">

            <a href="product-details?id=5"
               class="wishlist"
               title="View Product">

                &#9825;

            </a>

            <img src="images/shoe6.jpg"
                 alt="Leather Formal Shoes">

            <div class="product-info">

                <h3>
                    Leather Formal Shoes
                </h3>

                <p class="home-price">
                    &#8377;2,799
                </p>

                <div class="rating">

                    &#9733;&#9733;&#9733;&#9733;&#9733;

                    <span>
                        (64)
                    </span>

                </div>

            </div>

        </div>


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

        <a href="login.jsp">
            Login
        </a>

        <a href="register.jsp">
            Register
        </a>

    </div>



    <p class="copyright">

        &#169; 2026 Sole Mate.
        All rights reserved.

    </p>


</footer>


</body>

</html>