-- This SQL script creates a database schema for an e-commerce platform with tables for brands, product categories, products, product items, images, colors, sizes, attributes, and variations. It also includes sample data for each table.
-- E-commerce Database Schema
CREATE DATABASE commerce;
USE commerce;

CREATE TABLE brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    parent_category_id INT,
    FOREIGN KEY (parent_category_id) REFERENCES product_category(category_id) ON DELETE SET NULL
);

CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    brand_id INT,
    description TEXT,
    base_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id) ON DELETE SET NULL
);

CREATE TABLE product_item (
    product_item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    sku VARCHAR(50) NOT NULL UNIQUE,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
);

CREATE TABLE product_image (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_item_id INT,
    image_url VARCHAR(255) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (product_item_id) REFERENCES product_item(product_item_id) ON DELETE CASCADE
);

CREATE TABLE color (
    color_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    hex_code VARCHAR(7)
);

CREATE TABLE size_category (
    size_category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE size_option (
    size_option_id INT AUTO_INCREMENT PRIMARY KEY,
    size_category_id INT,
    value VARCHAR(50) NOT NULL,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id) ON DELETE CASCADE
);

CREATE TABLE product_variation (
    variation_id INT AUTO_INCREMENT PRIMARY KEY,
    product_item_id INT,
    color_id INT,
    size_option_id INT,
    FOREIGN KEY (product_item_id) REFERENCES product_item(product_item_id) ON DELETE CASCADE,
    FOREIGN KEY (color_id) REFERENCES color(color_id) ON DELETE SET NULL,
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id) ON DELETE SET NULL
);

CREATE TABLE attribute_category (
    attribute_category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE attribute_type (
    attribute_type_id INT AUTO_INCREMENT PRIMARY KEY,
    attribute_category_id INT,
    name VARCHAR(100) NOT NULL,
    data_type ENUM('text', 'number', 'boolean') NOT NULL,
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id) ON DELETE CASCADE
);

CREATE TABLE product_attribute (
    attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    attribute_type_id INT,
    value VARCHAR(250) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE,
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id) ON DELETE CASCADE
);

-- Insert Sample Data

-- Insert Brands
INSERT INTO brand (name, description) VALUES
('Nike', 'Leading sportswear and footwear brand'),
('Adidas', 'Global sportswear and lifestyle brand'),
('Apple', 'Innovative technology and electronics'),
('Samsung', 'Advanced electronics and appliances');

-- Insert Product Categories
INSERT INTO product_category (name, parent_category_id) VALUES
('Clothing', NULL),
('Electronics', NULL),
('Footwear', NULL),
('Men’s Clothing', 1);

-- Insert Colors
INSERT INTO color (name, hex_code) VALUES
('Black', '#000000'),
('Blue', '#0000FF'),
('Red', '#FF0000'),
('White', '#FFFFFF');

-- Insert Size Categories and Options
INSERT INTO size_category (name) VALUES
('Clothing Sizes'),
('Shoe Sizes');

INSERT INTO size_option (size_category_id, value) VALUES
(1, 'S'),
(1, 'M'),
(1, 'L'),
(2, '9'),
(2, '10');

-- Insert Attribute Categories and Types
INSERT INTO attribute_category (name) VALUES
('Physical'),
('Technical');

INSERT INTO attribute_type (attribute_category_id, name, data_type) VALUES
(1, 'Material', 'text'),
(2, 'Waterproof', 'boolean'),
(2, 'Weight', 'number');

-- Insert Products
INSERT INTO product (name, brand_id, description, base_price) VALUES
('T-Shirt', 1, 'Comfortable cotton t-shirt', 29.99),
('Jacket', 2, 'Warm fleece jacket', 79.99),
('Smartphone', 3, 'Latest iPhone model', 999.99),
('Laptop', 4, 'High-performance laptop', 1299.99),
('Headphones', 3, 'Wireless noise-canceling headphones', 249.99),
('Sneakers', 1, 'Stylish running sneakers', 89.99),
('Running Shoes', 2, 'Lightweight running shoes', 99.99),
('Polo Shirt', 1, 'Classic polo shirt for men', 39.99),
('Hoodie', 2, 'Cozy hoodie for men', 59.99),
('Jeans', 2, 'Slim-fit men’s jeans', 49.99);

-- Insert Product Items
INSERT INTO product_item (product_id, sku, price, stock_quantity) VALUES
(1, 'TSHIRT-NIKE-BLK-M', 29.99, 100),
(2, 'JACKET-ADIDAS-BLU-L', 79.99, 50),
(3, 'IPHONE-APPLE-BLK', 999.99, 20),
(4, 'LAPTOP-SAMSUNG-WHT', 1299.99, 15),
(5, 'HEADPHONE-APPLE-BLK', 249.99, 30),
(6, 'SNEAKER-NIKE-RED-9', 89.99, 40),
(7, 'RUNSHOE-ADIDAS-WHT-10', 99.99, 35),
(8, 'POLO-NIKE-BLK-M', 39.99, 60),
(9, 'HOODIE-ADIDAS-BLU-L', 59.99, 45),
(10, 'JEANS-ADIDAS-BLK-32', 49.99, 70);

-- Insert Product Images
INSERT INTO product_image (product_item_id, image_url, is_primary) VALUES
(1, 'http://example.com/tshirt-nike-blk.jpg', TRUE),
(2, 'http://example.com/jacket-adidas-blu.jpg', TRUE),
(3, 'http://example.com/iphone-apple-blk.jpg', TRUE),
(4, 'http://example.com/laptop-samsung-wht.jpg', TRUE),
(5, 'http://example.com/headphone-apple-blk.jpg', TRUE),
(6, 'http://example.com/sneaker-nike-red.jpg', TRUE),
(7, 'http://example.com/runshoe-adidas-wht.jpg', TRUE),
(8, 'http://example.com/polo-nike-blk.jpg', TRUE),
(9, 'http://example.com/hoodie-adidas-blu.jpg', TRUE),
(10, 'http://example.com/jeans-adidas-blk.jpg', TRUE);

-- Insert Product Variations
INSERT INTO product_variation (product_item_id, color_id, size_option_id) VALUES
(1, 1, 2), -- T-Shirt: Black, M
(2, 2, 3), -- Jacket: Blue, L
(3, 1, NULL), -- Smartphone: Black, no size
(4, 4, NULL), -- Laptop: White, no size
(5, 1, NULL), -- Headphones: Black, no size
(6, 3, 4), -- Sneakers: Red, 9
(7, 4, 5), -- Running Shoes: White, 10
(8, 1, 2), -- Polo Shirt: Black, M
(9, 2, 3), -- Hoodie: Blue, L
(10, 1, NULL); -- Jeans: Black, no size (assuming size 32 is a custom attribute)

-- Insert Product Attributes
INSERT INTO product_attribute (product_id, attribute_type_id, value) VALUES
(1, 1, 'Cotton'), -- T-Shirt: Material
(2, 2, 'TRUE'), -- Jacket: Waterproof
(3, 3, '150'), -- Smartphone: Weight (grams)
(4, 3, '2000'), -- Laptop: Weight (grams)
(5, 2, 'FALSE'), -- Headphones: Waterproof
(6, 1, 'Leather'), -- Sneakers: Material
(7, 1, 'Mesh'), -- Running Shoes: Material
(8, 1, 'Cotton'), -- Polo Shirt: Material
(9, 1, 'Fleece'), -- Hoodie: Material
(10, 1, 'Denim'); -- Jeans: Material
