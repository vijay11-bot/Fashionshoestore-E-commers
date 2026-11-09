<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.fashionshoestore.model.User" %>
<%@ page import="com.fashionshoestore.dao.CartDAO" %>
<%
    User navUser = (User) session.getAttribute("user");
    String currentURI = request.getRequestURI();
    String currentQuery = request.getQueryString();
    String contextPath = request.getContextPath();
    int navCartCount = 0;
    if (navUser != null) {
        try {
            navCartCount = new CartDAO().getCartCount(navUser.getUserId());
        } catch (Exception ignored) {}
    }
%>
<header class="site-header">
    <div class="header-container">
        <!-- LOGO -->
        <a href="<%= contextPath %>/home" class="brand">
            <div class="brand-box">SM</div>
            <div class="brand-text">
                <div class="brand-name">SOLE MATE</div>
                <div class="brand-tagline">STEP INTO STYLE</div>
            </div>
        </a>

        <!-- NAVIGATION -->
        <nav class="main-nav">
            <a href="<%= contextPath %>/home" class="<%= (currentURI != null && (currentURI.endsWith("home") || currentURI.endsWith("index.jsp") || currentURI.endsWith("/FashionShoeStore/") || currentURI.endsWith("/FashionShoeStore"))) ? "active" : "" %>">HOME</a>
            <a href="<%= contextPath %>/products" class="<%= (currentURI != null && currentURI.endsWith("products") && (currentQuery == null || currentQuery.isEmpty() || currentQuery.startsWith("search="))) ? "active" : "" %>">SHOP</a>
            <a href="<%= contextPath %>/products?category=Men" class="<%= (currentQuery != null && currentQuery.contains("category=Men")) ? "active" : "" %>">MEN</a>
            <a href="<%= contextPath %>/products?category=Women" class="<%= (currentQuery != null && currentQuery.contains("category=Women")) ? "active" : "" %>">WOMEN</a>
            <a href="<%= contextPath %>/products?category=Kids" class="<%= (currentQuery != null && currentQuery.contains("category=Kids")) ? "active" : "" %>">KIDS</a>
            <a href="<%= contextPath %>/products?sort=discount">SALE</a>
        </nav>

        <!-- ACCOUNT / USER ACTIONS -->
        <div class="header-actions">
            <% if (navUser != null) { %>
                <a href="<%= contextPath %>/profile" class="header-user" title="My Profile">&#128100; <%= navUser.getFullName() %></a>
                <a href="<%= contextPath %>/my-orders">My Orders</a>
                <a href="<%= contextPath %>/logout">Logout</a>
            <% } else { %>
                <a href="<%= contextPath %>/login">Login</a>
                <a href="<%= contextPath %>/register">Register</a>
            <% } %>
            <a href="<%= contextPath %>/cart" class="cart-btn">
                <span>&#128722; Cart</span>
                <% if (navCartCount > 0) { %>
                    <span class="badge"><%= navCartCount %></span>
                <% } %>
            </a>
        </div>
    </div>
</header>