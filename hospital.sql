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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `ws_pat_id` int NOT NULL,
  `ws_diagn` varchar(100) DEFAULT NULL,
  `ws_test_id` int NOT NULL,
  PRIMARY KEY (`ws_pat_id`,`ws_test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `ws_med_name` varchar(80) NOT NULL,
  `ws_qty` int DEFAULT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicines`
--

LOCK TABLES `medicines` WRITE;
/*!40000 ALTER TABLE `medicines` DISABLE KEYS */;
INSERT INTO `medicines` VALUES (1,1234,'Paracetamol',3),(3,1234,'Calpol',14),(4,1234,'Aspirin',13),(5,1234,'Paracetamol',13),(6,1234,'Aspirin',8),(7,1234,'Aspirin',2),(8,1234,'Calpol',14),(9,1234,'Calpol',13),(10,1234,'Paracetamol',12);
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
  `ws_med_name` varchar(80) DEFAULT NULL,
  `ws_rate` float(10,2) DEFAULT NULL,
  `ws_med_qty` int DEFAULT NULL,
  PRIMARY KEY (`ws_med_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meds_master`
--

LOCK TABLES `meds_master` WRITE;
/*!40000 ALTER TABLE `meds_master` DISABLE KEYS */;
INSERT INTO `meds_master` VALUES (12,'Paracetamol',12.00,18),(13,'Calpol',15.00,59),(14,'Aspirin',20.00,63);
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
  `ws_adrs` varchar(200) DEFAULT NULL,
  `ws_age` int DEFAULT NULL,
  `ws_doj` date DEFAULT NULL,
  `ws_discharge` date DEFAULT NULL,
  `ws_rtype` varchar(15) DEFAULT NULL,
  `ws_status` varchar(10) DEFAULT NULL,
  `ws_pat_name` varchar(50) DEFAULT NULL,
  `ws_pat_city` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ws_ssn`,`ws_pat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (1,1234,'wcewe',31,'2020-06-01','2020-06-17','single','vacant','eqfq','f33');
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
/*!40000 ALTER TABLE `tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userstore`
--

DROP TABLE IF EXISTS `userstore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userstore` (
  `id` varchar(100) NOT NULL,
  `pass` varchar(300) NOT NULL,
  `ts` timestamp NULL DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userstore`
--

LOCK TABLES `userstore` WRITE;
/*!40000 ALTER TABLE `userstore` DISABLE KEYS */;
INSERT INTO `userstore` VALUES ('d','202cb962ac59075b964b07152d234b70','2020-06-29 14:31:26','d'),('p','202cb962ac59075b964b07152d234b70','2020-06-29 14:33:13','p');
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

-- Dump completed on 2020-06-29 20:03:57
