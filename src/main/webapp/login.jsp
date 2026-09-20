<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    com.fashionshoestore.model.User loggedUser =
        (com.fashionshoestore.model.User)
        session.getAttribute("user");
%>
 
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Login | Sole Mate</title>

    <link rel="stylesheet"
          href="css/style.css">

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap"
          rel="stylesheet">

</head>


<body class="auth-page">


<!-- =====================================================
     NAVBAR
     ===================================================== -->

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


<!-- =====================================================
     LOGIN SECTION
     ===================================================== -->

<main class="auth-container">

    <div class="auth-card">


        <!-- LEFT SIDE -->

        <div class="auth-info">

            <p class="auth-small">
                WELCOME BACK
            </p>


            <h1>

                Step Back Into

                <br>

                Style.

            </h1>


            <p>

                Sign in to your Sole Mate account
                and continue your shopping journey.

            </p>


            <div class="auth-benefits">


                <div>

                    <span>
                        &#10003;
                    </span>

                    <p>
                        Track your orders
                    </p>

                </div>


                <div>

                    <span>
                        &#10003;
                    </span>

                    <p>
                        Save your favourite products
                    </p>

                </div>


                <div>

                    <span>
                        &#10003;
                    </span>

                    <p>
                        Faster checkout
                    </p>

                </div>


            </div>

        </div>



        <!-- RIGHT SIDE -->

        <div class="auth-form-section">


            <div class="auth-form-header">

                <p>
                    ACCOUNT
                </p>


                <h2>
                    Login
                </h2>


                <span>
                    Enter your details to continue.
                </span>

            </div>



            <!-- ERROR MESSAGE -->

            <%

                String error = request.getParameter("error");

                if ("invalid".equals(error)) {

            %>

                <div class="login-error">

                    Invalid email or password.

                    <br>

                    Please try again.

                </div>

            <%

                }

            %>



            <!-- LOGIN FORM -->

            <form action="login"
                  method="post"
                  class="auth-form">


                <!-- EMAIL -->

                <div class="form-group">

                    <label for="email">
                        Email Address
                    </label>


                    <input type="email"
                           id="email"
                           name="email"
                           placeholder="Enter your email"
                           autocomplete="email"
                           required>

                </div>



                <!-- PASSWORD -->

                <div class="form-group">

                    <div class="password-label">

                        <label for="password">
                            Password
                        </label>

                    </div>


                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="Enter your password"
                           autocomplete="current-password"
                           required>

                </div>



                <!-- REMEMBER -->

                <div class="remember-row">

                    <label>

                        <input type="checkbox"
                               name="remember">

                        <span>
                            Remember me
                        </span>

                    </label>

                </div>



                <!-- LOGIN BUTTON -->

                <button type="submit"
                        class="auth-submit">

                    LOGIN

                </button>

            </form>



            <!-- REGISTER -->

            <div class="auth-register">

                <span>
                    Don't have an account?
                </span>

                <a href="register.jsp">
                    Create an Account
                </a>

            </div>



            <!-- HOME -->

            <a href="index.jsp"
               class="auth-home">

                &#8592; Back to Home

            </a>

        </div>

    </div>

</main>



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

            <br>

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

        <a href="register.jsp">
            Register
        </a>

    </div>


    <p class="copyright">

        &copy; 2026 Sole Mate. All rights reserved.

    </p>

</footer>



<!-- =====================================================
     LOGIN PAGE CSS
     ===================================================== -->

<style>

/* =========================
   AUTH PAGE
   ========================= */

.auth-page {

    background: #f8f3ed;

}



/* =========================
   AUTH CONTAINER
   ========================= */

.auth-container {

    min-height: 650px;

    display: flex;

    align-items: center;

    justify-content: center;

    padding: 70px 30px;

}



/* =========================
   AUTH CARD
   ========================= */

.auth-card {

    width: 100%;

    max-width: 1050px;

    display: grid;

    grid-template-columns: 1fr 1fr;

    background: #ffffff;

    border: 1px solid #eaded3;

    border-radius: 24px;

    overflow: hidden;

    box-shadow:
        0 15px 45px rgba(45, 33, 28, 0.08);

}



/* =========================
   LEFT SIDE
   ========================= */

.auth-info {

    background: #f2e5d9;

    padding: 70px 60px;

    display: flex;

    flex-direction: column;

    justify-content: center;

}



.auth-small {

    color: #b97845;

    font-size: 14px;

    font-weight: 700;

    letter-spacing: 3px;

    margin-bottom: 20px;

}



.auth-info h1 {

    font-family: "DM Serif Display", serif;

    font-size: 52px;

    line-height: 1.08;

    color: #2d211c;

    margin-bottom: 25px;

}



.auth-info > p:not(.auth-small) {

    color: #6d625b;

    font-size: 16px;

    line-height: 1.8;

    max-width: 390px;

}



/* =========================
   BENEFITS
   ========================= */

.auth-benefits {

    margin-top: 35px;

    display: flex;

    flex-direction: column;

    gap: 17px;

}



