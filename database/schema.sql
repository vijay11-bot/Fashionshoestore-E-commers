-- =======================================================
-- Sole Mate Fashion Shoe Store Database Schema & Seed Data
-- =======================================================

CREATE DATABASE IF NOT EXISTS fashionshoestore;
USE fashionshoestore;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS wishlist;
DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS products;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. PRODUCTS TABLE
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description VARCHAR(500),
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    category VARCHAR(50) NOT NULL,
    type VARCHAR(50) NOT NULL,
    image VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. USERS TABLE
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. CART TABLE
CREATE TABLE cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    CONSTRAINT fk_cart_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_cart_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. WISHLIST TABLE
CREATE TABLE wishlist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    CONSTRAINT fk_wishlist_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_wishlist_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. ORDERS TABLE
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'Confirmed',
    payment_method VARCHAR(50) NOT NULL DEFAULT 'Credit Card',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. ORDER_ITEMS TABLE
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =======================================================
-- SEED DATA: Exactly 30 Products
-- (10 Men, 10 Women, 10 Kids / Sports, Formal, Casual)
-- =======================================================

INSERT INTO products (name, description, price, quantity, category, type, image) VALUES
-- --- MEN'S SHOES (10) ---
-- Sports (4)
('Men Air Runner Pro', 'High-performance lightweight running shoes with responsive cushioning.', 2999.00, 40, 'Men', 'Sports', 'images/shoe5.jpg'),
('Men Trail Blaster Sprint', 'Breathable mesh athletic training shoes with enhanced arch support.', 2499.00, 35, 'Men', 'Sports', 'images/shoe2.jpg'),
('Men Velocity Court Shoes', 'Durable multi-court sports sneakers with shock absorption technology.', 3199.00, 25, 'Men', 'Sports', 'images/shoe5.jpg'),
('Men Aero Boost Trainer', 'Ultra-cushioned gym and cross-training shoes for intense workouts.', 2799.00, 30, 'Men', 'Sports', 'images/shoe2.jpg'),
-- Formal (3)
('Men Classic Oxford Derby', 'Handcrafted genuine leather formal dress shoes for business attire.', 3499.00, 20, 'Men', 'Formal', 'images/shoe6.jpg'),
('Men Royal Brogue Leather', 'Elegant wingtip brogue formal shoes with premium leather sole.', 3999.00, 15, 'Men', 'Formal', 'images/shoe6.jpg'),
('Men Venetian Leather Loafers', 'Sleek slip-on formal dress shoes in rich burnished brown leather.', 3299.00, 22, 'Men', 'Formal', 'images/shoe6.jpg'),
-- Casual (3)
('Men Urban Canvas Low-Top', 'Everyday relaxed streetwear canvas sneakers with soft cushioned insole.', 1799.00, 50, 'Men', 'Casual', 'images/shoe7.jpg'),
('Men Streetstyle Suede Slip-on', 'Comfortable casual suede loafers ideal for weekend outings.', 2199.00, 30, 'Men', 'Casual', 'images/shoe7.jpg'),
('Men Vintage High-Top Sneaker', 'Timeless retro high-top leather sneakers with padded ankle support.', 2599.00, 28, 'Men', 'Casual', 'images/shoe2.jpg'),

-- --- WOMEN'S SHOES (10) ---
-- Sports (4)
('Women Cloud Flow Runner', 'Lightweight athletic running shoes engineered for marathon comfort.', 2899.00, 35, 'Women', 'Sports', 'images/shoe3.jpg'),
('Women Flex Motion Trainer', 'Flexible knit gym training shoes with responsive memory foam footbed.', 2399.00, 40, 'Women', 'Sports', 'images/shoe5.jpg'),
('Women Aero Pace Racer', 'Streamlined running sneakers with high-traction non-slip rubber outsole.', 2699.00, 30, 'Women', 'Sports', 'images/shoe3.jpg'),
('Women Active Pulse Sneakers', 'Shock-absorbing sports shoes perfect for cardio, HIIT, and jogging.', 2499.00, 25, 'Women', 'Sports', 'images/shoe5.jpg'),
-- Formal (3)
('Women Stiletto Luxe Pumps', 'Elegant pointed-toe formal heels in classic midnight black finish.', 3299.00, 20, 'Women', 'Formal', 'images/shoe6.jpg'),
('Women Grace Block Heel Loafers', 'Sophisticated office formal loafers adorned with stylish metal buckle.', 2999.00, 22, 'Women', 'Formal', 'images/shoe6.jpg'),
('Women Chic Velvet Stride', 'Sleek evening dress pumps with extra-cushioned insole for all-day comfort.', 3499.00, 18, 'Women', 'Formal', 'images/shoe6.jpg'),
-- Casual (3)
('Women Pastel Canvas Sneakers', 'Trendy everyday casual sneakers with soft pastel hues and durable soles.', 1899.00, 45, 'Women', 'Casual', 'images/shoe3.jpg'),
('Women Breeze Comfort Mules', 'Slip-on casual flat mules crafted from breathable vegan leather.', 1999.00, 32, 'Women', 'Casual', 'images/shoe7.jpg'),
('Women Urban Platform Kicks', 'Modern casual platform sneakers with elevated chunky sole.', 2299.00, 28, 'Women', 'Casual', 'images/shoe3.jpg'),

-- --- KIDS' SHOES (10) ---
-- Sports (4)
('Kids Turbo Sprint Sneakers', 'Durable sports sneakers with easy velcro straps for active playground fun.', 1599.00, 50, 'Kids', 'Sports', 'images/shoe4.jpg'),
('Kids Speed Racer Trainer', 'Lightweight cushioned running shoes for school sports and games.', 1499.00, 40, 'Kids', 'Sports', 'images/shoe8.jpg'),
('Kids Bounce Pro Athletic', 'Shock-proof flexible sports sneakers designed for young athletes.', 1699.00, 35, 'Kids', 'Sports', 'images/shoe4.jpg'),
('Kids Lightning Grip Runners', 'Anti-slip rubber sole sports trainers with breathable mesh upper.', 1549.00, 38, 'Kids', 'Sports', 'images/shoe8.jpg'),
-- Formal (3)
('Kids Classic School Uniform Shoes', 'Polished black formal leather shoes with secure buckle strap.', 1399.00, 45, 'Kids', 'Formal', 'images/shoe6.jpg'),
('Kids Royal Party Oxfords', 'Charming formal patent dress shoes for special occasions and weddings.', 1799.00, 25, 'Kids', 'Formal', 'images/shoe6.jpg'),
('Kids Elegant Mary Jane Flats', 'Traditional formal flats with padded collar and durable non-scuff sole.', 1499.00, 30, 'Kids', 'Formal', 'images/shoe6.jpg'),
-- Casual (3)
('Kids Dino Fun Slip-on', 'Colorful playful casual slip-on sneakers with elastic snug fit.', 1199.00, 55, 'Kids', 'Casual', 'images/shoe4.jpg'),
('Kids Star Canvas Low-Tops', 'Flexible lightweight casual canvas shoes for everyday school wear.', 1299.00, 40, 'Kids', 'Casual', 'images/shoe8.jpg'),
('Kids Urban Street Skate', 'Sturdy casual skate shoes with reinforced toe cap and vulcanized sole.', 1649.00, 35, 'Kids', 'Casual', 'images/shoe4.jpg');

-- Seed a demo user (password: 123456)
INSERT INTO users (name, email, password, phone, address) VALUES
('Vijay Kumar', 'vijay@example.com', '123456', '+91 9876543210', '123 Fashion Avenue, Bengaluru, Karnataka 560001');
