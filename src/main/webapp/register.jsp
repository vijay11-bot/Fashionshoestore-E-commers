<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Create Account | Sole Mate</title>

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

<header class="navbar">

    <!-- LOGO -->

    <div class="logo">

        <span class="logo-icon">

            <svg viewBox="0 0 24 24"
                 width="25"
                 height="25"
                 fill="none"
                 stroke="currentColor"
                 stroke-width="1.7"
                 stroke-linecap="round"
                 stroke-linejoin="round">

                <path d="M4 17.5c2.5-.5 4.2-1.8 5.4-4.8
                         l1.1-2.7 2.1 2.2
                         c1.5 1.6 3.3 2.7 5.5 3.2
                         l1.9.4
                         c1.2.3 2 1.3 2 2.5
                         v.2H4z">
                </path>

                <path d="M9.5 12.7
                         c1.2 1.2 2.6 2.1 4.2 2.7">
                </path>

            </svg>

        </span>


        <div>

            <h2>SOLE MATE</h2>

            <span>
                Step Into Style
            </span>

        </div>

    </div>


    <!-- NAVIGATION -->

    <nav>

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


    <!-- ACCOUNT + CART -->

    <div class="nav-actions">

        <!-- ACCOUNT -->

        <a href="login.jsp"
           class="nav-icon active-icon"
           title="My Account">

            <svg viewBox="0 0 24 24"
                 width="23"
                 height="23"
                 fill="none"
                 stroke="currentColor"
                 stroke-width="1.8"
                 stroke-linecap="round"
                 stroke-linejoin="round">

                <circle cx="12"
                        cy="8"
                        r="4">
                </circle>

                <path d="M4 21c0-4.2 3.6-7 8-7s8 2.8 8 7">
                </path>

            </svg>

        </a>


        <!-- SHOPPING BAG -->

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

                <path d="M6 8h12l1 13H5L6 8z">
                </path>

                <path d="M9 8V6a3 3 0 0 1 6 0v2">
                </path>

            </svg>

        </a>

    </div>

</header>



<!-- =====================================================
     REGISTER SECTION
     ===================================================== -->

<main class="auth-container">

    <div class="auth-card">


        <!-- LEFT SIDE -->

        <div class="auth-info">

            <p class="auth-small">
                JOIN SOLE MATE
            </p>


            <h1>

                Create Your

                <br>

                Style.

            </h1>


            <p>

                Create your Sole Mate account
                and discover fashion made for
                every step of your journey.

            </p>


            <div class="auth-benefits">


                <div>

                    <span>
                        &#10003;
                    </span>

                    <p>
                        Easy and secure shopping
                    </p>

                </div>


                <div>

                    <span>
                        &#10003;
                    </span>

                    <p>
                        Track all your orders
                    </p>

                </div>


                <div>

                    <span>
                        &#10003;
                    </span>

                    <p>
                        Faster checkout experience
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
                    Register
                </h2>


                <span>
                    Create your account to get started.
                </span>

            </div>



            <!-- ERROR MESSAGE -->

            <%

                String error = request.getParameter("error");

                if ("exists".equals(error)) {

            %>

                <div class="register-error">

                    An account with this email already exists.

                    <br>

                    Please use another email.

                </div>

            <%

                } else if ("failed".equals(error)) {

            %>

                <div class="register-error">

                    Registration failed.

                    <br>

                    Please try again.

                </div>

            <%

                }

            %>



            <!-- REGISTER FORM -->

            <form action="register"
                  method="post"
                  class="auth-form">


                <!-- NAME -->

                <div class="form-group">

                    <label for="name">
                        Full Name
                    </label>


                    <input type="text"
                           id="name"
                           name="name"
                           placeholder="Enter your full name"
                           autocomplete="name"
                           required>

                </div>



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



                <!-- PHONE -->

                <div class="form-group">

                    <label for="phone">
                        Phone Number
                    </label>


                    <input type="tel"
                           id="phone"
                           name="phone"
                           placeholder="Enter your phone number"
                           autocomplete="tel"
                           pattern="[0-9]{10}"
                           maxlength="10"
                           required>

                </div>



                <!-- PASSWORD -->

                <div class="form-group">

                    <label for="password">
                        Password
                    </label>


                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="Create a password"
                           autocomplete="new-password"
                           minlength="6"
                           required>

                </div>



                <!-- ADDRESS -->

                <div class="form-group">

                    <label for="address">
                        Address
                    </label>


                    <textarea id="address"
                              name="address"
                              placeholder="Enter your address"
                              rows="3"
                              required></textarea>

                </div>



                <!-- REGISTER BUTTON -->

                <button type="submit"
                        class="auth-submit">

                    CREATE ACCOUNT

                </button>

            </form>



            <!-- LOGIN -->

            <div class="auth-register">

                <span>
                    Already have an account?
                </span>

                <a href="login.jsp">
                    Login
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

        <a href="login.jsp">
            Login
        </a>

    </div>


    <p class="copyright">

        &copy; 2026 Sole Mate. All rights reserved.

    </p>

</footer>



<!-- =====================================================
     REGISTER PAGE CSS
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

    min-height: 700px;

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

    padding: 55px 60px;

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

.register-error {

    margin-top: 20px;

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

    margin-top: 25px;

}



.form-group {

    margin-bottom: 17px;

}



.form-group label {

    display: block;

    margin-bottom: 7px;

    color: #3c302a;

    font-size: 14px;

    font-weight: 600;

}



.form-group input,

.form-group textarea {

    width: 100%;

    box-sizing: border-box;

    padding: 12px 15px;

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



.form-group textarea {

    resize: vertical;

    min-height: 75px;

}



.form-group input:focus,

.form-group textarea:focus {

    border-color: #b97845;

    box-shadow:
        0 0 0 3px rgba(185, 120, 69, 0.10);

}



.form-group input::placeholder,

.form-group textarea::placeholder {

    color: #aaa09a;

}



/* =========================
   SUBMIT BUTTON
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
   REGISTER / LOGIN LINK
   ========================= */

.auth-register {

    margin-top: 22px;

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

    margin-top: 18px;

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