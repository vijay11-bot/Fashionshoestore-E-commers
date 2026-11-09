<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.fashionshoestore.model.User" %>
<%
    User footerUser = (User) session.getAttribute("user");
    String footerContext = request.getContextPath();
%>
<footer class="site-footer">
    <div class="footer-container">
        <div class="footer-logo">
            <h2>SOLE MATE</h2>
            <p>Step into style. Walk with confidence. Premium fashion footwear.</p>
        </div>
        <div class="footer-links">
            <a href="<%= footerContext %>/home">Home</a>
            <a href="<%= footerContext %>/products">Shop All</a>
            <a href="<%= footerContext %>/products?category=Men">Men</a>
            <a href="<%= footerContext %>/products?category=Women">Women</a>
            <a href="<%= footerContext %>/products?category=Kids">Kids</a>
            <a href="<%= footerContext %>/cart">Cart</a>
            <% if (footerUser != null) { %>
                <a href="<%= footerContext %>/profile">Profile</a>
                <a href="<%= footerContext %>/my-orders">My Orders</a>
                <a href="<%= footerContext %>/logout">Logout</a>
            <% } else { %>
                <a href="<%= footerContext %>/login">Login</a>
                <a href="<%= footerContext %>/register">Register</a>
            <% } %>
        </div>
        <p class="copyright">&copy; 2026 Sole Mate Fashion Shoe Store. All rights reserved.</p>
    </div>
</footer>