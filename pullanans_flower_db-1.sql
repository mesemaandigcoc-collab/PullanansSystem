-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 03, 2026 at 10:26 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pullanans_flower_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `log_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `action` varchar(60) NOT NULL,
  `module` varchar(60) NOT NULL,
  `record_id` int(10) UNSIGNED DEFAULT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(10) UNSIGNED NOT NULL,
  `customer_type` enum('Customer','Reseller') NOT NULL DEFAULT 'Customer',
  `customer_name` varchar(120) NOT NULL,
  `contact_person` varchar(120) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(80) DEFAULT NULL,
  `province` varchar(80) DEFAULT NULL,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `event_id` int(10) UNSIGNED NOT NULL,
  `event_no` varchar(30) NOT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `package_id` int(10) UNSIGNED DEFAULT NULL,
  `event_name` varchar(150) NOT NULL,
  `event_type` enum('Wedding','Birthday','Corporate','Celebration','Other') NOT NULL DEFAULT 'Other',
  `venue` varchar(255) DEFAULT NULL,
  `event_date` date NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `status` enum('Inquiry','Confirmed','In Preparation','Completed','Cancelled') NOT NULL DEFAULT 'Inquiry',
  `estimated_cost` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `payment_status` enum('Unpaid','Partial','Paid') NOT NULL DEFAULT 'Unpaid',
  `notes` varchar(255) DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_packages`
--

