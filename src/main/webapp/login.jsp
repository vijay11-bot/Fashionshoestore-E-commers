<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.fashionshoestore.model.User" %>
<%
    User loggedUser = (User) session.getAttribute("user");
    if (loggedUser != null) {
        response.sendRedirect(request.getContextPath() + "/home");
        return;
    }
    String error = (String) request.getAttribute("error");
    String msg = request.getParameter("msg");
    boolean registered = "true".equalsIgnoreCase(request.getParameter("registered"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In | Sole Mate</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .auth-wrapper {
            max-width: 1000px;
            margin: 50px auto 80px;
            padding: 0 20px;
        }
        .auth-split-card {
            display: grid;
            grid-template-columns: 1fr 1.1fr;
            background: #fff;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 35px rgba(0,0,0,0.08);
        }
        @media (max-width: 768px) {
            .auth-split-card {
                grid-template-columns: 1fr;
            }
            .auth-hero-banner {
                display: none;
            }
        }
        .auth-hero-banner {
            background: linear-gradient(135deg, #241c18 0%, #3f312a 100%);
            color: #fff;
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .auth-hero-banner h2 {
            font-family: 'DM Serif Display', serif;
            font-size: 34px;
            line-height: 1.25;
            margin-bottom: 15px;
        }
        .auth-hero-banner p {
            color: #d5c8be;
            font-size: 15px;
            line-height: 1.6;
        }
        .perks-list {
            margin-top: 30px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        .perk-item {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 14px;
        }
        .perk-check {
            width: 22px;
            height: 22px;
            border-radius: 50%;
            background: #8a5a2b;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
        }
        .auth-form-panel {
            padding: 50px 45px;
        }
        .form-heading h3 {
            font-family: 'DM Serif Display', serif;
            font-size: 30px;
            margin-bottom: 8px;
            color: #222;
        }
        .form-heading p {
            color: #777;
            font-size: 14px;
            margin-bottom: 25px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #555;
            margin-bottom: 8px;
        }
        .form-control {
            width: 100%;
            padding: 13px 16px;
            border: 1.5px solid #d5c8be;
            border-radius: 8px;
            font-size: 15px;
            font-family: inherit;
        }
        .form-control:focus {
            outline: none;
            border-color: #222;
        }
        .btn-submit {
            width: 100%;
            background: #222;
            color: #fff;
            padding: 15px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 700;
            border: none;
            cursor: pointer;
            margin-top: 10px;
            transition: background 0.2s ease;
        }
        .btn-submit:hover {
            background: #8a5a2b;
        }
        .alert-error {
            background: #fdf2f2;
            color: #e74c3c;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            font-weight: 600;
        }
        .alert-success {
            background: #eafaf1;
            color: #27ae60;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            font-weight: 600;
        }
        .auth-switch {
            text-align: center;
            margin-top: 25px;
            font-size: 14px;
            color: #666;
        }
        .auth-switch a {
            color: #8a5a2b;
            font-weight: 600;
            text-decoration: none;
        }
    </style>
</head>
<body>

    <jsp:include page="/includes/navbar.jsp" />

    <div class="auth-wrapper">
        <div class="auth-split-card">
            <!-- Left Banner -->
            <div class="auth-hero-banner">
                <div>
                    <span style="font-size: 12px; font-weight:700; letter-spacing:1.5px; text-transform:uppercase; color:#d5c8be;">Welcome Back</span>
                    <h2>Step Back Into Style.</h2>
                    <p>Log into your Sole Mate account to view active orders, manage your cart, and enjoy fast checkout.</p>
                </div>
                <div class="perks-list">
                    <div class="perk-item">
                        <span class="perk-check">&#10004;</span>
                        <span>Track order deliveries in real time</span>
                    </div>
                    <div class="perk-item">
                        <span class="perk-check">&#10004;</span>
                        <span>Save multiple delivery addresses</span>
                    </div>
                    <div class="perk-item">
                        <span class="perk-check">&#10004;</span>
                        <span>Exclusive member seasonal discounts</span>
                    </div>
                </div>
            </div>

            <!-- Right Form -->
            <div class="auth-form-panel">
                <div class="form-heading">
                    <h3>Account Login</h3>
                    <p>Enter your credentials to access your account.</p>
                </div>

                <% if (error != null) { %>
                    <div class="alert-error">&#9888; <%= error %></div>
                <% } %>
                <% if (registered) { %>
                    <div class="alert-success">&#10004; Registration successful! Please login with your details.</div>
                <% } %>
                <% if (msg != null) { %>
                    <div class="alert-success">&#128712; <%= msg %></div>
                <% } %>

                <form action="<%= request.getContextPath() %>/login" method="POST">
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" name="email" class="form-control" placeholder="name@example.com" value="vijay@example.com" required>
                    </div>

                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" name="password" class="form-control" placeholder="Enter password" value="123456" required>
                    </div>

                    <button type="submit" class="btn-submit">Sign In &rarr;</button>
                </form>

                <div class="auth-switch">
                    Don't have an account? <a href="<%= request.getContextPath() %>/register">Create Account</a>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/includes/footer.jsp" />

</body>
</html>