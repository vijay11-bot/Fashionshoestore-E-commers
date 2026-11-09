<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.fashionshoestore.model.User" %>
<%
    User loggedUser = (User) session.getAttribute("user");
    if (loggedUser != null) {
        response.sendRedirect(request.getContextPath() + "/home");
        return;
    }
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account | Sole Mate</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .auth-wrapper {
            max-width: 1050px;
            margin: 40px auto 80px;
            padding: 0 20px;
        }
        .auth-split-card {
            display: grid;
            grid-template-columns: 1fr 1.2fr;
            background: #fff;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 35px rgba(0,0,0,0.08);
        }
        @media (max-width: 800px) {
            .auth-split-card {
                grid-template-columns: 1fr;
            }
            .auth-hero-banner {
                display: none;
            }
        }
        .auth-hero-banner {
            background: linear-gradient(135deg, #1b1614 0%, #362922 100%);
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
        .auth-form-panel {
            padding: 45px;
        }
        .form-heading h3 {
            font-family: 'DM Serif Display', serif;
            font-size: 30px;
            margin-bottom: 6px;
            color: #222;
        }
        .form-heading p {
            color: #777;
            font-size: 14px;
            margin-bottom: 22px;
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        @media (max-width: 550px) {
            .form-row {
                grid-template-columns: 1fr;
            }
        }
        .form-group {
            margin-bottom: 16px;
        }
        .form-group label {
            display: block;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #555;
            margin-bottom: 6px;
        }
        .form-control {
            width: 100%;
            padding: 11px 14px;
            border: 1.5px solid #d5c8be;
            border-radius: 8px;
            font-size: 14px;
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
            padding: 14px;
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
        .auth-switch {
            text-align: center;
            margin-top: 20px;
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
            <!-- Left Promo Banner -->
            <div class="auth-hero-banner">
                <div>
                    <span style="font-size: 12px; font-weight:700; letter-spacing:1.5px; text-transform:uppercase; color:#d5c8be;">Join The Community</span>
                    <h2>Exclusive Perks. Premium Footwear.</h2>
                    <p>Create your Sole Mate account today and get access to premier shoe drops, early sale notifications, and fast checkout.</p>
                </div>
                <div style="font-size: 13px; color: #a89a8f;">
                    &starf; Rated 4.9/5 by over 10,000+ happy customers across the globe.
                </div>
            </div>

            <!-- Right Registration Form -->
            <div class="auth-form-panel">
                <div class="form-heading">
                    <h3>Register Account</h3>
                    <p>Fill in your details to start shopping.</p>
                </div>

                <% if (error != null) { %>
                    <div class="alert-error">&#9888; <%= error %></div>
                <% } %>

                <form action="<%= request.getContextPath() %>/register" method="POST">
                    <div class="form-group">
                        <label>Full Name *</label>
                        <input type="text" name="fullName" class="form-control" placeholder="John Doe" required>
                    </div>

                    <div class="form-group">
                        <label>Email Address *</label>
                        <input type="email" name="email" class="form-control" placeholder="john@example.com" required>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Phone Number</label>
                            <input type="text" name="phone" class="form-control" placeholder="+91 9876543210">
                        </div>
                        <div class="form-group">
                            <label>Gender</label>
                            <select name="gender" class="form-control">
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Password *</label>
                        <input type="password" name="password" class="form-control" placeholder="At least 6 characters" required>
                    </div>

                    <div class="form-group">
                        <label>Delivery Address</label>
                        <textarea name="address" rows="2" class="form-control" placeholder="House / Flat, Street, City, State, Pincode"></textarea>
                    </div>

                    <button type="submit" class="btn-submit">Create Account &rarr;</button>
                </form>

                <div class="auth-switch">
                    Already have an account? <a href="<%= request.getContextPath() %>/login">Sign In</a>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/includes/footer.jsp" />

</body>
</html>