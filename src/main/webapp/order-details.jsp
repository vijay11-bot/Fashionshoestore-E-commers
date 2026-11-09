<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionshoestore.model.Order" %>
<%@ page import="com.fashionshoestore.model.OrderItem" %>
<%@ page import="com.fashionshoestore.model.User" %>
<%
    User loggedUser = (User) session.getAttribute("user");
    Order order = (Order) request.getAttribute("order");
    List<OrderItem> orderItems = (List<OrderItem>) request.getAttribute("orderItems");
    if (orderItems == null && order != null) {
        orderItems = order.getItems();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details #SM-<%= order != null ? order.getOrderId() : "" %> | Sole Mate</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .order-details-page {
            max-width: 1000px;
            margin: 40px auto 80px;
            padding: 0 20px;
        }
        .header-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 15px;
        }
        .header-bar h1 {
            font-family: 'DM Serif Display', serif;
            font-size: 34px;
        }
        .btn-back {
            color: #555;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
        }
        .details-card {
            background: #fff;
            border-radius: 14px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.06);
            margin-bottom: 30px;
        }
        .card-heading {
            font-family: 'DM Serif Display', serif;
            font-size: 22px;
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 1px solid #eee;
        }
        .meta-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        .meta-item-label {
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #888;
            margin-bottom: 5px;
        }
        .meta-item-val {
            font-size: 15px;
            font-weight: 600;
            color: #222;
        }
        .item-row {
            display: grid;
            grid-template-columns: 80px 1fr auto auto;
            gap: 20px;
            align-items: center;
            padding: 18px 0;
            border-bottom: 1px solid #eee;
        }
        .item-row:last-child {
            border-bottom: none;
        }
        .item-thumb {
            width: 75px;
            height: 75px;
            background: #fbf7f2;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .item-thumb img {
            max-width: 85%;
            max-height: 85%;
            object-fit: contain;
        }
        .item-info h4 {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 5px;
        }
        .item-size {
            display: inline-block;
            font-size: 12px;
            font-weight: 600;
            color: #8a5a2b;
            background: #fdf5ec;
            padding: 2px 7px;
            border-radius: 4px;
        }
        .item-calc {
            font-size: 14px;
            color: #666;
        }
        .item-total {
            font-size: 16px;
            font-weight: 700;
            color: #222;
        }
        .order-total-bar {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 25px;
            padding-top: 20px;
            border-top: 2px solid #eee;
            margin-top: 15px;
            font-size: 20px;
            font-weight: 700;
        }
    </style>
</head>
<body>

    <jsp:include page="/includes/navbar.jsp" />

    <div class="order-details-page">
        <div class="header-bar">
            <div>
                <h1>Order #SM-<%= order != null ? order.getOrderId() : "" %></h1>
                <p style="color: #777;">Placed on <%= (order != null && order.getOrderDate() != null) ? order.getOrderDate().toString().substring(0, 16) : "" %></p>
            </div>
            <a href="<%= request.getContextPath() %>/my-orders" class="btn-back">&larr; Back to All Orders</a>
        </div>

        <% if (order != null) { %>
            <!-- Order Status & Address Info -->
            <div class="details-card">
                <div class="meta-grid">
                    <div>
                        <div class="meta-item-label">Order Status</div>
                        <div class="meta-item-val" style="color: #27ae60;"><%= order.getOrderStatus() %></div>
                    </div>
                    <div>
                        <div class="meta-item-label">Payment Method</div>
                        <div class="meta-item-val"><%= order.getPaymentMethod() %></div>
                    </div>
                    <div>
                        <div class="meta-item-label">Recipient</div>
                        <div class="meta-item-val"><%= order.getCustomerName() != null ? order.getCustomerName() : (loggedUser != null ? loggedUser.getFullName() : "") %></div>
                    </div>
                    <div>
                        <div class="meta-item-label">Delivery Address</div>
                        <div class="meta-item-val"><%= order.getDeliveryAddress() %></div>
                    </div>
                </div>
            </div>

            <!-- Items Purchased -->
            <div class="details-card">
                <div class="card-heading">Purchased Items</div>
                <% if (orderItems != null && !orderItems.isEmpty()) {
                    for (OrderItem item : orderItems) {
                %>
                    <div class="item-row">
                        <div class="item-thumb">
                            <% if (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) { %>
                                <img src="<%= request.getContextPath() %>/<%= item.getImageUrl() %>" alt="<%= item.getProductName() %>">
                            <% } else { %>
                                <span style="font-size: 24px;">&#128095;</span>
                            <% } %>
                        </div>
                        <div class="item-info">
                            <h4><%= item.getProductName() %></h4>
                            <span class="item-size">Shoe Size: <%= item.getSizeLabel() %></span>
                        </div>
                        <div class="item-calc">
                            &#8377;<%= String.format("%.2f", item.getUnitPrice()) %> &times; <%= item.getQuantity() %>
                        </div>
                        <div class="item-total">
                            &#8377;<%= String.format("%.2f", item.getSubtotal()) %>
                        </div>
                    </div>
                <%   }
                   } %>

                <div class="order-total-bar">
                    <span>Order Total:</span>
                    <span style="color: #8a5a2b;">&#8377;<%= String.format("%.2f", order.getTotalAmount()) %></span>
                </div>
            </div>
        <% } %>
    </div>

    <jsp:include page="/includes/footer.jsp" />

</body>
</html>