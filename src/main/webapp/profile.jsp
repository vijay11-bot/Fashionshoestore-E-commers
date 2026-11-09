<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionshoestore.model.Order" %>
<%@ page import="com.fashionshoestore.model.User" %>
<%
    User user = (User) request.getAttribute("user");
    if (user == null) {
        user = (User) session.getAttribute("user");
    }
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    List<Order> recentOrders = (List<Order>) request.getAttribute("recentOrders");
    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | Sole Mate</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .profile-page {
            max-width: 1100px;
            margin: 40px auto 80px;
            padding: 0 20px;
        }
        .profile-header {
            margin-bottom: 30px;
        }
        .profile-header h1 {
            font-family: 'DM Serif Display', serif;
            font-size: 38px;
            margin-bottom: 8px;
        }
        .profile-grid {
            display: grid;
            grid-template-columns: 1.2fr 1fr;
            gap: 35px;
        }
        @media (max-width: 850px) {
            .profile-grid {
                grid-template-columns: 1fr;
            }
        }
        .profile-card {
            background: #fff;
            padding: 30px;
            border-radius: 14px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.06);
            margin-bottom: 25px;
        }
        .profile-card h2 {
            font-family: 'DM Serif Display', serif;
            font-size: 24px;
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 1px solid #eee;
        }
        .form-group {
            margin-bottom: 18px;
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
            padding: 12px 15px;
            border: 1.5px solid #d5c8be;
            border-radius: 8px;
            font-size: 15px;
            font-family: inherit;
        }
        .form-control:focus {
            outline: none;
            border-color: #222;
        }
        .btn-save {
            background: #222;
            color: #fff;
            padding: 14px 28px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 700;
            border: none;
            cursor: pointer;
            transition: background 0.2s ease;
        }
        .btn-save:hover {
            background: #8a5a2b;
        }
        .alert-success {
            background: #eafaf1;
            color: #27ae60;
            padding: 14px 18px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 600;
        }
        .alert-error {
            background: #fdf2f2;
            color: #e74c3c;
            padding: 14px 18px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 600;
        }
        .user-avatar-badge {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background: #f3eadf;
            color: #8a5a2b;
            font-size: 28px;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

    <jsp:include page="/includes/navbar.jsp" />

    <div class="profile-page">
        <div class="profile-header">
            <h1>Account Profile</h1>
            <p style="color: #777;">Manage your personal profile, contact information, and shipping address.</p>
        </div>

        <% if (success != null) { %>
            <div class="alert-success">&#10004; <%= success %></div>
        <% } %>
        <% if (error != null) { %>
            <div class="alert-error">&#9888; <%= error %></div>
        <% } %>

        <div class="profile-grid">
            <!-- Left: Edit Profile Form -->
            <div class="profile-card">
                <div class="user-avatar-badge">
                    <%= user.getFullName() != null && !user.getFullName().isEmpty() ? user.getFullName().substring(0, 1).toUpperCase() : "U" %>
                </div>
                <h2>Edit Personal Information</h2>

                <form action="<%= request.getContextPath() %>/profile" method="POST">
                    <div class="form-group">
                        <label>Full Name</label>
                        <input type="text" name="fullName" class="form-control" value="<%= user.getFullName() %>" required>
                    </div>

                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" class="form-control" value="<%= user.getEmail() %>" disabled style="background:#f8f5f0; cursor:not-allowed;">
                    </div>

                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="text" name="phone" class="form-control" value="<%= user.getPhone() != null ? user.getPhone() : "" %>" placeholder="+91 9876543210">
                    </div>

                    <div class="form-group">
                        <label>Gender</label>
                        <select name="gender" class="form-control">
                            <option value="Male" <%= "Male".equalsIgnoreCase(user.getGender()) ? "selected" : "" %>>Male</option>
                            <option value="Female" <%= "Female".equalsIgnoreCase(user.getGender()) ? "selected" : "" %>>Female</option>
                            <option value="Other" <%= "Other".equalsIgnoreCase(user.getGender()) ? "selected" : "" %>>Other</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Delivery Address</label>
                        <textarea name="address" rows="3" class="form-control" placeholder="House/Flat No., Street, City, State, Pincode"><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>
                    </div>

                    <button type="submit" class="btn-save">Save Changes</button>
                </form>
            </div>

            <!-- Right: Account Overview & Orders -->
            <div>
                <div class="profile-card">
                    <h2>Account Overview</h2>
                    <div style="font-size: 14px; line-height: 1.8; color: #555;">
                        <p><strong>Member Since:</strong> 2026</p>
                        <p><strong>Account Status:</strong> <span style="color: #27ae60; font-weight: 600;">Active</span></p>
                        <p><strong>Default Address:</strong> <%= user.getAddress() != null && !user.getAddress().isEmpty() ? user.getAddress() : "No address saved" %></p>
                    </div>
                </div>

                <div class="profile-card">
                    <h2>Recent Orders</h2>
                    <% if (recentOrders != null && !recentOrders.isEmpty()) { %>
                        <div style="display: flex; flex-direction: column; gap: 12px;">
                            <%
                                int showLimit = Math.min(3, recentOrders.size());
                                for (int i = 0; i < showLimit; i++) {
                                    Order ro = recentOrders.get(i);
                            %>
                                <div style="display: flex; justify-content: space-between; align-items: center; padding: 10px 0; border-bottom: 1px solid #f0f0f0;">
                                    <div>
                                        <div style="font-weight: 600;">#SM-<%= ro.getOrderId() %></div>
                                        <div style="font-size: 12px; color: #888;"><%= ro.getOrderDate() != null ? ro.getOrderDate().toString().substring(0, 10) : "" %></div>
                                    </div>
                                    <div style="text-align: right;">
                                        <div style="font-weight: 700;">&#8377;<%= String.format("%.2f", ro.getTotalAmount()) %></div>
                                        <a href="<%= request.getContextPath() %>/order-details?orderId=<%= ro.getOrderId() %>" style="font-size: 12px; color: #8a5a2b; font-weight: 600;">View &rarr;</a>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                        <div style="margin-top: 15px; text-align: center;">
                            <a href="<%= request.getContextPath() %>/my-orders" style="font-size: 13px; font-weight: 600; color: #222;">See All Orders &rarr;</a>
                        </div>
                    <% } else { %>
                        <p style="color: #777; font-size: 14px;">No recent orders. <a href="<%= request.getContextPath() %>/products" style="color: #8a5a2b; font-weight: 600;">Start Shopping</a></p>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/includes/footer.jsp" />

</body>
</html>
