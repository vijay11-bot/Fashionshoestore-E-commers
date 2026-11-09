-- ==============================================================================
-- Fashion Shoe Store - Complete Relational Database Schema & Expanded Seed Data
-- Aligned with Servlet MVC + JDBC Architecture
-- ==============================================================================

CREATE DATABASE IF NOT EXISTS fashionshoestore;
USE fashionshoestore;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS cart_items;
DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS product_sizes;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. USERS TABLE
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    gender VARCHAR(20),
    address VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. CATEGORIES TABLE
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. PRODUCTS TABLE
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    discount_percent DECIMAL(5,2) DEFAULT 0.00,
    image_url VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. PRODUCT_SIZES TABLE
CREATE TABLE product_sizes (
    product_size_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    size_label VARCHAR(20) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 10,
    sku_code VARCHAR(50),
    is_available BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_size_product FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. CART TABLE
CREATE TABLE cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_cart_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. CART_ITEMS TABLE
CREATE TABLE cart_items (
    cart_item_id INT AUTO_INCREMENT PRIMARY KEY,
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    size_label VARCHAR(20) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(10,2) NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cart_items_cart FOREIGN KEY (cart_id) REFERENCES cart(cart_id) ON DELETE CASCADE,
    CONSTRAINT fk_cart_items_product FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 7. ORDERS TABLE
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL DEFAULT 'Cash on Delivery',
    order_status VARCHAR(50) NOT NULL DEFAULT 'Confirmed',
    delivery_address VARCHAR(255) NOT NULL,
    CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 8. ORDER_ITEMS TABLE
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    size_label VARCHAR(20) NOT NULL,
    CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ==============================================================================
-- SEED DATA
-- ==============================================================================

-- 1. Insert Categories
INSERT INTO categories (category_id, category_name, description, is_active) VALUES
(1, 'Men', 'Footwear designed for men combining style, performance and comfort.', TRUE),
(2, 'Women', 'Elegant, athletic, and casual designer footwear for women.', TRUE),
(3, 'Kids', 'Durable, safe, and fun shoes engineered for growing kids.', TRUE);

-- 2. Insert Demo User (password: 123456)
INSERT INTO users (user_id, full_name, email, phone, password, gender, address) VALUES
(1, 'Vijay Kumar', 'vijay@example.com', '+91 9876543210', '123456', 'Male', '123 Fashion Avenue, MG Road, Bengaluru, Karnataka 560001');

-- 3. Insert Products (36 Shoe Products across Men, Women, Kids)
INSERT INTO products (product_id, category_id, product_name, description, price, discount_percent, image_url, is_active) VALUES
-- --- MEN'S SHOES (Category 1) ---
(1,  1, 'Men Air Runner Pro', 'High-performance athletic running shoes with responsive carbon cushioning and breathable mesh.', 3499.00, 15.00, 'images/shoe5.jpg', TRUE),
(2,  1, 'Men Trail Blaster Sprint', 'Rugged trail running trainers with deep-lug all-terrain traction rubber outsole.', 2899.00, 10.00, 'images/shoe2.jpg', TRUE),
(3,  1, 'Men Velocity Court Shoes', 'Multi-court indoor and outdoor sneakers engineered for lateral agility and arch support.', 3799.00, 20.00, 'images/shoe5.jpg', TRUE),
(4,  1, 'Men Aero Boost Trainer', 'Cushioned gym cross-training shoes designed for high-intensity workouts and cardio.', 3199.00, 12.00, 'images/shoe2.jpg', TRUE),
(5,  1, 'Men Classic Oxford Derby', 'Handcrafted genuine leather formal dress shoes for upscale business attire and dinners.', 4299.00, 10.00, 'images/shoe6.jpg', TRUE),
(6,  1, 'Men Royal Brogue Leather', 'Traditional wingtip medallion brogues featuring polished full-grain leather finish.', 4699.00, 15.00, 'images/shoe6.jpg', TRUE),
(7,  1, 'Men Venetian Leather Loafers', 'Slip-on dress loafers made with soft calfskin leather and cushioned insole.', 3899.00, 18.00, 'images/shoe6.jpg', TRUE),
(8,  1, 'Men Urban Canvas Low-Top', 'Timeless streetwear vulcanized canvas sneakers with supportive memory foam insoles.', 1999.00, 10.00, 'images/shoe7.jpg', TRUE),
(9,  1, 'Men Streetstyle Suede Slip-on', 'Premium suede casual shoes offering effortless styling for weekend getaways.', 2599.00, 15.00, 'images/shoe7.jpg', TRUE),
(10, 1, 'Men Vintage High-Top Sneaker', 'Retro 80s inspired leather high-top basketball sneakers with padded ankle collars.', 3299.00, 20.00, 'images/shoe2.jpg', TRUE),
(11, 1, 'Men Apex Storm Walker', 'Weather-resistant walking shoes with waterproof membrane and rugged shock damping.', 3699.00, 10.00, 'images/shoe9.jpg', TRUE),
(12, 1, 'Men Chelsea Suede Boot', 'Classic ankle Chelsea boots with stretch side panels and durable crepe outsole.', 4499.00, 15.00, 'images/shoe10.jpg', TRUE),

-- --- WOMEN'S SHOES (Category 2) ---
(13, 2, 'Women Cloud Flow Runner', 'Featherlight marathon running shoes with breathable dynamic mesh and energy return sole.', 3299.00, 15.00, 'images/shoe3.jpg', TRUE),
(14, 2, 'Women Flex Motion Trainer', 'Flexible knit gym studio training sneakers with responsive memory foam footbed.', 2799.00, 12.00, 'images/shoe5.jpg', TRUE),
(15, 2, 'Women Aero Pace Racer', 'Streamlined marathon racing kicks with high-traction non-slip rubber grip.', 3099.00, 10.00, 'images/shoe3.jpg', TRUE),
(16, 2, 'Women Active Pulse Sneakers', 'Ultra-soft shock absorbing fitness sneakers designed for cardio, aerobics, and walking.', 2899.00, 15.00, 'images/shoe5.jpg', TRUE),
(17, 2, 'Women Stiletto Luxe Pumps', 'Sophisticated pointed-toe formal high heels in timeless midnight black patent finish.', 3899.00, 15.00, 'images/shoe6.jpg', TRUE),
(18, 2, 'Women Grace Block Heel Loafers', 'Contemporary workwear formal block-heel loafers adorned with a metallic accent bar.', 3499.00, 10.00, 'images/shoe6.jpg', TRUE),
(19, 2, 'Women Chic Velvet Stride', 'Evening party pumps with plush velvet texture and cushioned footbed for night-long comfort.', 3999.00, 20.00, 'images/shoe6.jpg', TRUE),
(20, 2, 'Women Pastel Canvas Sneakers', 'Chic pastel-tinted casual canvas sneakers perfect for sunny brunches and casual strolls.', 2199.00, 10.00, 'images/shoe3.jpg', TRUE),
(21, 2, 'Women Breeze Comfort Mules', 'Minimalist slip-on flat mules crafted from supple breathable eco-friendly leather.', 2399.00, 15.00, 'images/shoe7.jpg', TRUE),
(22, 2, 'Women Urban Platform Kicks', 'Trendy platform sneakers with thick sculpted midsole for effortless height and comfort.', 2799.00, 18.00, 'images/shoe3.jpg', TRUE),
(23, 2, 'Women Rose Petal Slip-On', 'Ultra-lightweight walking slip-ons with flexible woven upper and slip-resistant sole.', 2499.00, 10.00, 'images/shoe11.jpg', TRUE),
(24, 2, 'Women Alpine Winter Boot', 'Plush faux-fur lined casual winter ankle boots with water-repellent suede finish.', 4199.00, 20.00, 'images/shoe10.jpg', TRUE),

-- --- KIDS' SHOES (Category 3) ---
(25, 3, 'Kids Turbo Sprint Sneakers', 'Sturdy playground sneakers with dual adjustable hook-and-loop velcro straps.', 1799.00, 10.00, 'images/shoe4.jpg', TRUE),
(26, 3, 'Kids Speed Racer Trainer', 'Lightweight cushioned athletic running shoes with breathable honeycomb mesh.', 1699.00, 10.00, 'images/shoe8.jpg', TRUE),
(27, 3, 'Kids Bounce Pro Athletic', 'Impact-absorbing flexible sports shoes for school athletics and active play.', 1899.00, 15.00, 'images/shoe4.jpg', TRUE),
(28, 3, 'Kids Lightning Grip Runners', 'Non-marking gum rubber sole sneakers with reflective safety heel patches.', 1749.00, 10.00, 'images/shoe8.jpg', TRUE),
(29, 3, 'Kids Classic School Uniform Shoes', 'Glossy black formal school shoes with secure buckle strap and non-scuff outsole.', 1599.00, 10.00, 'images/shoe6.jpg', TRUE),
(30, 3, 'Kids Royal Party Oxfords', 'Charming formal patent dress shoes for weddings, ceremonies, and festive occasions.', 1999.00, 12.00, 'images/shoe6.jpg', TRUE),
(31, 3, 'Kids Elegant Mary Jane Flats', 'Traditional girls formal party shoes with cushioned collar and round toe profile.', 1699.00, 15.00, 'images/shoe6.jpg', TRUE),
(32, 3, 'Kids Dino Fun Slip-on', 'Vibrant canvas slip-ons with playful dinosaur motif and snug elastic gussets.', 1399.00, 10.00, 'images/shoe4.jpg', TRUE),
(33, 3, 'Kids Star Canvas Low-Tops', 'Everyday classic canvas low-tops featuring durable rubber toe caps.', 1499.00, 10.00, 'images/shoe8.jpg', TRUE),
(34, 3, 'Kids Urban Street Skate', 'Reinforced suede skate sneakers designed to withstand tough playground abrasion.', 1849.00, 12.00, 'images/shoe4.jpg', TRUE),
(35, 3, 'Kids Light-Up Galaxy Kicks', 'Fun LED light-up athletic sneakers that illuminate with every running step.', 2099.00, 15.00, 'images/shoe8.jpg', TRUE),
(36, 3, 'Kids Cozy Warm Winter Boots', 'Water-resistant slip-on winter boots with thermal fleece lining and gripping treads.', 2299.00, 15.00, 'images/shoe10.jpg', TRUE);

-- 4. Insert Sizes for Every Product into PRODUCT_SIZES
-- Men's shoes: UK 7, UK 8, UK 9, UK 10, UK 11
INSERT INTO product_sizes (product_id, size_label, stock_quantity, sku_code, is_available)
SELECT p.product_id, s.size_label, 15, CONCAT('SKU-M-', p.product_id, '-', REPLACE(s.size_label, ' ', '')), TRUE
FROM products p
CROSS JOIN (
    SELECT 'UK 7' AS size_label UNION ALL
    SELECT 'UK 8' UNION ALL
    SELECT 'UK 9' UNION ALL
    SELECT 'UK 10' UNION ALL
    SELECT 'UK 11'
) s
WHERE p.category_id = 1;

-- Women's shoes: UK 4, UK 5, UK 6, UK 7, UK 8
INSERT INTO product_sizes (product_id, size_label, stock_quantity, sku_code, is_available)
SELECT p.product_id, s.size_label, 12, CONCAT('SKU-W-', p.product_id, '-', REPLACE(s.size_label, ' ', '')), TRUE
FROM products p
CROSS JOIN (
    SELECT 'UK 4' AS size_label UNION ALL
    SELECT 'UK 5' UNION ALL
    SELECT 'UK 6' UNION ALL
    SELECT 'UK 7' UNION ALL
    SELECT 'UK 8'
) s
WHERE p.category_id = 2;

-- Kids' shoes: UK 1, UK 2, UK 3, UK 4, UK 5
INSERT INTO product_sizes (product_id, size_label, stock_quantity, sku_code, is_available)
SELECT p.product_id, s.size_label, 18, CONCAT('SKU-K-', p.product_id, '-', REPLACE(s.size_label, ' ', '')), TRUE
FROM products p
CROSS JOIN (
    SELECT 'UK 1' AS size_label UNION ALL
    SELECT 'UK 2' UNION ALL
    SELECT 'UK 3' UNION ALL
    SELECT 'UK 4' UNION ALL
    SELECT 'UK 5'
) s
WHERE p.category_id = 3;