CREATE TABLE `event_packages` (
  `package_id` int(10) UNSIGNED NOT NULL,
  `package_name` varchar(120) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `base_price` decimal(12,2) NOT NULL DEFAULT 0.00,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_requirements`
--

CREATE TABLE `event_requirements` (
  `requirement_id` int(10) UNSIGNED NOT NULL,
  `event_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `item_id` int(10) UNSIGNED DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` decimal(12,2) NOT NULL DEFAULT 1.00,
  `unit_price` decimal(12,2) NOT NULL DEFAULT 0.00,
  `subtotal` decimal(12,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_staff`
--

CREATE TABLE `event_staff` (
  `event_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `assignment_role` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_items`
--

CREATE TABLE `inventory_items` (
  `item_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `item_code` varchar(30) NOT NULL,
  `item_name` varchar(120) NOT NULL,
  `item_type` enum('Flower','Material','Packaging') NOT NULL DEFAULT 'Flower',
  `unit` varchar(20) NOT NULL DEFAULT 'pc',
  `quantity_on_hand` decimal(12,2) NOT NULL DEFAULT 0.00,
  `reorder_level` decimal(12,2) NOT NULL DEFAULT 0.00,
  `unit_cost` decimal(12,2) NOT NULL DEFAULT 0.00,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `item_categories`
--

CREATE TABLE `item_categories` (
  `category_id` int(10) UNSIGNED NOT NULL,
  `category_name` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `item_categories`
--

INSERT INTO `item_categories` (`category_id`, `category_name`) VALUES
(3, 'Carnations'),
(2, 'Chrysanthemums'),
(7, 'Floral Supplies'),
(6, 'Greenery / Fillers'),
(4, 'Lilies'),
(5, 'Orchids'),
(8, 'Packaging'),
(1, 'Roses');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `customer_id` int(10) UNSIGNED DEFAULT NULL,
  `type` enum('Low Stock','Order','Event','Shipment','Payment','System') NOT NULL DEFAULT 'System',
  `title` varchar(120) NOT NULL,
  `message` varchar(500) NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED DEFAULT NULL,
  `event_id` int(10) UNSIGNED DEFAULT NULL,
  `payment_date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `method` enum('Cash','GCash','Bank Transfer','Check','Other') NOT NULL DEFAULT 'Cash',
  `reference_no` varchar(60) DEFAULT NULL,
  `status` enum('Pending','Verified','Rejected') NOT NULL DEFAULT 'Pending',
  `verified_by` int(10) UNSIGNED DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `permission_key` varchar(60) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`permission_id`, `permission_key`, `description`) VALUES
(1, 'users.manage', 'Manage users and roles'),
(2, 'suppliers.manage', 'Manage suppliers'),
(3, 'purchases.manage', 'Manage purchases'),
(4, 'inventory.manage', 'Manage inventory and wastage'),
(5, 'processing.manage', 'Manage flower processing'),
(6, 'products.manage', 'Manage products and pricing'),
(7, 'customers.manage', 'Manage customers and resellers'),
(8, 'sales.manage', 'Manage sales orders'),
(9, 'payments.manage', 'Record and verify payments'),
(10, 'events.manage', 'Manage events and catering'),
(11, 'shipping.manage', 'Manage shipments and logistics'),
(12, 'tracking.update', 'Update shipment status'),
(13, 'analytics.view', 'View business analytics dashboard'),
(14, 'reports.view', 'View and generate reports'),
(15, 'logs.view', 'View activity logs');

-- --------------------------------------------------------

--
-- Table structure for table `processing_batches`
--

CREATE TABLE `processing_batches` (
  `batch_id` int(10) UNSIGNED NOT NULL,
  `batch_code` varchar(30) NOT NULL,
  `processing_date` date NOT NULL,
  `process_type` set('Cutting','Cleaning','Arranging','Packing') NOT NULL,
  `status` enum('In Progress','Completed','Cancelled') NOT NULL DEFAULT 'In Progress',
  `notes` varchar(255) DEFAULT NULL,
  `processed_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `processing_inputs`
--

CREATE TABLE `processing_inputs` (
  `input_id` int(10) UNSIGNED NOT NULL,
  `batch_id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `quantity_used` decimal(12,2) NOT NULL,
  `quantity_wasted` decimal(12,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `processing_outputs`
--

CREATE TABLE `processing_outputs` (
  `output_id` int(10) UNSIGNED NOT NULL,
  `batch_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity_produced` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `product_code` varchar(30) NOT NULL,
  `product_name` varchar(120) NOT NULL,
  `product_type` enum('Single Flower','Bundle','Bouquet','Arrangement','Other') NOT NULL DEFAULT 'Bundle',
  `description` varchar(255) DEFAULT NULL,
  `unit` varchar(20) NOT NULL DEFAULT 'pc',
  `cost_price` decimal(12,2) NOT NULL DEFAULT 0.00,
  `markup_percent` decimal(6,2) NOT NULL DEFAULT 0.00,
  `selling_price` decimal(12,2) NOT NULL DEFAULT 0.00,
  `quantity_available` decimal(12,2) NOT NULL DEFAULT 0.00,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_components`
--

CREATE TABLE `product_components` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `quantity` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `purchase_id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(30) NOT NULL,
  `supplier_id` int(10) UNSIGNED NOT NULL,
  `purchase_date` date NOT NULL,
  `date_received` date DEFAULT NULL,
  `total_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `payment_status` enum('Unpaid','Partial','Paid') NOT NULL DEFAULT 'Unpaid',
  `status` enum('Pending','Received','Cancelled') NOT NULL DEFAULT 'Pending',
  `notes` varchar(255) DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_items`
--

CREATE TABLE `purchase_items` (
  `purchase_item_id` int(10) UNSIGNED NOT NULL,
  `purchase_id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `quantity` decimal(12,2) NOT NULL,
  `unit_cost` decimal(12,2) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `description`) VALUES
(1, 'Business Owner', 'Full access, analytics and reports'),
(2, 'Administrator', 'Manages users, roles and system data'),
(3, 'Sales Staff', 'Customers, orders, prices and payments'),
(4, 'Inventory Staff', 'Suppliers, purchasing, inventory, processing and products'),
(5, 'Logistics Staff', 'Shipments and shipment tracking'),
(6, 'Event Staff', 'Event and catering requests');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`role_id`, `permission_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 15),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(2, 11),
(2, 12),
(2, 13),
(2, 14),
(2, 15),
(3, 7),
(3, 8),
(3, 9),
(3, 14),
(4, 2),
(4, 3),
(4, 4),
(4, 5),
(4, 6),
(4, 14),
(5, 11),
(5, 12),
(5, 14),
(6, 10),
(6, 14);

-- --------------------------------------------------------

--
-- Table structure for table `sales_orders`
--

CREATE TABLE `sales_orders` (
  `order_id` int(10) UNSIGNED NOT NULL,
  `order_no` varchar(30) NOT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `order_date` date NOT NULL,
  `required_date` date DEFAULT NULL,
  `order_status` enum('Pending','Confirmed','Processing','Ready','Shipped','Delivered','Cancelled') NOT NULL DEFAULT 'Pending',
  `subtotal` decimal(12,2) NOT NULL DEFAULT 0.00,
  `discount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `payment_status` enum('Unpaid','Partial','Paid') NOT NULL DEFAULT 'Unpaid',
  `notes` varchar(255) DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales_order_items`
--

CREATE TABLE `sales_order_items` (
  `order_item_id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` decimal(12,2) NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shipments`
--

CREATE TABLE `shipments` (
  `shipment_id` int(10) UNSIGNED NOT NULL,
  `tracking_no` varchar(40) NOT NULL,
  `order_id` int(10) UNSIGNED DEFAULT NULL,
  `event_id` int(10) UNSIGNED DEFAULT NULL,
  `provider_id` int(10) UNSIGNED DEFAULT NULL,
  `transport_type` enum('Bus','Vessel','Airplane') NOT NULL,
  `trip_reference` varchar(60) DEFAULT NULL,
  `origin` varchar(150) NOT NULL,
  `destination` varchar(150) NOT NULL,
  `consignee_name` varchar(120) DEFAULT NULL,
  `consignee_contact` varchar(30) DEFAULT NULL,
  `departure_datetime` datetime DEFAULT NULL,
  `estimated_arrival` datetime DEFAULT NULL,
  `actual_arrival` datetime DEFAULT NULL,
  `freight_cost` decimal(12,2) NOT NULL DEFAULT 0.00,
  `status` enum('Preparing','Ready for Pickup','In Transit','Arrived','Delivered','Delayed','Cancelled') NOT NULL DEFAULT 'Preparing',
  `remarks` varchar(255) DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shipment_packaging`
--

CREATE TABLE `shipment_packaging` (
  `shipment_id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `quantity` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shipment_tracking`
--

CREATE TABLE `shipment_tracking` (
  `tracking_id` int(10) UNSIGNED NOT NULL,
  `shipment_id` int(10) UNSIGNED NOT NULL,
  `status` varchar(40) NOT NULL,
  `location` varchar(150) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_movements`
--

CREATE TABLE `stock_movements` (
  `movement_id` bigint(20) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `movement_type` enum('Purchase','Processing','Sale','Event Use','Wastage','Adjustment','Return') NOT NULL,
  `quantity` decimal(12,2) NOT NULL,
  `reference_type` varchar(30) DEFAULT NULL,
  `reference_id` int(10) UNSIGNED DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `movement_date` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(10) UNSIGNED NOT NULL,
  `supplier_name` varchar(120) NOT NULL,
  `contact_person` varchar(120) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transport_providers`
--

CREATE TABLE `transport_providers` (
  `provider_id` int(10) UNSIGNED NOT NULL,
  `provider_name` varchar(120) NOT NULL,
  `transport_type` enum('Bus','Vessel','Airplane') NOT NULL,
  `contact_no` varchar(30) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `full_name` varchar(120) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `status` enum('Active','Inactive','Locked') NOT NULL DEFAULT 'Active',
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_active_shipments`
-- (See below for the actual view)
--
CREATE TABLE `v_active_shipments` (
`shipment_id` int(10) unsigned
,`tracking_no` varchar(40)
,`transport_type` enum('Bus','Vessel','Airplane')
,`trip_reference` varchar(60)
,`origin` varchar(150)
,`destination` varchar(150)
,`departure_datetime` datetime
,`estimated_arrival` datetime
,`status` enum('Preparing','Ready for Pickup','In Transit','Arrived','Delivered','Delayed','Cancelled')
,`order_no` varchar(30)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_low_stock_items`
-- (See below for the actual view)
--
CREATE TABLE `v_low_stock_items` (
`item_id` int(10) unsigned
,`item_code` varchar(30)
,`item_name` varchar(120)
,`item_type` enum('Flower','Material','Packaging')
,`unit` varchar(20)
,`quantity_on_hand` decimal(12,2)
,`reorder_level` decimal(12,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_order_balances`
-- (See below for the actual view)
--
CREATE TABLE `v_order_balances` (
`order_id` int(10) unsigned
,`order_no` varchar(30)
,`customer_name` varchar(120)
,`order_date` date
,`total_amount` decimal(12,2)
,`amount_paid` decimal(34,2)
,`balance` decimal(35,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `wastage_records`
--

CREATE TABLE `wastage_records` (
  `wastage_id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `quantity` decimal(12,2) NOT NULL,
  `reason` enum('Damaged','Spoiled','Wilted','Transport Damage','Other') NOT NULL DEFAULT 'Spoiled',
  `wastage_date` date NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `recorded_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure for view `v_active_shipments`
--
DROP TABLE IF EXISTS `v_active_shipments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_active_shipments`  AS SELECT `s`.`shipment_id` AS `shipment_id`, `s`.`tracking_no` AS `tracking_no`, `s`.`transport_type` AS `transport_type`, `s`.`trip_reference` AS `trip_reference`, `s`.`origin` AS `origin`, `s`.`destination` AS `destination`, `s`.`departure_datetime` AS `departure_datetime`, `s`.`estimated_arrival` AS `estimated_arrival`, `s`.`status` AS `status`, `o`.`order_no` AS `order_no` FROM (`shipments` `s` left join `sales_orders` `o` on(`o`.`order_id` = `s`.`order_id`)) WHERE `s`.`status` not in ('Delivered','Cancelled') ;

-- --------------------------------------------------------

--
-- Structure for view `v_low_stock_items`
--
DROP TABLE IF EXISTS `v_low_stock_items`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_low_stock_items`  AS SELECT `inventory_items`.`item_id` AS `item_id`, `inventory_items`.`item_code` AS `item_code`, `inventory_items`.`item_name` AS `item_name`, `inventory_items`.`item_type` AS `item_type`, `inventory_items`.`unit` AS `unit`, `inventory_items`.`quantity_on_hand` AS `quantity_on_hand`, `inventory_items`.`reorder_level` AS `reorder_level` FROM `inventory_items` WHERE `inventory_items`.`status` = 'Active' AND `inventory_items`.`quantity_on_hand` <= `inventory_items`.`reorder_level` ;

-- --------------------------------------------------------

--
-- Structure for view `v_order_balances`
--
DROP TABLE IF EXISTS `v_order_balances`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_order_balances`  AS SELECT `o`.`order_id` AS `order_id`, `o`.`order_no` AS `order_no`, `c`.`customer_name` AS `customer_name`, `o`.`order_date` AS `order_date`, `o`.`total_amount` AS `total_amount`, coalesce(sum(case when `p`.`status` = 'Verified' then `p`.`amount` end),0) AS `amount_paid`, `o`.`total_amount`- coalesce(sum(case when `p`.`status` = 'Verified' then `p`.`amount` end),0) AS `balance` FROM ((`sales_orders` `o` join `customers` `c` on(`c`.`customer_id` = `o`.`customer_id`)) left join `payments` `p` on(`p`.`order_id` = `o`.`order_id`)) WHERE `o`.`order_status` <> 'Cancelled' GROUP BY `o`.`order_id`, `o`.`order_no`, `c`.`customer_name`, `o`.`order_date`, `o`.`total_amount` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `idx_logs_user` (`user_id`),
  ADD KEY `idx_logs_created` (`created_at`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `idx_customers_name` (`customer_name`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`),
  ADD UNIQUE KEY `uq_events_no` (`event_no`),
  ADD KEY `idx_events_date` (`event_date`),
  ADD KEY `fk_events_customer` (`customer_id`),
  ADD KEY `fk_events_package` (`package_id`),
  ADD KEY `fk_events_user` (`created_by`);

--
-- Indexes for table `event_packages`
--
ALTER TABLE `event_packages`
  ADD PRIMARY KEY (`package_id`);

--
-- Indexes for table `event_requirements`
--
ALTER TABLE `event_requirements`
  ADD PRIMARY KEY (`requirement_id`),
  ADD KEY `fk_er_event` (`event_id`),
  ADD KEY `fk_er_product` (`product_id`),
  ADD KEY `fk_er_item` (`item_id`);

--
-- Indexes for table `event_staff`
--
ALTER TABLE `event_staff`
  ADD PRIMARY KEY (`event_id`,`user_id`),
  ADD KEY `fk_es_user` (`user_id`);

--
-- Indexes for table `inventory_items`
--
ALTER TABLE `inventory_items`
  ADD PRIMARY KEY (`item_id`),
  ADD UNIQUE KEY `uq_items_code` (`item_code`),
  ADD KEY `idx_items_name` (`item_name`),
  ADD KEY `fk_items_category` (`category_id`);

--
-- Indexes for table `item_categories`
--
ALTER TABLE `item_categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `uq_item_categories_name` (`category_name`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `idx_notif_user` (`user_id`,`is_read`),
  ADD KEY `fk_notif_customer` (`customer_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `idx_payments_date` (`payment_date`),
  ADD KEY `fk_pay_order` (`order_id`),
  ADD KEY `fk_pay_event` (`event_id`),
  ADD KEY `fk_pay_user` (`verified_by`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`permission_id`),
  ADD UNIQUE KEY `uq_permissions_key` (`permission_key`);

--
-- Indexes for table `processing_batches`
--
ALTER TABLE `processing_batches`
  ADD PRIMARY KEY (`batch_id`),
  ADD UNIQUE KEY `uq_batch_code` (`batch_code`),
  ADD KEY `fk_batch_user` (`processed_by`);

--
-- Indexes for table `processing_inputs`
--
ALTER TABLE `processing_inputs`
  ADD PRIMARY KEY (`input_id`),
  ADD KEY `fk_pin_batch` (`batch_id`),
  ADD KEY `fk_pin_item` (`item_id`);

--
-- Indexes for table `processing_outputs`
--
ALTER TABLE `processing_outputs`
  ADD PRIMARY KEY (`output_id`),
  ADD KEY `fk_pout_batch` (`batch_id`),
  ADD KEY `fk_pout_product` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD UNIQUE KEY `uq_products_code` (`product_code`),
  ADD KEY `idx_products_name` (`product_name`);

--
-- Indexes for table `product_components`
--
ALTER TABLE `product_components`
  ADD PRIMARY KEY (`product_id`,`item_id`),
  ADD KEY `fk_pc_item` (`item_id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`purchase_id`),
  ADD UNIQUE KEY `uq_purchases_ref` (`reference_no`),
  ADD KEY `idx_purchases_date` (`purchase_date`),
  ADD KEY `fk_purchases_supplier` (`supplier_id`),
  ADD KEY `fk_purchases_user` (`created_by`);

--
-- Indexes for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD PRIMARY KEY (`purchase_item_id`),
  ADD KEY `fk_pi_purchase` (`purchase_id`),
  ADD KEY `fk_pi_item` (`item_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `uq_roles_name` (`role_name`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `fk_rp_perm` (`permission_id`);

--
-- Indexes for table `sales_orders`
--
ALTER TABLE `sales_orders`
  ADD PRIMARY KEY (`order_id`),
  ADD UNIQUE KEY `uq_orders_no` (`order_no`),
  ADD KEY `idx_orders_date` (`order_date`),
  ADD KEY `idx_orders_status` (`order_status`),
  ADD KEY `fk_orders_customer` (`customer_id`),
  ADD KEY `fk_orders_user` (`created_by`);

--
-- Indexes for table `sales_order_items`
--
ALTER TABLE `sales_order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `fk_soi_order` (`order_id`),
  ADD KEY `fk_soi_product` (`product_id`);

--
-- Indexes for table `shipments`
--
ALTER TABLE `shipments`
  ADD PRIMARY KEY (`shipment_id`),
  ADD UNIQUE KEY `uq_shipments_tracking` (`tracking_no`),
  ADD KEY `idx_shipments_status` (`status`),
  ADD KEY `fk_ship_order` (`order_id`),
  ADD KEY `fk_ship_event` (`event_id`),
  ADD KEY `fk_ship_provider` (`provider_id`),
  ADD KEY `fk_ship_user` (`created_by`);

--
-- Indexes for table `shipment_packaging`
--
ALTER TABLE `shipment_packaging`
  ADD PRIMARY KEY (`shipment_id`,`item_id`),
  ADD KEY `fk_sp_item` (`item_id`);

--
-- Indexes for table `shipment_tracking`
--
ALTER TABLE `shipment_tracking`
  ADD PRIMARY KEY (`tracking_id`),
  ADD KEY `idx_st_shipment` (`shipment_id`),
  ADD KEY `fk_st_user` (`updated_by`);

--
-- Indexes for table `stock_movements`
--
ALTER TABLE `stock_movements`
  ADD PRIMARY KEY (`movement_id`),
  ADD KEY `idx_sm_item` (`item_id`),
  ADD KEY `idx_sm_date` (`movement_date`),
  ADD KEY `fk_sm_user` (`created_by`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`),
  ADD KEY `idx_suppliers_name` (`supplier_name`);

--
-- Indexes for table `transport_providers`
--
ALTER TABLE `transport_providers`
  ADD PRIMARY KEY (`provider_id`),
  ADD KEY `idx_tp_type` (`transport_type`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `uq_users_username` (`username`),
  ADD UNIQUE KEY `uq_users_email` (`email`),
  ADD KEY `fk_users_role` (`role_id`);

--
-- Indexes for table `wastage_records`
--
ALTER TABLE `wastage_records`
  ADD PRIMARY KEY (`wastage_id`),
  ADD KEY `idx_wastage_date` (`wastage_date`),
  ADD KEY `fk_wastage_item` (`item_id`),
  ADD KEY `fk_wastage_user` (`recorded_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `log_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `event_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event_packages`
--
ALTER TABLE `event_packages`
  MODIFY `package_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event_requirements`
--
ALTER TABLE `event_requirements`
  MODIFY `requirement_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory_items`
--
ALTER TABLE `inventory_items`
  MODIFY `item_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `item_categories`
--
ALTER TABLE `item_categories`
  MODIFY `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `permission_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `processing_batches`
--
ALTER TABLE `processing_batches`
  MODIFY `batch_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `processing_inputs`
--
ALTER TABLE `processing_inputs`
  MODIFY `input_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `processing_outputs`
--
ALTER TABLE `processing_outputs`
  MODIFY `output_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `purchase_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_items`
--
ALTER TABLE `purchase_items`
  MODIFY `purchase_item_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sales_orders`
--
ALTER TABLE `sales_orders`
  MODIFY `order_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales_order_items`
--
ALTER TABLE `sales_order_items`
  MODIFY `order_item_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shipments`
--
ALTER TABLE `shipments`
  MODIFY `shipment_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shipment_tracking`
--
ALTER TABLE `shipment_tracking`
  MODIFY `tracking_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_movements`
--
ALTER TABLE `stock_movements`
  MODIFY `movement_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transport_providers`
--
ALTER TABLE `transport_providers`
  MODIFY `provider_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wastage_records`
--
ALTER TABLE `wastage_records`
  MODIFY `wastage_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `fk_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `fk_events_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `fk_events_package` FOREIGN KEY (`package_id`) REFERENCES `event_packages` (`package_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_events_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `event_requirements`
--
ALTER TABLE `event_requirements`
  ADD CONSTRAINT `fk_er_event` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_er_item` FOREIGN KEY (`item_id`) REFERENCES `inventory_items` (`item_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_er_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE SET NULL;

--
-- Constraints for table `event_staff`
--
ALTER TABLE `event_staff`
  ADD CONSTRAINT `fk_es_event` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_es_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `inventory_items`
--
ALTER TABLE `inventory_items`
  ADD CONSTRAINT `fk_items_category` FOREIGN KEY (`category_id`) REFERENCES `item_categories` (`category_id`) ON DELETE SET NULL;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notif_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_notif_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_pay_event` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_pay_order` FOREIGN KEY (`order_id`) REFERENCES `sales_orders` (`order_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_pay_user` FOREIGN KEY (`verified_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `processing_batches`
--
ALTER TABLE `processing_batches`
  ADD CONSTRAINT `fk_batch_user` FOREIGN KEY (`processed_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `processing_inputs`
--
ALTER TABLE `processing_inputs`
  ADD CONSTRAINT `fk_pin_batch` FOREIGN KEY (`batch_id`) REFERENCES `processing_batches` (`batch_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pin_item` FOREIGN KEY (`item_id`) REFERENCES `inventory_items` (`item_id`);

--
-- Constraints for table `processing_outputs`
--
ALTER TABLE `processing_outputs`
  ADD CONSTRAINT `fk_pout_batch` FOREIGN KEY (`batch_id`) REFERENCES `processing_batches` (`batch_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pout_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `product_components`
--
ALTER TABLE `product_components`
  ADD CONSTRAINT `fk_pc_item` FOREIGN KEY (`item_id`) REFERENCES `inventory_items` (`item_id`),
  ADD CONSTRAINT `fk_pc_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `fk_purchases_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  ADD CONSTRAINT `fk_purchases_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD CONSTRAINT `fk_pi_item` FOREIGN KEY (`item_id`) REFERENCES `inventory_items` (`item_id`),
  ADD CONSTRAINT `fk_pi_purchase` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`purchase_id`) ON DELETE CASCADE;

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `fk_rp_perm` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`permission_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_rp_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE;

--
-- Constraints for table `sales_orders`
--
ALTER TABLE `sales_orders`
  ADD CONSTRAINT `fk_orders_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `fk_orders_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `sales_order_items`
--
ALTER TABLE `sales_order_items`
  ADD CONSTRAINT `fk_soi_order` FOREIGN KEY (`order_id`) REFERENCES `sales_orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_soi_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `shipments`
--
ALTER TABLE `shipments`
  ADD CONSTRAINT `fk_ship_event` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_ship_order` FOREIGN KEY (`order_id`) REFERENCES `sales_orders` (`order_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_ship_provider` FOREIGN KEY (`provider_id`) REFERENCES `transport_providers` (`provider_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_ship_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `shipment_packaging`
--
ALTER TABLE `shipment_packaging`
  ADD CONSTRAINT `fk_sp_item` FOREIGN KEY (`item_id`) REFERENCES `inventory_items` (`item_id`),
  ADD CONSTRAINT `fk_sp_shipment` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`shipment_id`) ON DELETE CASCADE;

--
-- Constraints for table `shipment_tracking`
--
ALTER TABLE `shipment_tracking`
  ADD CONSTRAINT `fk_st_shipment` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`shipment_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_st_user` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `stock_movements`
--
ALTER TABLE `stock_movements`
  ADD CONSTRAINT `fk_sm_item` FOREIGN KEY (`item_id`) REFERENCES `inventory_items` (`item_id`),
  ADD CONSTRAINT `fk_sm_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);

--
-- Constraints for table `wastage_records`
--
ALTER TABLE `wastage_records`
  ADD CONSTRAINT `fk_wastage_item` FOREIGN KEY (`item_id`) REFERENCES `inventory_items` (`item_id`),
  ADD CONSTRAINT `fk_wastage_user` FOREIGN KEY (`recorded_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
