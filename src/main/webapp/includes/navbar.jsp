<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.fashionshoestore.model.User" %>
<%
    User navUser = (User) session.getAttribute("user");
    String currentURI = request.getRequestURI();
    String currentQuery = request.getQueryString();
    String contextPath = request.getContextPath();
%>
<header class="site-header">
    <div class="header-container">
        <!-- LOGO -->
        <a href="<%= contextPath %>/index.jsp" class="brand">
            <div class="brand-box">SM</div>
            <div class="brand-text">
                <div class="brand-name">SOLE MATE</div>
                <div class="brand-tagline">STEP INTO STYLE</div>
            </div>
        </a>

        <!-- NAVIGATION -->
        <nav class="main-nav">
            <a href="<%= contextPath %>/index.jsp" class="<%= (currentURI != null && (currentURI.endsWith("index.jsp") || currentURI.endsWith("/FashionShoeStore/") || currentURI.endsWith("/FashionShoeStore"))) ? "active" : "" %>">HOME</a>
            <a href="<%= contextPath %>/products" class="<%= (currentURI != null && currentURI.contains("products") && (currentQuery == null || currentQuery.isEmpty() || currentQuery.startsWith("search="))) ? "active" : "" %>">SHOP</a>
            <a href="<%= contextPath %>/products?category=Men" class="<%= (currentQuery != null && currentQuery.contains("category=Men")) ? "active" : "" %>">MEN</a>
            <a href="<%= contextPath %>/products?category=Women" class="<%= (currentQuery != null && currentQuery.contains("category=Women")) ? "active" : "" %>">WOMEN</a>
            <a href="<%= contextPath %>/products?category=Kids" class="<%= (currentQuery != null && currentQuery.contains("category=Kids")) ? "active" : "" %>">KIDS</a>
            <a href="<%= contextPath %>/products">NEW ARRIVALS</a>
            <a href="<%= contextPath %>/products">OFFERS</a>
        </nav>

        <!-- ACCOUNT / USER ACTIONS -->
        <div class="header-actions">
            <% if (navUser != null) { %>
                <span class="header-user">Hi, <%= navUser.getName() %></span>
                <a href="<%= contextPath %>/my-orders">My Orders</a>
                <a href="<%= contextPath %>/wishlist">Wishlist</a>
                <a href="<%= contextPath %>/logout">Logout</a>
            <% } else { %>
                <a href="<%= contextPath %>/login.jsp">Login</a>
                <a href="<%= contextPath %>/register.jsp">Register</a>
            <% } %>
            <a href="<%= contextPath %>/cart">Cart</a>
        </div>
    </div>
</header>