<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <title>Checkout - Sole Mate</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .checkout-page {
            max-width: 1100px;
            margin: 40px auto 80px;
            padding: 0 20px;
        }
        .checkout-title {
            text-align: center;
            margin-bottom: 35px;
        }
        .checkout-title h1 {
            font-family: 'DM Serif Display', serif;
            font-size: 40px;
            margin-bottom: 8px;
        }
        .checkout-grid {
            display: grid;
            grid-template-columns: 1.3fr 0.9fr;
            gap: 35px;
        }
        @media (max-width: 850px) {
            .checkout-grid {
                grid-template-columns: 1fr;
            }
        }
        .checkout-card {
            background: #fff;
            padding: 30px;
            border-radius: 14px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.06);
        }
        .checkout-card h2 {
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
        .payment-options {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin-top: 15px;
        }
        .payment-label {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            border: 1.5px solid #e0d5cb;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
        }
        .payment-label input {
            cursor: pointer;
        }
        .mini-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
            font-size: 14px;
        }
        .mini-item-name {
            font-weight: 600;
            color: #333;
        }
        .mini-item-meta {
            font-size: 12px;
            color: #777;
        }
        .btn-place-order {
            width: 100%;
            background: #222;
            color: #fff;
            padding: 16px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 700;
            border: none;
            cursor: pointer;
            margin-top: 25px;
            transition: background 0.2s ease;
        }
        .btn-place-order:hover {
            background: #8a5a2b;
        }
    </style>
</head>
<body>

    <jsp:include page="/includes/navbar.jsp" />

    <div class="checkout-page">
        <div class="checkout-title">
            <h1>Complete Your Order</h1>
            <p>Review delivery details and choose your preferred payment option.</p>
        </div>

        <form action="<%= request.getContextPath() %>/checkout" method="POST">
            <div class="checkout-grid">
                <!-- Left: Shipping & Payment -->
                <div class="checkout-card">
                    <h2>1. Shipping Details</h2>
                    <div class="form-group">
                        <label>Recipient Name</label>
                        <input type="text" class="form-control" value="<%= loggedUser != null ? loggedUser.getFullName() : "" %>" readonly>
                    </div>
                    <div class="form-group">
                        <label>Contact Phone</label>
                        <input type="text" class="form-control" value="<%= loggedUser != null ? loggedUser.getPhone() : "" %>" readonly>
                    </div>
                    <div class="form-group">
                        <label>Delivery Address *</label>
                        <textarea name="deliveryAddress" rows="3" class="form-control" required><%= loggedUser != null ? loggedUser.getAddress() : "" %></textarea>
                    </div>

                    <h2 style="margin-top: 35px;">2. Payment Method</h2>
                    <div class="payment-options">
                        <label class="payment-label">
                            <input type="radio" name="paymentMethod" value="Cash on Delivery" checked>
                            <span>&#128181; Cash on Delivery (COD)</span>
                        </label>
                        <label class="payment-label">
                            <input type="radio" name="paymentMethod" value="UPI / QR Code">
                            <span>&#128241; UPI / Net Banking</span>
                        </label>
                        <label class="payment-label">
                            <input type="radio" name="paymentMethod" value="Credit / Debit Card">
                            <span>&#128179; Credit / Debit Card</span>
                        </label>
                    </div>
                </div>

                <!-- Right: Order Summary -->
                <div class="checkout-card">
                    <h2>Order Summary</h2>
                    <div style="margin-bottom: 20px;">
                        <% if (cartItems != null) {
                            for (CartItem ci : cartItems) {
                        %>
                            <div class="mini-item">
                                <div>
                                    <div class="mini-item-name"><%= ci.getProductName() %></div>
                                    <div class="mini-item-meta">Size: <%= ci.getSizeLabel() %> &times; <%= ci.getQuantity() %></div>
                                </div>
                                <div style="font-weight: 600;">&#8377;<%= String.format("%.2f", ci.getSubtotal()) %></div>
                            </div>
                        <%   }
                           } %>
                    </div>

                    <div style="display:flex; justify-content:space-between; margin-bottom:10px; font-size:15px; color:#555;">
                        <span>Subtotal</span>
                        <span>&#8377;<%= String.format("%.2f", totalAmount) %></span>
                    </div>
                    <div style="display:flex; justify-content:space-between; margin-bottom:10px; font-size:15px; color:#555;">
                        <span>Delivery</span>
                        <span style="color:#27ae60; font-weight:600;">FREE</span>
                    </div>
                    <div style="display:flex; justify-content:space-between; font-size:20px; font-weight:700; color:#222; padding-top:15px; border-top:2px solid #eee; margin-top:15px;">
                        <span>Total Due</span>
                        <span>&#8377;<%= String.format("%.2f", totalAmount) %></span>
                    </div>

                    <button type="submit" class="btn-place-order">&#10004; Place Order Now</button>
                </div>
            </div>
        </form>
    </div>

    <jsp:include page="/includes/footer.jsp" />

</body>
</html>