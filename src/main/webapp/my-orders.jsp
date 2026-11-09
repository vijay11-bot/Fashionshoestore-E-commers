<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionshoestore.model.Order" %>
<%@ page import="com.fashionshoestore.model.User" %>
<%
    User loggedUser = (User) session.getAttribute("user");
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - Sole Mate</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .orders-page {
            max-width: 1100px;
            margin: 40px auto 80px;
            padding: 0 20px;
        }
        .orders-header {
            text-align: center;
            margin-bottom: 35px;
        }
        .orders-header h1 {
            font-family: 'DM Serif Display', serif;
            font-size: 38px;
            margin-bottom: 8px;
        }
        .orders-card {
            background: #fff;
            border-radius: 14px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.06);
            overflow-x: auto;
        }
        .orders-table {
            width: 100%;
            border-collapse: collapse;
        }
        .orders-table th {
            text-align: left;
            padding: 14px 18px;
            background: #f7f3ee;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #555;
            border-bottom: 1.5px solid #e5dbd1;
        }
        .orders-table td {
            padding: 18px;
            border-bottom: 1px solid #eee;
            font-size: 14px;
            color: #333;
        }
        .orders-table tr:last-child td {
            border-bottom: none;
        }
        .order-id {
            font-weight: 700;
            color: #222;
        }
        .status-pill {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            background: #eafaf1;
            color: #27ae60;
        }
        .btn-view-order {
            display: inline-block;
            padding: 7px 15px;
            background: #222;
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
        }
        .btn-view-order:hover {
            background: #8a5a2b;
        }
        .empty-orders {
            text-align: center;
            padding: 50px 20px;
        }
        .empty-orders h2 {
            font-family: 'DM Serif Display', serif;
            font-size: 28px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

    <jsp:include page="/includes/navbar.jsp" />

    <div class="orders-page">
        <div class="orders-header">
            <h1>Your Order History</h1>
            <p>Track delivery status and review your previous purchases.</p>
        </div>

        <div class="orders-card">
            <% if (orders != null && !orders.isEmpty()) { %>
                <table class="orders-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Date Placed</th>
                            <th>Total Amount</th>
                            <th>Payment</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Order o : orders) { %>
                            <tr>
                                <td class="order-id">#SM-<%= o.getOrderId() %></td>
                                <td><%= o.getOrderDate() != null ? o.getOrderDate().toString().substring(0, 16) : "Recent" %></td>
                                <td style="font-weight: 700;">&#8377;<%= String.format("%.2f", o.getTotalAmount()) %></td>
                                <td><%= o.getPaymentMethod() %></td>
                                <td><span class="status-pill"><%= o.getOrderStatus() %></span></td>
                                <td>
                                    <a href="<%= request.getContextPath() %>/order-details?orderId=<%= o.getOrderId() %>" class="btn-view-order">View Details</a>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="empty-orders">
                    <h2>No Orders Found</h2>
                    <p style="color: #777; margin-bottom: 25px;">You haven't placed any orders yet. Discover our latest footwear collection!</p>
                    <a href="<%= request.getContextPath() %>/products" class="btn-view-order" style="padding: 12px 25px;">Shop Now</a>
                </div>
            <% } %>
        </div>
    </div>

    <jsp:include page="/includes/footer.jsp" />

</body>
</html>