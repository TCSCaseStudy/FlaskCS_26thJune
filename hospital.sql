-- MySQL dump 10.13  Distrib 8.0.19, for osx10.15 (x86_64)
--
-- Host: localhost    Database: hospital
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bills` (
  `dbill` float(10,2) NOT NULL,
  `mbill` float(10,2) NOT NULL,
  `rbill` float(10,2) NOT NULL,
  `pid` int NOT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diagnostics`
--

DROP TABLE IF EXISTS `diagnostics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diagnostics` (
  `ws_test_no` int NOT NULL AUTO_INCREMENT,
  `ws_pat_id` int NOT NULL,
  `ws_test_id` int NOT NULL,
  `ws_diagn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`ws_test_no`),
  UNIQUE KEY `ws_test_no_UNIQUE` (`ws_test_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diagnostics`
--

LOCK TABLES `diagnostics` WRITE;
/*!40000 ALTER TABLE `diagnostics` DISABLE KEYS */;
/*!40000 ALTER TABLE `diagnostics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicines`
--

DROP TABLE IF EXISTS `medicines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicines` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `ws_pat_id` int NOT NULL,
  `ws_med_name` varchar(80) COLLATE utf8mb4_general_ci NOT NULL,
  `ws_qty` int DEFAULT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicines`
--

LOCK TABLES `medicines` WRITE;
/*!40000 ALTER TABLE `medicines` DISABLE KEYS */;
INSERT INTO `medicines` VALUES (1,298292042,'Imodium',17),(2,298292042,'Zantac',5),(3,359511053,'Pepcid AC',20),(4,904048841,'Paracetamol',78);
/*!40000 ALTER TABLE `medicines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meds_master`
--

DROP TABLE IF EXISTS `meds_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meds_master` (
  `ws_med_id` int NOT NULL,
  `ws_med_name` varchar(80) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ws_rate` float(10,2) DEFAULT NULL,
  `ws_med_qty` int DEFAULT NULL,
  PRIMARY KEY (`ws_med_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meds_master`
--

LOCK TABLES `meds_master` WRITE;
/*!40000 ALTER TABLE `meds_master` DISABLE KEYS */;
INSERT INTO `meds_master` VALUES (11123,'Cetirizine',21.00,1000),(12345,'Paracetamol',18.00,922),(23412,'Aspirin',17.00,1000),(34598,'Imodium',13.00,983),(56432,'Naprosyn',90.00,1000),(56743,'Pepcid AC',23.00,960),(67890,'Calpol',20.00,1000),(76543,'Zantac',9.00,995),(89765,'Motrin',200.00,1000),(98765,'Saridon',13.00,1000);
/*!40000 ALTER TABLE `meds_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `ws_ssn` int NOT NULL,
  `ws_pat_id` int NOT NULL,
  `ws_adrs` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ws_age` int DEFAULT NULL,
  `ws_doj` date DEFAULT NULL,
  `ws_discharge` date DEFAULT NULL,
  `ws_rtype` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ws_status` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ws_pat_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ws_pat_city` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ws_pat_state` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`ws_ssn`,`ws_pat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (215665572,298292042,'Park Street, Kolkata',33,'2020-06-17',NULL,'Single Room','Active','William Joseph','Kolkata','West Bengal'),(242167665,527858963,'3020  Marigold Lane',70,'2020-06-22',NULL,'Single Room','Active','Steve N Hyatt','Ft Lauderdale','Florida'),(357626773,842373821,'Guindy, Chennai',45,'2020-06-15',NULL,'Single Room','Active','Divya P','Chennai','Tamil Nadu'),(364278677,904048841,'6, Chandni Chowk',32,'2020-06-11',NULL,'General Ward','Active','Abhimanyu Roy','Delhi','Delhi'),(567098222,441980939,'Dheeraj Sneh',31,'2020-06-04',NULL,'Semi Sharing','Active','Mihir Deol','Maharashtra','Mumbai'),(567577545,359511053,'Kundanahalli, Bangalore',45,'2020-05-20',NULL,'Semi Sharing','Active','Prachi Dubey','Bangalore','Karnataka'),(576565898,817542925,'4902,Dancing Dove Lane',19,'2020-05-21',NULL,'Semi Sharing','Active','Carlos J Williams','Garden City','New York'),(686686886,943872066,'5, MG Road',67,'2020-06-11',NULL,'Semi Sharing','Active','Seema Jha','Gandhi Nagar','Gujarat'),(987453212,106381351,'Lalpur, Ranchi',35,'2020-06-24',NULL,'General Ward','Active','Rajat Sharma','Ranchi','Jharkhand');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tests`
--

DROP TABLE IF EXISTS `tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tests` (
  `ws_test_id` int NOT NULL,
  `ws_test_name` varchar(100) DEFAULT NULL,
  `ws_test_chrg` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`ws_test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests`
--

LOCK TABLES `tests` WRITE;
/*!40000 ALTER TABLE `tests` DISABLE KEYS */;
INSERT INTO `tests` VALUES (34765,'Endoscopy',800.00),(45632,'Radiology',1000.00),(63703,'Calcium',350.00),(67087,'Lumbar Puncture',800.00),(67841,'Pathology',600.00),(76543,'X-Ray',100.00),(80088,'Liver Function Test',3000.00),(89075,'Genetic Testing',2000.00),(98723,'Blood Test',200.00),(438904,'Ultrasound',300.00);
/*!40000 ALTER TABLE `tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userstore`
--

DROP TABLE IF EXISTS `userstore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userstore` (
  `id` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `pass` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `ts` timestamp NULL DEFAULT NULL,
  `type` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userstore`
--

LOCK TABLES `userstore` WRITE;
/*!40000 ALTER TABLE `userstore` DISABLE KEYS */;
INSERT INTO `userstore` VALUES ('diagnostics','2896e9aa160693d0dcfb2ead274211f0','2020-07-01 15:50:22','d'),('pharmacist','2896e9aa160693d0dcfb2ead274211f0','2020-07-01 15:50:06','p'),('receptionist','2896e9aa160693d0dcfb2ead274211f0','2020-07-01 15:49:44','r');
/*!40000 ALTER TABLE `userstore` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-01 21:21:25
