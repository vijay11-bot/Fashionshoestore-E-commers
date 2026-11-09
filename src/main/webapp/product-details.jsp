<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionshoestore.model.Product" %>
<%@ page import="com.fashionshoestore.model.ProductSize" %>
<%@ page import="com.fashionshoestore.model.User" %>
<%
    Product product = (Product) request.getAttribute("product");
    if (product == null) {
        response.sendRedirect(request.getContextPath() + "/products");
        return;
    }
    List<Product> relatedProducts = (List<Product>) request.getAttribute("relatedProducts");
    List<ProductSize> sizes = product.getSizes();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= product.getProductName() %> | Sole Mate</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .details-container {
            max-width: 1200px;
            margin: 40px auto 80px;
            padding: 0 20px;
        }
        .breadcrumb {
            font-size: 14px;
            color: #888;
            margin-bottom: 25px;
        }
        .breadcrumb a {
            color: #555;
            text-decoration: none;
        }
        .breadcrumb a:hover {
            color: #222;
        }
        .product-main {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 50px;
            background: #ffffff;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 6px 25px rgba(0,0,0,0.06);
        }
        @media (max-width: 850px) {
            .product-main {
                grid-template-columns: 1fr;
            }
        }
        .product-gallery {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .main-img-box {
            width: 100%;
            height: 440px;
            background: #f7f3ee;
            border-radius: 12px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .main-img-box img {
            max-width: 90%;
            max-height: 90%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }
        .main-img-box img:hover {
            transform: scale(1.05);
        }
        .product-info-panel h1 {
            font-family: 'DM Serif Display', serif;
            font-size: 34px;
            color: #222;
            margin-bottom: 10px;
        }
        .category-tag {
            display: inline-block;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.2px;
            color: #8a5a2b;
            background: #fdf5ec;
            padding: 5px 12px;
            border-radius: 20px;
            margin-bottom: 18px;
        }
        .price-box {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
        }
        .final-price {
            font-size: 30px;
            font-weight: 700;
            color: #222;
        }
        .original-price {
            font-size: 20px;
            color: #999;
            text-decoration: line-through;
        }
        .discount-pill {
            background: #e74c3c;
            color: #fff;
            font-size: 13px;
            font-weight: 700;
            padding: 4px 10px;
            border-radius: 6px;
        }
        .product-desc {
            color: #555;
            font-size: 15px;
            line-height: 1.7;
            margin-bottom: 30px;
            padding-bottom: 25px;
            border-bottom: 1px solid #eee;
        }
        .size-section {
            margin-bottom: 25px;
        }
        .size-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        .size-title {
            font-size: 14px;
            font-weight: 700;
            color: #333;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .size-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }
        .size-btn {
            padding: 10px 18px;
            border: 1.5px solid #d5c8be;
            background: #fff;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .size-btn:hover {
            border-color: #222;
        }
        .size-btn.active {
            background: #222;
            color: #fff;
            border-color: #222;
        }
        .size-btn.disabled {
            opacity: 0.4;
            cursor: not-allowed;
            text-decoration: line-through;
        }
        .qty-row {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 30px;
        }
        .qty-label {
            font-size: 14px;
            font-weight: 700;
            text-transform: uppercase;
            color: #333;
        }
        .qty-stepper {
            display: flex;
            align-items: center;
            border: 1.5px solid #d5c8be;
            border-radius: 8px;
            overflow: hidden;
        }
        .qty-btn {
            background: #f7f3ee;
            border: none;
            width: 38px;
            height: 38px;
            font-size: 18px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .qty-btn:hover {
            background: #e8ded4;
        }
        .qty-input {
            width: 45px;
            height: 38px;
            border: none;
            text-align: center;
            font-size: 15px;
            font-weight: 600;
        }
        .btn-add-cart {
            width: 100%;
            background: #222;
            color: #fff;
            padding: 16px 25px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 700;
            border: none;
            cursor: pointer;
            letter-spacing: 0.5px;
            transition: background 0.2s ease;
        }
        .btn-add-cart:hover {
            background: #8a5a2b;
        }
        .related-section {
            margin-top: 70px;
        }
        .related-section h2 {
            font-family: 'DM Serif Display', serif;
            font-size: 28px;
            margin-bottom: 25px;
        }
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 25px;
        }
        .product-card {
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            transition: transform 0.2s ease;
            text-decoration: none;
            color: inherit;
            display: flex;
            flex-direction: column;
        }
        .product-card:hover {
            transform: translateY(-5px);
        }
        .card-img-box {
            height: 200px;
            background: #fdfaf6;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 15px;
        }
        .card-img-box img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }
        .card-body {
            padding: 18px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }
        .card-title {
            font-size: 15px;
            font-weight: 600;
            margin-bottom: 8px;
        }
        .card-price {
            font-size: 16px;
            font-weight: 700;
            color: #222;
            margin-top: auto;
        }
    </style>
</head>
<body>

    <jsp:include page="/includes/navbar.jsp" />

    <div class="details-container">
        <div class="breadcrumb">
            <a href="<%= request.getContextPath() %>/home">Home</a> &gt;
            <a href="<%= request.getContextPath() %>/products">Shop</a> &gt;
            <a href="<%= request.getContextPath() %>/products?category=<%= product.getCategory() %>"><%= product.getCategory() %></a> &gt;
            <span><%= product.getProductName() %></span>
        </div>

        <div class="product-main">
            <!-- Left: Gallery -->
            <div class="product-gallery">
                <div class="main-img-box">
                    <img src="<%= request.getContextPath() %>/<%= product.getImageUrl() %>" alt="<%= product.getProductName() %>" id="mainImage">
                </div>
            </div>

            <!-- Right: Details & Add to Cart -->
            <div class="product-info-panel">
                <span class="category-tag"><%= product.getCategory() %> Footwear</span>
                <h1><%= product.getProductName() %></h1>

                <div class="price-box">
                    <span class="final-price">&#8377;<%= String.format("%.2f", product.getDiscountedPrice()) %></span>
                    <% if (product.getDiscountPercent() > 0) { %>
                        <span class="original-price">&#8377;<%= String.format("%.2f", product.getPrice()) %></span>
                        <span class="discount-pill"><%= (int) product.getDiscountPercent() %>% OFF</span>
                    <% } %>
                </div>

                <p class="product-desc"><%= product.getDescription() %></p>

                <form action="<%= request.getContextPath() %>/cart/add" method="POST" id="addToCartForm">
                    <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                    
                    <!-- SHOE SIZES SELECTOR -->
                    <div class="size-section">
                        <div class="size-header">
                            <span class="size-title">Select Shoe Size</span>
                            <span style="font-size: 13px; color: #888;">Size Guide: Standard UK</span>
                        </div>
                        <div class="size-grid" id="sizeGrid">
                            <%
                                String defaultSize = (sizes != null && !sizes.isEmpty()) ? sizes.get(0).getSizeLabel() : "UK 8";
                                if (sizes != null && !sizes.isEmpty()) {
                                    for (int i = 0; i < sizes.size(); i++) {
                                        ProductSize ps = sizes.get(i);
                                        boolean isAvailable = ps.isAvailable() && ps.getStockQuantity() > 0;
                            %>
                                <button type="button" 
                                        class="size-btn <%= (i == 0 && isAvailable) ? "active" : "" %> <%= !isAvailable ? "disabled" : "" %>"
                                        onclick="selectSize('<%= ps.getSizeLabel() %>', this)"
                                        <%= !isAvailable ? "disabled" : "" %>>
                                    <%= ps.getSizeLabel() %>
                                </button>
                            <%
                                    }
                                } else {
                            %>
                                <button type="button" class="size-btn active" onclick="selectSize('UK 8', this)">UK 8</button>
                                <button type="button" class="size-btn" onclick="selectSize('UK 9', this)">UK 9</button>
                                <button type="button" class="size-btn" onclick="selectSize('UK 10', this)">UK 10</button>
                            <% } %>
                        </div>
                        <input type="hidden" name="sizeLabel" id="selectedSizeInput" value="<%= defaultSize %>">
                    </div>

                    <!-- QUANTITY -->
                    <div class="qty-row">
                        <span class="qty-label">Quantity:</span>
                        <div class="qty-stepper">
                            <button type="button" class="qty-btn" onclick="changeQty(-1)">-</button>
                            <input type="number" name="quantity" id="qtyInput" value="1" min="1" max="10" class="qty-input" readonly>
                            <button type="button" class="qty-btn" onclick="changeQty(1)">+</button>
                        </div>
                    </div>

                    <button type="submit" class="btn-add-cart">&#128722; Add to Cart</button>
                </form>
            </div>
        </div>

        <!-- RELATED PRODUCTS -->
        <% if (relatedProducts != null && !relatedProducts.isEmpty()) { %>
            <div class="related-section">
                <h2>You May Also Like</h2>
                <div class="products-grid">
                    <%
                        int count = 0;
                        for (Product rp : relatedProducts) {
                            if (rp.getProductId() != product.getProductId() && count < 4) {
                                count++;
                    %>
                        <a href="<%= request.getContextPath() %>/product-details?id=<%= rp.getProductId() %>" class="product-card">
                            <div class="card-img-box">
                                <img src="<%= request.getContextPath() %>/<%= rp.getImageUrl() %>" alt="<%= rp.getProductName() %>">
                            </div>
                            <div class="card-body">
                                <div class="card-title"><%= rp.getProductName() %></div>
                                <div class="card-price">&#8377;<%= String.format("%.2f", rp.getDiscountedPrice()) %></div>
                            </div>
                        </a>
                    <%
                            }
                        }
                    %>
                </div>
            </div>
        <% } %>
    </div>

    <jsp:include page="/includes/footer.jsp" />

    <script>
        function selectSize(size, btn) {
            document.querySelectorAll('.size-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            document.getElementById('selectedSizeInput').value = size;
        }

        function changeQty(delta) {
            const input = document.getElementById('qtyInput');
            let val = parseInt(input.value) || 1;
            val = Math.max(1, Math.min(10, val + delta));
            input.value = val;
        }
    </script>
</body>
</html>