.auth-benefits div {

    display: flex;

    align-items: center;

    gap: 12px;

}



.auth-benefits span {

    width: 25px;

    height: 25px;

    display: flex;

    align-items: center;

    justify-content: center;

    border-radius: 50%;

    background: #b97845;

    color: white;

    font-size: 13px;

    font-weight: 700;

}



.auth-benefits p {

    margin: 0;

    color: #4e433d;

    font-size: 14px;

}



/* =========================
   FORM SECTION
   ========================= */

.auth-form-section {

    padding: 65px 60px;

    display: flex;

    flex-direction: column;

    justify-content: center;

}



.auth-form-header p {

    color: #b97845;

    font-size: 12px;

    font-weight: 700;

    letter-spacing: 2px;

    margin-bottom: 8px;

}



.auth-form-header h2 {

    font-family: "DM Serif Display", serif;

    font-size: 42px;

    color: #2d211c;

    margin: 0 0 8px;

}



.auth-form-header span {

    color: #8a7c72;

    font-size: 14px;

}



/* =========================
   ERROR
   ========================= */

.login-error {

    margin-top: 25px;

    padding: 12px 15px;

    background: #fff0ed;

    border: 1px solid #e5b7ae;

    border-radius: 8px;

    color: #a23a2a;

    font-size: 13px;

}



/* =========================
   FORM
   ========================= */

.auth-form {

    margin-top: 30px;

}



.form-group {

    margin-bottom: 22px;

}



.form-group label {

    display: block;

    margin-bottom: 8px;

    color: #3c302a;

    font-size: 14px;

    font-weight: 600;

}



.form-group input {

    width: 100%;

    box-sizing: border-box;

    padding: 14px 15px;

    border: 1px solid #ddcfc4;

    border-radius: 8px;

    background: #fff;

    color: #2d211c;

    font-family: "Inter", sans-serif;

    font-size: 14px;

    outline: none;

    transition:
        border-color 0.2s ease,
        box-shadow 0.2s ease;

}



.form-group input:focus {

    border-color: #b97845;

    box-shadow:
        0 0 0 3px rgba(185, 120, 69, 0.10);

}



.form-group input::placeholder {

    color: #aaa09a;

}



/* =========================
   REMEMBER
   ========================= */

.remember-row {

    margin-bottom: 25px;

}



.remember-row label {

    display: flex;

    align-items: center;

    gap: 8px;

    color: #756a63;

    font-size: 13px;

    cursor: pointer;

}



.remember-row input {

    accent-color: #b97845;

}



/* =========================
   LOGIN BUTTON
   ========================= */

.auth-submit {

    width: 100%;

    padding: 15px;

    border: none;

    border-radius: 8px;

    background: #b97845;

    color: white;

    font-size: 14px;

    font-weight: 700;

    letter-spacing: 1px;

    cursor: pointer;

    transition: all 0.25s ease;

}



.auth-submit:hover {

    background: #9e6337;

    transform: translateY(-1px);

    box-shadow:
        0 7px 18px rgba(185, 120, 69, 0.20);

}



/* =========================
   REGISTER
   ========================= */

.auth-register {

    margin-top: 25px;

    text-align: center;

    font-size: 13px;

    color: #81756d;

}



.auth-register a {

    margin-left: 5px;

    color: #b97845;

    font-weight: 600;

    text-decoration: none;

}



.auth-register a:hover {

    text-decoration: underline;

}



/* =========================
   HOME LINK
   ========================= */

.auth-home {

    display: block;

    margin-top: 22px;

    text-align: center;

    color: #6d625b;

    font-size: 13px;

    text-decoration: none;

}



.auth-home:hover {

    color: #b97845;

}



/* =========================
   NAV ICONS
   ========================= */

.nav-actions {

    display: flex;

    align-items: center;

    gap: 18px;

}



.nav-icon {

    width: 42px;

    height: 42px;

    display: flex;

    align-items: center;

    justify-content: center;

    color: #2d211c;

    text-decoration: none;

    border-radius: 50%;

    transition: all 0.25s ease;

}



.nav-icon svg {

    display: block;

}



.nav-icon:hover,

.active-icon {

    color: #b97845;

    background: #f6eee7;

}



/* =========================
   LOGO ICON
   ========================= */

.logo-icon {

    display: flex;

    align-items: center;

    justify-content: center;

    color: #b97845;

}



.logo-icon svg {

    display: block;

}



/* =========================
   RESPONSIVE
   ========================= */

@media (max-width: 850px) {

    .auth-card {

        grid-template-columns: 1fr;

    }


    .auth-info {

        padding: 45px 35px;

    }


    .auth-info h1 {

        font-size: 42px;

    }


    .auth-form-section {

        padding: 45px 35px;

    }

}



@media (max-width: 600px) {

    .auth-container {

        padding: 35px 15px;

    }


    .auth-info {

        padding: 40px 25px;

    }


    .auth-form-section {

        padding: 40px 25px;

    }


    .auth-info h1 {

        font-size: 36px;

    }

}

</style>


</body>

</html>