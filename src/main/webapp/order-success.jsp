<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.fashionshoestore.model.Order" %>
<%@ page import="com.fashionshoestore.model.User" %>
<%
    User loggedUser = (User) session.getAttribute("user");
    Order order = (Order) request.getAttribute("order");
    Integer orderId = (Integer) request.getAttribute("orderId");
    if (orderId == null && order != null) {
        orderId = order.getOrderId();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed | Sole Mate</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .success-page {
            min-height: 65vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 50px 20px;
        }
        .success-card {
            background: #fff;
            max-width: 580px;
            width: 100%;
            padding: 50px 35px;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.07);
            text-align: center;
        }
        .checkmark-circle {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: #eafaf1;
            color: #27ae60;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            margin: 0 auto 20px;
        }
        .success-card h1 {
            font-family: 'DM Serif Display', serif;
            font-size: 36px;
            margin-bottom: 12px;
            color: #222;
        }
        .success-card p {
            color: #666;
            font-size: 15px;
            line-height: 1.6;
            margin-bottom: 25px;
        }
        .order-badge-box {
            background: #fdfaf6;
            border: 1.5px dashed #d5c8be;
            border-radius: 10px;
            padding: 18px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-around;
        }
        .order-stat {
            text-align: center;
        }
        .stat-label {
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #888;
            margin-bottom: 4px;
        }
        .stat-val {
            font-size: 17px;
            font-weight: 700;
            color: #222;
        }
        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
        }
        .btn-primary {
            background: #222;
            color: #fff;
            padding: 13px 25px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 15px;
        }
        .btn-primary:hover {
            background: #8a5a2b;
        }
        .btn-secondary {
            background: #f3eadf;
            color: #8a5a2b;
            padding: 13px 25px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 15px;
        }
        .btn-secondary:hover {
            background: #e5d7c8;
        }
    </style>
</head>
<body>

    <jsp:include page="/includes/navbar.jsp" />

    <div class="success-page">
        <div class="success-card">
            <div class="checkmark-circle">&#10004;</div>
            <h1>Thank You for Your Order!</h1>
            <p>Your footwear order has been placed successfully and is now being prepared for express delivery.</p>

            <div class="order-badge-box">
                <div class="order-stat">
                    <div class="stat-label">Order Number</div>
                    <div class="stat-val">#SM-<%= orderId != null ? orderId : "1001" %></div>
                </div>
                <div class="order-stat">
                    <div class="stat-label">Status</div>
                    <div class="stat-val" style="color: #27ae60;">Confirmed</div>
                </div>
                <% if (order != null) { %>
                    <div class="order-stat">
                        <div class="stat-label">Total Amount</div>
                        <div class="stat-val">&#8377;<%= String.format("%.2f", order.getTotalAmount()) %></div>
                    </div>
                <% } %>
            </div>

            <div class="btn-group">
                <% if (orderId != null) { %>
                    <a href="<%= request.getContextPath() %>/order-details?orderIdQueue=<%= orderId %>&orderId=<%= orderId %>" class="btn-primary">View Order Details</a>
                <% } %>
                <a href="<%= request.getContextPath() %>/my-orders" class="btn-secondary">My Orders</a>
                <a href="<%= request.getContextPath() %>/products" class="btn-primary">Continue Shopping</a>
            </div>
        </div>
    </div>

    <jsp:include page="/includes/footer.jsp" />

</body>
</html>