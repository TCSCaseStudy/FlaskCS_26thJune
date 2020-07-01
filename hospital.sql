-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 01, 2020 at 05:23 PM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hospital`
--

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `dbill` float(10,2) NOT NULL,
  `mbill` float(10,2) NOT NULL,
  `rbill` float(10,2) NOT NULL,
  `pid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

<<<<<<< Updated upstream
--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;
UNLOCK TABLES;
=======
-- --------------------------------------------------------
>>>>>>> Stashed changes

--
-- Table structure for table `diag_master`
--

DROP TABLE IF EXISTS `diag_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diag_master` (
  `ws_test_id` int NOT NULL,
  `ws_test_name` varchar(100) DEFAULT NULL,
  `ws_test_chrg` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`ws_test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diag_master`
--

LOCK TABLES `diag_master` WRITE;
/*!40000 ALTER TABLE `diag_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `diag_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diagnostics`
--

CREATE TABLE `diagnostics` (
  `ws_test_no` int(11) NOT NULL,
  `ws_pat_id` int(11) NOT NULL,
  `ws_test_id` int(11) NOT NULL,
  `ws_diagn` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `medicines`
--

CREATE TABLE `medicines` (
  `record_id` int(11) NOT NULL,
  `ws_pat_id` int(11) NOT NULL,
  `ws_med_name` varchar(80) NOT NULL,
  `ws_qty` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `medicines`
--

INSERT INTO `medicines` (`record_id`, `ws_pat_id`, `ws_med_name`, `ws_qty`) VALUES
(16, 298292042, 'Imodium', 17),
(17, 298292042, 'Zantac', 5),
(18, 359511053, 'Pepcid AC', 20),
(19, 904048841, 'Pepcid AC', 20),
(20, 904048841, 'Paracetamol', 78);

-- --------------------------------------------------------

--
-- Table structure for table `meds_master`
--

CREATE TABLE `meds_master` (
  `ws_med_id` int(11) NOT NULL,
  `ws_med_name` varchar(80) DEFAULT NULL,
  `ws_rate` float(10,2) DEFAULT NULL,
  `ws_med_qty` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `meds_master`
--

INSERT INTO `meds_master` (`ws_med_id`, `ws_med_name`, `ws_rate`, `ws_med_qty`) VALUES
(11123, 'Cetirizine', 21.00, 1000),
(12345, 'Paracetamol', 18.00, 922),
(23412, 'Aspirin', 17.00, 1000),
(34598, 'Imodium', 13.00, 983),
(56432, 'Naprosyn', 90.00, 1000),
(56743, 'Pepcid AC', 23.00, 960),
(67890, 'Calpol', 20.00, 1000),
(76543, 'Zantac', 9.00, 995),
(89765, 'Motrin', 200.00, 1000),
(98765, 'Saridon', 13.00, 1000);

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `ws_ssn` int(11) NOT NULL,
  `ws_pat_id` int(11) NOT NULL,
  `ws_adrs` varchar(200) DEFAULT NULL,
  `ws_age` int(11) DEFAULT NULL,
  `ws_doj` date DEFAULT NULL,
  `ws_discharge` date DEFAULT NULL,
  `ws_rtype` varchar(15) DEFAULT NULL,
  `ws_status` varchar(10) DEFAULT NULL,
  `ws_pat_name` varchar(50) DEFAULT NULL,
  `ws_pat_city` varchar(20) DEFAULT NULL,
  `ws_pat_state` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patient`
--

<<<<<<< Updated upstream
LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (123456789,593187719,'Colaba',21,'2020-06-02',NULL,'Single Room','Active','Sam','Mumbai','MH');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;
=======
INSERT INTO `patient` (`ws_ssn`, `ws_pat_id`, `ws_adrs`, `ws_age`, `ws_doj`, `ws_discharge`, `ws_rtype`, `ws_status`, `ws_pat_name`, `ws_pat_city`, `ws_pat_state`) VALUES
(215665572, 298292042, 'Park Street, Kolkata', 33, '2020-06-17', NULL, 'Single Room', 'Active', 'William Joseph', 'Kolkata', 'West Bengal'),
(242167665, 527858963, '3020  Marigold Lane', 70, '2020-06-22', NULL, 'Single Room', 'Active', 'Steve N Hyatt', 'Ft Lauderdale', 'Florida'),
(357626773, 842373821, 'Guindy, Chennai', 45, '2020-06-15', NULL, 'Single Room', 'Active', 'Divya P', 'Chennai', 'Tamil Nadu'),
(364278677, 904048841, '6, Chandni Chowk', 32, '2020-06-11', NULL, 'General Ward', 'Active', 'Abhimanyu Roy', 'Delhi', 'Delhi'),
(567098222, 441980939, 'Dheeraj Sneh', 31, '2020-06-04', NULL, 'Semi Sharing', 'Active', 'Mihir Deol', 'Maharashtra', 'Mumbai'),
(567577545, 359511053, 'Kundanahalli, Bangalore', 45, '2020-05-20', NULL, 'Semi Sharing', 'Active', 'Prachi Dubey', 'Bangalore', 'Karnataka'),
(576565898, 817542925, '4902,Dancing Dove Lane', 19, '2020-05-21', NULL, 'Semi Sharing', 'Active', 'Carlos J Williams', 'Garden City', 'New York'),
(686686886, 943872066, '5, MG Road', 67, '2020-06-11', NULL, 'Semi Sharing', 'Active', 'Seema Jha', 'Gandhi Nagar', 'Gujarat'),
(987453212, 106381351, 'Lalpur, Ranchi', 35, '2020-06-24', NULL, 'General Ward', 'Active', 'Rajat Sharma', 'Ranchi', 'Jharkhand');

-- --------------------------------------------------------
>>>>>>> Stashed changes

--
-- Table structure for table `tests`
--

CREATE TABLE `tests` (
<<<<<<< Updated upstream
  `ws_test_id` int NOT NULL,
  `ws_test_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ws_test_chrg` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`ws_test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
=======
  `ws_test_id` int(11) NOT NULL,
  `ws_test_name` varchar(100) DEFAULT NULL,
  `ws_test_chrg` float(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
>>>>>>> Stashed changes

--
-- Dumping data for table `tests`
--

INSERT INTO `tests` (`ws_test_id`, `ws_test_name`, `ws_test_chrg`) VALUES
(34765, 'Endoscopy', 800.00),
(45632, 'Radiology', 1000.00),
(63703, 'Calcium', 350.00),
(67087, 'Lumbar Puncture', 800.00),
(67841, 'Pathology', 600.00),
(76543, 'X-Ray', 100.00),
(80088, 'Liver Function Test', 3000.00),
(89075, 'Genetic Testing', 2000.00),
(98723, 'Blood Test', 200.00),
(438904, 'Ultrasound', 300.00);

-- --------------------------------------------------------

--
-- Table structure for table `userstore`
--

CREATE TABLE `userstore` (
  `id` varchar(100) NOT NULL,
  `pass` varchar(300) NOT NULL,
  `ts` timestamp NULL DEFAULT NULL,
  `type` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `userstore`
--

<<<<<<< Updated upstream
LOCK TABLES `userstore` WRITE;
/*!40000 ALTER TABLE `userstore` DISABLE KEYS */;
INSERT INTO `userstore` VALUES ('d','202cb962ac59075b964b07152d234b70','2020-07-01 04:36:41','d'),('p','202cb962ac59075b964b07152d234b70','2020-07-01 04:36:04','p'),('r','202cb962ac59075b964b07152d234b70','2020-07-01 11:16:31','r');
/*!40000 ALTER TABLE `userstore` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
=======
INSERT INTO `userstore` (`id`, `pass`, `ts`, `type`) VALUES
('d', '202cb962ac59075b964b07152d234b70', '2020-07-01 15:21:32', 'd'),
('p', '202cb962ac59075b964b07152d234b70', '2020-07-01 14:57:45', 'p'),
('r', '202cb962ac59075b964b07152d234b70', '2020-07-01 14:13:15', 'r');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `diagnostics`
--
ALTER TABLE `diagnostics`
  ADD PRIMARY KEY (`ws_test_no`),
  ADD UNIQUE KEY `ws_test_no_UNIQUE` (`ws_test_no`);

--
-- Indexes for table `medicines`
--
ALTER TABLE `medicines`
  ADD PRIMARY KEY (`record_id`);

--
-- Indexes for table `meds_master`
--
ALTER TABLE `meds_master`
  ADD PRIMARY KEY (`ws_med_id`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`ws_ssn`,`ws_pat_id`);

--
-- Indexes for table `tests`
--
ALTER TABLE `tests`
  ADD PRIMARY KEY (`ws_test_id`);

--
-- Indexes for table `userstore`
--
ALTER TABLE `userstore`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `diagnostics`
--
ALTER TABLE `diagnostics`
  MODIFY `ws_test_no` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `medicines`
--
ALTER TABLE `medicines`
  MODIFY `record_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
COMMIT;
>>>>>>> Stashed changes

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
<<<<<<< Updated upstream
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-01 17:13:24
=======
>>>>>>> Stashed changes
