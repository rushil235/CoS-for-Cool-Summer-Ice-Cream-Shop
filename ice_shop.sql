-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 16, 2024 at 02:00 AM
-- Server version: 5.7.24
-- PHP Version: 8.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ice_shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `contact` varchar(15) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `name`, `contact`, `created_at`) VALUES
(43, 'Peter', '9823126569', '2024-11-16 01:14:53'),
(44, 'Mark', '9823126569', '2024-11-16 01:48:24');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT '0.00',
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `amount_paid` decimal(10,2) DEFAULT '0.00',
  `payment_status` enum('pending','paid') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `total_price`, `order_date`, `amount_paid`, `payment_status`) VALUES
(31, 43, '5.95', '2024-11-16 01:14:53', '5.95', 'paid'),
(32, 44, '3.50', '2024-11-16 01:48:24', '0.00', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `order_detail_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_name` varchar(100) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `toppings` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`order_detail_id`, `order_id`, `product_name`, `quantity`, `price`, `toppings`) VALUES
(73, 31, 'Vanilla Cone', 2, '7.00', 'Fresh strawberries, Crushed Oreos'),
(74, 32, 'Vanilla Cone', 1, '3.00', 'Fresh strawberries, Crushed Oreos');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(10) NOT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_category` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `product_category`, `price`, `image_path`) VALUES
(1, 'Vanilla Cone', 'cones', 2.5, '../images/pistachio_cone.jpeg'),
(2, 'Butterscotch', 'cones', 3, '../images/butterscotch_cone.jpeg'),
(5, 'Berry Blast Cone', 'cones', 3, '../images/straberry_cone.jpeg'),
(6, 'Tropical Paradise', 'cones', 4, '../images/tuttifutty_cone.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `product_toppings`
--

CREATE TABLE `product_toppings` (
  `product_id` int(10) NOT NULL,
  `topping_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_toppings`
--

INSERT INTO `product_toppings` (`product_id`, `topping_id`) VALUES
(1, 1),
(2, 1),
(5, 1),
(6, 1),
(1, 2),
(2, 2),
(5, 2),
(6, 2),
(1, 3),
(2, 3),
(5, 3),
(6, 3);

-- --------------------------------------------------------

--
-- Table structure for table `promotion_codes`
--

CREATE TABLE `promotion_codes` (
  `promo_code_id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `discount_percentage` decimal(5,2) NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `promotion_codes`
--

INSERT INTO `promotion_codes` (`promo_code_id`, `code`, `discount_percentage`, `is_active`, `created_at`) VALUES
(1, 'DISCOUNT10', '15.00', 1, '2024-11-14 23:21:31'),
(2, 'SUMMER15', '15.00', 1, '2024-11-14 23:21:31'),
(3, 'BLACKFRIDAY20', '20.00', 1, '2024-11-14 23:21:31'),
(4, 'HELLOWORLD', '5.00', 1, '2024-11-16 01:49:15');

-- --------------------------------------------------------

--
-- Table structure for table `toppings`
--

CREATE TABLE `toppings` (
  `topping_id` int(10) NOT NULL,
  `topping_name` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `toppings`
--

INSERT INTO `toppings` (`topping_id`, `topping_name`, `price`) VALUES
(1, 'Crushed Oreos', 0.5),
(2, 'Choco Chips', 0.5),
(3, 'Fresh strawberries', 0.5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`order_detail_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `product_toppings`
--
ALTER TABLE `product_toppings`
  ADD PRIMARY KEY (`product_id`,`topping_id`),
  ADD KEY `topping_id` (`topping_id`);

--
-- Indexes for table `promotion_codes`
--
ALTER TABLE `promotion_codes`
  ADD PRIMARY KEY (`promo_code_id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `toppings`
--
ALTER TABLE `toppings`
  ADD PRIMARY KEY (`topping_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `order_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `promotion_codes`
--
ALTER TABLE `promotion_codes`
  MODIFY `promo_code_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `toppings`
--
ALTER TABLE `toppings`
  MODIFY `topping_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE SET NULL;

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE;

--
-- Constraints for table `product_toppings`
--
ALTER TABLE `product_toppings`
  ADD CONSTRAINT `product_toppings_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `product_toppings_ibfk_2` FOREIGN KEY (`topping_id`) REFERENCES `toppings` (`topping_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
