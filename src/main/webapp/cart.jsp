<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionshoestore.model.Cart" %>
<%@ page import="com.fashionshoestore.model.CartItem" %>
<%@ page import="com.fashionshoestore.model.User" %>
<%
    User loggedUser = (User) session.getAttribute("user");
    Cart cart = (Cart) request.getAttribute("cart");
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    if (cartItems == null && cart != null) {
        cartItems = cart.getItems();
    }
    double totalAmount = (cart != null) ? cart.getTotalAmount() : 0.0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - Sole Mate</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .cart-wrapper {
            max-width: 1200px;
            margin: 40px auto 80px;
            padding: 0 20px;
        }
        .cart-title {
            font-family: 'DM Serif Display', serif;
            font-size: 38px;
            margin-bottom: 30px;
        }
        .cart-layout {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 35px;
        }
        @media (max-width: 900px) {
            .cart-layout {
                grid-template-columns: 1fr;
            }
        }
        .cart-items-box {
            background: #fff;
            border-radius: 14px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        .cart-item-row {
            display: grid;
            grid-template-columns: 100px 1fr auto auto auto;
            gap: 20px;
            align-items: center;
            padding: 20px 0;
            border-bottom: 1px solid #eee;
        }
        .cart-item-row:last-child {
            border-bottom: none;
        }
        .cart-item-img {
            width: 90px;
            height: 90px;
            background: #fbf7f2;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .cart-item-img img {
            max-width: 85%;
            max-height: 85%;
            object-fit: contain;
        }
        .item-details h3 {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 6px;
        }
        .item-size-badge {
            display: inline-block;
            font-size: 12px;
            font-weight: 600;
            color: #8a5a2b;
            background: #fdf5ec;
            padding: 3px 8px;
            border-radius: 4px;
        }
        .item-unit-price {
            font-size: 15px;
            color: #666;
        }
        .item-qty-form {
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .qty-control-btn {
            background: #f7f3ee;
            border: 1px solid #ddd;
            width: 28px;
            height: 28px;
            border-radius: 4px;
            font-weight: 700;
            cursor: pointer;
        }
        .qty-num {
            font-size: 14px;
            font-weight: 600;
            min-width: 20px;
            text-align: center;
        }
        .item-subtotal {
            font-size: 16px;
            font-weight: 700;
            color: #222;
        }
        .item-delete-btn {
            background: none;
            border: none;
            color: #e74c3c;
            cursor: pointer;
            font-size: 18px;
        }
        .order-summary-box {
            background: #fff;
            border-radius: 14px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            height: fit-content;
        }
        .summary-title {
            font-family: 'DM Serif Display', serif;
            font-size: 24px;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        .summary-line {
            display: flex;
            justify-content: space-between;
            font-size: 15px;
            margin-bottom: 14px;
            color: #555;
        }
        .summary-total {
            display: flex;
            justify-content: space-between;
            font-size: 19px;
            font-weight: 700;
            color: #222;
            margin-top: 20px;
            padding-top: 15px;
            border-top: 2px solid #eee;
        }
        .btn-checkout {
            display: block;
            width: 100%;
            background: #222;
            color: #fff;
            text-align: center;
            padding: 16px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 700;
            text-decoration: none;
            margin-top: 25px;
            transition: background 0.2s ease;
        }
        .btn-checkout:hover {
            background: #8a5a2b;
        }
        .empty-cart-card {
            text-align: center;
            padding: 60px 20px;
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        .empty-cart-card h2 {
            font-family: 'DM Serif Display', serif;
            font-size: 32px;
            margin-bottom: 10px;
        }
        .empty-cart-card p {
            color: #777;
            margin-bottom: 25px;
        }
    </style>
</head>
<body>

    <jsp:include page="/includes/navbar.jsp" />

    <div class="cart-wrapper">
        <h1 class="cart-title">Shopping Cart</h1>

        <% if (cartItems != null && !cartItems.isEmpty()) { %>
            <div class="cart-layout">
                <!-- Cart Items List -->
                <div class="cart-items-box">
                    <% for (CartItem item : cartItems) { %>
                        <div class="cart-item-row">
                            <div class="cart-item-img">
                                <img src="<%= request.getContextPath() %>/<%= item.getImageUrl() %>" alt="<%= item.getProductName() %>">
                            </div>
                            <div class="item-details">
                                <h3><%= item.getProductName() %></h3>
                                <span class="item-size-badge">Size: <%= item.getSizeLabel() %></span>
                            </div>
                            <div class="item-unit-price">
                                &#8377;<%= String.format("%.2f", item.getUnitPrice()) %>
                            </div>
                            <div class="item-qty-form">
                                <form action="<%= request.getContextPath() %>/cart/update" method="POST" style="display:inline;">
                                    <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
                                    <input type="hidden" name="quantity" value="<%= item.getQuantity() - 1 %>">
                                    <button type="submit" class="qty-control-btn">-</button>
                                </form>
                                <span class="qty-num"><%= item.getQuantity() %></span>
                                <form action="<%= request.getContextPath() %>/cart/update" method="POST" style="display:inline;">
                                    <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
                                    <input type="hidden" name="quantity" value="<%= item.getQuantity() + 1 %>">
                                    <button type="submit" class="qty-control-btn">+</button>
                                </form>
                            </div>
                            <div class="item-subtotal">
                                &#8377;<%= String.format("%.2f", item.getSubtotal()) %>
                            </div>
                            <form action="<%= request.getContextPath() %>/cart/remove" method="POST">
                                <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
                                <button type="submit" class="item-delete-btn" title="Remove item">&times;</button>
                            </form>
                        </div>
                    <% } %>
                </div>

                <!-- Order Summary -->
                <div class="order-summary-box">
                    <h2 class="summary-title">Order Summary</h2>
                    <div class="summary-line">
                        <span>Items Subtotal</span>
                        <span>&#8377;<%= String.format("%.2f", totalAmount) %></span>
                    </div>
                    <div class="summary-line">
                        <span>Standard Shipping</span>
                        <span style="color: #27ae60; font-weight: 600;">FREE</span>
                    </div>
                    <div class="summary-line">
                        <span>Estimated Tax</span>
                        <span>Included</span>
                    </div>
                    <div class="summary-total">
                        <span>Total Amount</span>
                        <span>&#8377;<%= String.format("%.2f", totalAmount) %></span>
                    </div>
                    <a href="<%= request.getContextPath() %>/checkout" class="btn-checkout">Proceed to Checkout &rarr;</a>
                </div>
            </div>
        <% } else { %>
            <div class="empty-cart-card">
                <h2>Your Shopping Cart is Empty</h2>
                <p>Explore our premium footwear collection and find your perfect pair.</p>
                <a href="<%= request.getContextPath() %>/products" class="btn-checkout" style="max-width: 250px; margin: 0 auto;">Shop Shoes</a>
            </div>
        <% } %>
    </div>

    <jsp:include page="/includes/footer.jsp" />

</body>
</html>