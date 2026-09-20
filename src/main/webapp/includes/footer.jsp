<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.fashionshoestore.model.User" %>
<%
    User footerUser = (User) session.getAttribute("user");
    String footerContext = request.getContextPath();
%>
<footer>
    <div class="footer-logo">
        <h2>SOLE MATE</h2>
        <p>Step into style. Walk with confidence.</p>
    </div>
    <div class="footer-links">
        <a href="<%= footerContext %>/index.jsp">Home</a>
        <a href="<%= footerContext %>/products">Shop</a>
        <a href="<%= footerContext %>/wishlist">Wishlist</a>
        <a href="<%= footerContext %>/cart">Cart</a>
        <a href="<%= footerContext %>/my-orders">My Orders</a>
        <% if (footerUser != null) { %>
            <a href="<%= footerContext %>/logout">Logout</a>
        <% } else { %>
            <a href="<%= footerContext %>/login.jsp">Login</a>
            <a href="<%= footerContext %>/register.jsp">Register</a>
        <% } %>
    </div>
    <p class="copyright">&copy; 2026 Sole Mate. All rights reserved.</p>
</footer>