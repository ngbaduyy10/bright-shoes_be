CREATE DATABASE  IF NOT EXISTS "shoes_e-commerce" /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `shoes_e-commerce`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: mysql-95c5310-ngbaduyy05-015d.e.aivencloud.com    Database: shoes_e-commerce
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '632bbddc-25e3-11f0-8bb2-862ccfb001c7:1-172,
c754a445-0349-11f0-837d-7e68a0f27176:1-100767';

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `street` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `ward` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `district` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `city` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `country` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `customer` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (4,'user_2uS4gYOcj8sowabwy66XFCng8Jh','258 Ly Thuong Kiet','14','10','HCM','Vietnam','0827872272'),(5,'user_2v9PyMPGVSfBJF93qjNeR0Vnu6M','235','1','5','Ha Noi','VN','1234567'),(6,'user_2vmy8ysqy5LL80rr0F9k8Fx9D62','Ly Thuong Kiet','4','10','HCM','VN','123456789'),(7,'user_2vmy8ysqy5LL80rr0F9k8Fx9D62','123 ABC','1','1','HCM','ADAC','1235');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role` enum('super_admin','manager','staff') COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('user_PTXWyJXRmQqdoGtxn6X4ZzFFePU','manager','$2b$12$uRvAyKo7XLeFvb9SIMbz4OPxxeiCYe90k.2Zfu1MTyyUkkT2NAi9a'),('user_yU9IHOcGMl56WtsHBQPVo5emI6K','super_admin','$2b$12$.Q1pLROO7aGs9M6dBJmq.eiQVreAfn7TNxplB.je9419lTXUQz7E.');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `customer` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `cart_chk_1` CHECK ((`total_price` >= 0.00))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (2,'user_2uS4gYOcj8sowabwy66XFCng8Jh',120.00),(3,'user_2v9PyMPGVSfBJF93qjNeR0Vnu6M',0.00),(11,'user_2vmy8ysqy5LL80rr0F9k8Fx9D62',0.00);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_item`
--

DROP TABLE IF EXISTS `cart_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_item` (
  `cart_id` bigint unsigned NOT NULL,
  `shoes_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`cart_id`,`shoes_id`),
  KEY `shoes_id` (`shoes_id`),
  CONSTRAINT `cart_item_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_item_ibfk_2` FOREIGN KEY (`shoes_id`) REFERENCES `shoes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_item_chk_1` CHECK ((`quantity` >= 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_item`
--

LOCK TABLES `cart_item` WRITE;
/*!40000 ALTER TABLE `cart_item` DISABLE KEYS */;
INSERT INTO `cart_item` VALUES (2,2,1);
/*!40000 ALTER TABLE `cart_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'active',
  `image_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Men',NULL,'active',NULL),(2,'Women',NULL,'active',NULL),(3,'Kids',NULL,'active',NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `user_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `membership` enum('standard','gold','premium') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'standard',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('user_2uS4gYOcj8sowabwy66XFCng8Jh','standard'),('user_2v9PyMPGVSfBJF93qjNeR0Vnu6M','standard'),('user_2vmy8ysqy5LL80rr0F9k8Fx9D62','standard');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount`
--

DROP TABLE IF EXISTS `discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `discount_type` enum('percent','fixed') NOT NULL,
  `percentage_value` decimal(5,2) DEFAULT NULL,
  `amount_value` decimal(10,2) DEFAULT NULL,
  `min_order_value` decimal(10,2) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `total_quantity` int DEFAULT NULL,
  `used_quantity` int DEFAULT '0',
  `limit_per_user` int DEFAULT NULL,
  `status` enum('active','expired','disabled') DEFAULT 'active',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount`
--

LOCK TABLES `discount` WRITE;
/*!40000 ALTER TABLE `discount` DISABLE KEYS */;
INSERT INTO `discount` VALUES (1,'SALE10','10% Off','Get 10% off on all orders','percent',10.00,NULL,20.00,'2025-04-24 04:38:30','2025-05-04 04:38:30',100,0,1,'active','2025-04-24 04:38:30','2025-04-24 04:38:30'),(2,'FIX10USD','$10 Off','Save $10 on orders over $500','fixed',NULL,10.00,500.00,'2025-04-24 04:38:30','2025-05-09 04:38:30',50,0,1,'active','2025-04-24 04:38:30','2025-04-26 03:56:41'),(3,'SUMMER15','Summer Sale 15%','Enjoy 15% off during our summer promotion','percent',15.00,NULL,400.00,'2025-04-24 04:38:30','2025-05-14 04:38:30',200,0,1,'active','2025-04-24 04:38:30','2025-04-24 08:20:31'),(4,'HOTDEAL10USD','$10 Hot Deal','Save $10 on orders over $100','fixed',NULL,10.00,100.00,'2025-04-24 04:38:30','2025-05-01 04:38:30',70,0,2,'active','2025-04-24 04:38:30','2025-04-24 08:20:32'),(5,'WEEKEND20','Weekend 20% Off','Valid only on Saturday and Sunday','percent',20.00,NULL,250.00,'2025-04-24 04:38:30','2025-04-26 04:38:30',80,0,1,'active','2025-04-24 04:38:30','2025-04-24 08:20:32'),(6,'FLASH30','Flash Sale 30% Off','Valid for 24 hours only','percent',30.00,NULL,500.00,'2025-04-24 04:38:30','2025-04-25 04:38:30',30,0,1,'active','2025-04-24 04:38:30','2025-04-26 03:56:41'),(7,'NEWUSER10USD','$10 for New Users','One-time use only for new customers','fixed',NULL,10.00,0.00,'2025-04-24 04:38:30','2025-05-24 04:38:30',1000,0,1,'active','2025-04-24 04:38:30','2025-04-24 04:38:30'),(8,'VIP20','VIP 20% Off','Exclusive for VIP members','percent',20.00,NULL,600.00,'2025-04-24 04:38:30','2025-06-23 04:38:30',300,0,5,'active','2025-04-24 04:38:30','2025-04-26 03:56:41'),(9,'BACK2SCHOOL','Back to School - $7 Off','Special discount for students','fixed',NULL,7.00,100.00,'2025-04-24 04:38:30','2025-05-08 04:38:30',120,0,2,'active','2025-04-24 04:38:30','2025-04-24 08:20:32'),(10,'SUPER50','Super 50% Off','Massive discount, no limits!','percent',50.00,NULL,0.00,'2025-04-24 04:38:30','2025-04-27 04:38:30',20,0,1,'active','2025-04-24 04:38:30','2025-04-24 04:38:30');
/*!40000 ALTER TABLE `discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature`
--

DROP TABLE IF EXISTS `feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feature` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `shoes_id` bigint unsigned NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `image_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `start_date` date NOT NULL,
  `click_count` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `shoes_id` (`shoes_id`),
  CONSTRAINT `feature_ibfk_1` FOREIGN KEY (`shoes_id`) REFERENCES `shoes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `feature_chk_1` CHECK ((`click_count` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature`
--

LOCK TABLES `feature` WRITE;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` VALUES (1,15,NULL,NULL,'https://authentic-shoes.com/wp-content/uploads/2024/12/Giay-Nau.webp','2025-03-23',0),(2,16,NULL,NULL,'https://authentic-shoes.com/wp-content/uploads/2024/01/AJ1_Yellow_Ochre_Release_DayPrim.webp','2025-03-23',0),(3,17,NULL,NULL,'https://authentic-shoes.com/wp-content/uploads/2024/10/20240926111113-0.webp','2025-03-23',0);
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('pending','processing','shipped','delivered','cancelled') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `total_bill` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `street` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `ward` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `district` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `city` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `country` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `discount_bill` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `customer` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `order_chk_1` CHECK ((`total_bill` >= 0.00))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (4,'user_2uS4gYOcj8sowabwy66XFCng8Jh','shipped',140.00,'cod','258 Ly Thuong Kiet','14','10','HCM','0827872272','Vietnam','2025-03-23 11:36:26','2025-04-25 03:08:03',NULL),(5,'user_2v9PyMPGVSfBJF93qjNeR0Vnu6M','delivered',190.00,'cod','235','1','5','Ha Noi','1234567','VN','2025-04-02 00:45:29','2025-04-25 03:08:10',NULL),(6,'user_2uS4gYOcj8sowabwy66XFCng8Jh','delivered',190.00,'cod','258 Ly Thuong Kiet','14','10','HCM','0827872272','Vietnam','2025-04-02 00:48:30','2025-04-25 03:08:24',NULL),(7,'user_2uS4gYOcj8sowabwy66XFCng8Jh','pending',120.00,'cod','258 Ly Thuong Kiet','14','10','HCM','0827872272','Vietnam','2025-04-02 01:04:32','2025-04-02 01:04:32',NULL),(8,'user_2uS4gYOcj8sowabwy66XFCng8Jh','pending',360.00,'cod','258 Ly Thuong Kiet','14','10','HCM','0827872272','Vietnam','2025-04-02 01:37:40','2025-04-02 01:37:40',NULL),(9,'user_2vmy8ysqy5LL80rr0F9k8Fx9D62','processing',170.00,'cod','Ly Thuong Kiet','4','10','HCM','123456789','VN','2025-04-16 00:48:14','2025-04-25 03:08:32',NULL),(10,'user_2vmy8ysqy5LL80rr0F9k8Fx9D62','delivered',350.00,'cod','123 ABC','1','1','HCM','1235','ADAC','2025-04-21 03:48:31','2025-04-25 11:03:39',NULL),(11,'user_2uS4gYOcj8sowabwy66XFCng8Jh','pending',425.00,'cod','258 Ly Thuong Kiet','14','10','HCM','0827872272','Vietnam','2025-04-24 08:25:42','2025-04-24 08:36:27',418.00),(12,'user_2vmy8ysqy5LL80rr0F9k8Fx9D62','pending',250.00,'cod','123 ABC','1','1','HCM','1235','ADAC','2025-04-25 08:46:32','2025-04-25 08:46:32',NULL),(13,'user_2uS4gYOcj8sowabwy66XFCng8Jh','pending',405.00,'cod','258 Ly Thuong Kiet','14','10','HCM','0827872272','Vietnam','2025-04-27 12:34:44','2025-04-27 12:34:44',395.00),(14,'user_2uS4gYOcj8sowabwy66XFCng8Jh','pending',210.00,'cod','258 Ly Thuong Kiet','14','10','HCM','0827872272','Vietnam','2025-04-27 12:48:35','2025-04-27 12:48:35',NULL);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `order_id` bigint unsigned NOT NULL,
  `shoes_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_id`,`shoes_id`),
  KEY `shoes_id` (`shoes_id`),
  CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`shoes_id`) REFERENCES `shoes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_item_chk_1` CHECK ((`quantity` >= 1)),
  CONSTRAINT `order_item_chk_2` CHECK ((`price` >= 0.00))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (4,9,1,140.00),(5,1,1,190.00),(6,1,1,190.00),(7,2,1,120.00),(8,1,1,190.00),(8,4,1,170.00),(9,4,1,170.00),(10,1,1,190.00),(10,7,1,160.00),(11,22,1,195.00),(11,23,1,230.00),(12,13,1,250.00),(13,21,1,210.00),(13,22,1,195.00),(14,21,1,210.00);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `shoes_id` bigint unsigned NOT NULL,
  `rating` int NOT NULL,
  `comment` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `shoes_id` (`shoes_id`),
  KEY `rating_idx` (`rating`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `customer` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`shoes_id`) REFERENCES `shoes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `review_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,'user_2uS4gYOcj8sowabwy66XFCng8Jh',2,4,'Great','2025-03-27 08:50:06'),(2,'user_2uS4gYOcj8sowabwy66XFCng8Jh',2,5,'Love it','2025-03-27 08:50:55'),(3,'user_2v9PyMPGVSfBJF93qjNeR0Vnu6M',2,5,'Great product','2025-04-02 00:44:01'),(4,'user_2uS4gYOcj8sowabwy66XFCng8Jh',2,3,'Great','2025-04-02 01:40:46'),(5,'user_2v9PyMPGVSfBJF93qjNeR0Vnu6M',3,4,'Good one','2025-04-02 01:47:55'),(6,'user_2uS4gYOcj8sowabwy66XFCng8Jh',22,5,'Great','2025-04-27 09:53:22'),(7,'user_2uS4gYOcj8sowabwy66XFCng8Jh',4,4,'Great','2025-04-27 09:56:02');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`avnadmin`@`%`*/ /*!50003 TRIGGER `update_shoe_rating_after_insert` AFTER INSERT ON `review` FOR EACH ROW BEGIN
  UPDATE shoes
  SET rating = (
    SELECT AVG(rating)
    FROM review
    WHERE shoes_id = NEW.shoes_id
  )
  WHERE id = NEW.shoes_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `shoes`
--

DROP TABLE IF EXISTS `shoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shoes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `quantity` int NOT NULL DEFAULT '100',
  `image_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sold_quantity` int NOT NULL DEFAULT '0',
  `price` decimal(10,2) NOT NULL,
  `category_id` bigint unsigned NOT NULL,
  `size` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rating` float DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `idx_price` (`price`),
  FULLTEXT KEY `idx_name_description` (`name`,`description`),
  CONSTRAINT `shoes_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `shoes_chk_1` CHECK ((`quantity` >= 0)),
  CONSTRAINT `shoes_chk_2` CHECK ((`sold_quantity` >= 0)),
  CONSTRAINT `shoes_chk_3` CHECK ((`price` >= 0.00)),
  CONSTRAINT `shoes_chk_4` CHECK (((`rating` >= 0) and (`rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shoes`
--

LOCK TABLES `shoes` WRITE;
/*!40000 ALTER TABLE `shoes` DISABLE KEYS */;
INSERT INTO `shoes` VALUES (1,'Air Jordan 3 Retro','The Air Jordan 3 Retro offers a blend of vintage style and modern performance. Featuring iconic elephant print detailing and a visible air unit, it\'s a must-have for sneaker enthusiasts and collectors alike.',50,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/66841fce-c51c-4ebd-8474-c11f8f117488/AIR+JORDAN+3+RETRO.png',0,190.00,1,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-22 09:14:38',0),(2,'Nike LD-1000','Designed for comfort and versatility, the Nike LD-1000 is perfect for everyday wear. With its sleek silhouette and lightweight cushioning, it pairs effortlessly with any outfit, making it your go-to sneaker.',75,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/0e26ef63-81c4-4ab2-8fb5-a4306745394e/W+LD-1000.png',0,120.00,1,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-26 01:44:16',4.25),(3,'Nike Dunk Low Retro','Embrace retro style with the Nike Dunk Low Retro. Featuring classic color blocking and a padded collar, these sneakers deliver both old-school aesthetics and all-day comfort for fashion-forward wearers.',60,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/3f8c5b05-6d0f-49f4-b472-7425357e6a52/NIKE+DUNK+LOW+RETRO.png',0,110.00,1,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-26 01:44:16',4),(4,'Nike Air Force 1 \'07','The Nike Air Force 1 \'07 combines timeless charm with modern appeal. Crafted with premium leather and signature AF1 details, these sneakers are durable and stylish, ideal for both casual and formal settings.',100,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/a42a5d53-2f99-4e78-a081-9d07a2d0774a/AIR+FORCE+1+%2707.png',0,170.00,1,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-27 09:56:02',4),(5,'Air Jordan 1 Mid','Step up your game with the Air Jordan 1 Mid. This iconic model offers a perfect blend of heritage and innovation, celebrating MJ\'s legacy. Its versatile design makes it a staple for any sneaker collection.',80,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/0dde9946-f6fd-4a13-a149-1c2f11ca0b11/AIR+JORDAN+1+MID.png',0,150.00,1,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-22 09:14:38',0),(6,'Nike Air Max 97','The Nike Air Max 97 brings a sleek, wavy design inspired by water ripples, combined with full-length Max Air cushioning for unmatched comfort and style.',90,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/b42c2a68-ab7b-41ed-aae0-cee4f6c2dd30/W+AIR+MAX+97+FUTURA.png',0,175.00,1,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-22 09:14:38',0),(7,'Nike React Infinity Run Flyknit 3','Built for stability and energy return, the Nike React Infinity Run Flyknit 3 offers a flexible upper and React foam cushioning for a smooth running experience.',100,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/056c3a04-b6bb-4523-b274-f2683e9d40f2/W+NIKE+REACTX+INFINITY+RUN+4+W.png',0,160.00,1,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-22 09:14:38',0),(8,'Nike Air Max Plus','The Nike Air Max Plus brings a futuristic design with Tuned Air technology, offering excellent support and cushioning for a bold streetwear look.',75,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/f4de6339-e829-49be-bd15-45fe9a037349/NIKE+AIR+MAX+PLUS.png',0,180.00,1,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-22 09:14:38',0),(9,'Nike Dunk High Retro','Step into vintage basketball heritage with the Nike Dunk High Retro. Featuring premium leather and a high-top silhouette, it’s perfect for both casual wear and sports.',85,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/5fd41b9a-fdad-4773-9070-91c1b31348b4/NIKE+DUNK+HI+RETRO+SE.png',0,140.00,1,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-22 09:14:38',0),(10,'Nike Air Force 1 Low Retro','The Nike Air Force 1 Low Retro revives the classic AF1 design with premium materials and iconic details, delivering timeless style and durability.',110,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/dab259aa-dbc3-4c18-85e8-38dababbed92/NIKE+DUNK+LOW+RETRO.png',0,150.00,1,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-22 09:14:38',0),(11,'Nike Free Run 5.0','Designed for a barefoot feel, the Nike Free Run 5.0 features a flexible sole and breathable mesh upper, making it ideal for natural movement and everyday wear.',130,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/388d1fa1-5921-4181-9bf2-f37defd99521/NIKE+FREE+RN+FK+NEXT+NATURE.png',0,120.00,1,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-22 09:14:38',0),(12,'Nike Air Huarache','The Nike Air Huarache combines neoprene-like comfort with a supportive cage design, creating a snug fit and stylish appeal for any outfit.',95,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/086dca19-6504-4c7d-b3b9-ef4998ab6cd3/AIR+HUARACHE+NBY.png',0,135.00,1,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-22 09:14:38',0),(13,'Nike ZoomX Vaporfly','Built for speed, the Nike ZoomX Vaporfly Next% 2 features responsive ZoomX foam and a carbon fiber plate, making it a top choice for competitive runners.',50,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/eb6cdeee-ef8c-4a7e-bd77-5dbc5843f6d4/ZOOMX+VAPORFLY+NEXT%25+3+FK+EK.png',0,250.00,1,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-22 09:14:38',0),(14,'Nike SB Dunk Low','A staple in skateboarding culture, the Nike SB Dunk Low delivers durable suede, responsive cushioning, and a grippy sole for superior board control.',80,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/9b3886c2-6425-4511-adcf-b09f1ebf4891/NIKE+SB+ALLEYOOP.png',0,145.00,1,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-22 09:14:38',0),(15,'Nike SB Zoom Pogo','The Nike SB Zoom Pogo is a durable skate shoe featuring a suede/leather upper, Zoom Air cushioning for impact protection, and a vulcanized rubber sole for excellent grip and board feel.',50,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/e0fb0fe0-94ab-4713-a648-004182c7d49b/NIKE+SB+ZOOM+POGO+PLUS.png',0,190.00,1,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-22 09:14:38',0),(16,'Air Jordan 1 High Method','The Air Jordan 1 High Method combines premium materials with a timeless high-top silhouette, offering a blend of streetwear appeal and classic Jordan heritage.',65,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/5b9a5321-c1e8-4af8-9c92-8a2ee4269c68/WMNS+AIR+JORDAN+1+MM+HIGH.png',0,175.00,1,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-22 09:14:38',0),(17,'Jordan 1 Travis Scott','A collaboration masterpiece, the Jordan 1 Travis Scott features a unique reversed Swoosh, premium materials, and bold design choices for a truly iconic sneaker.',40,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/8741f306-7579-4432-af9d-21e81743b36b/AIR+JORDAN+1+LOW+SE.png',0,250.00,1,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-22 09:14:38',0),(18,'Air Jordan 4 Retro','The Air Jordan 4 Retro blends iconic style with modern comfort. Featuring breathable mesh panels, visible Air cushioning, and a durable leather upper, it’s perfect for both streetwear and performance.',70,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/0036257a-4b47-427e-a9e8-acdd5238573b/WMNS+AIR+JORDAN+4+RM.png',0,200.00,2,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-22 09:14:38',0),(19,'Air Jordan 1 Low','The Air Jordan 1 Low delivers classic Jordan heritage in a sleek, low-top design. With premium leather and a cushioned sole, it’s a versatile addition to any sneaker collection, ideal for everyday wear.',85,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/a43a0292-b616-4d5c-9ee6-9a2bcc118db1/WMNS+AIR+JORDAN+1+LOW.png',0,130.00,2,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-22 09:14:38',0),(20,'Air Jordan 11 Retro','The Air Jordan 11 Retro combines elegance and performance with its patent leather mudguard and lightweight carbon fiber plate. Perfect for collectors and athletes, it offers style and responsive cushioning.',60,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/4baea9a6-2d6c-4c65-afaf-0ac18611b53f/WMNS+AIR+JORDAN+1+MID.png',0,220.00,2,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-22 09:14:38',0),(21,'Air Jordan 5 Retro','The Air Jordan 5 Retro combines bold 90s style with modern performance. Featuring a reflective tongue, translucent sole, and fighter jet-inspired design, it’s a standout choice for sneaker enthusiasts.',65,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/a4b38cec-d59f-436f-8ee2-1b38a76ceba8/JORDAN+ONE+TAKE+5+PF.png',0,210.00,2,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-22 09:14:38',0),(22,'Air Jordan 3 Retro WMNS','Designed for women, the Air Jordan 3 Retro WMNS offers a sleek silhouette with premium leather and iconic elephant print. Its visible Air unit ensures comfort, making it ideal for both casual and statement looks.',80,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/b66577fa-955e-4c53-a82b-3b3f8b7892dc/AIR+JORDAN+MULE.png',0,195.00,2,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-27 09:53:22',5),(23,'Air Jordan 12 Retro','The Air Jordan 12 Retro delivers elegance and durability with its premium leather upper and lizard-textured overlays. Built for performance and style, it’s a timeless addition to any Jordan collection.',55,'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/657506cc-fdc2-41f9-9886-43b0f6b56bab/WMNS+JORDAN+DEJA+SANDAL.png',0,230.00,2,'[\"6\", \"6.5\", \"7\", \"7.5\", \"8\", \"8.5\", \"9\", \"9.5\", \"10\", \"10.5\", \"11\"]','2025-04-22 09:14:38','2025-04-23 09:13:38',0),(24,'Nike Zoom Vomero 5','This is a Shoes',80,'http://res.cloudinary.com/doxm7rnpk/image/upload/v1745401195/xrqjkc6fsog9jww02y7k.avif',0,200.00,2,'[\"6\",\"6.5\",\"7\",\"7.5\",\"8\",\"8.5\",\"9\",\"9.5\",\"10\",\"10.5\",\"11\"]','2025-04-23 09:39:56','2025-04-23 09:39:56',0);
/*!40000 ALTER TABLE `shoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gender` enum('male','female','other') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `registration_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('user_2uS4gYOcj8sowabwy66XFCng8Jh','Duy','Nguyen','ngbaduyy05@gmail.com','https://img.clerk.com/eyJ0eXBlIjoicHJveHkiLCJzcmMiOiJodHRwczovL2ltYWdlcy5jbGVyay5kZXYvb2F1dGhfZ29vZ2xlL2ltZ18ydVM0Z1V5N203aDBMVDRVNDdUOHBTTmp0NnYifQ',NULL,'2025-03-20 13:37:26'),('user_2v9PyMPGVSfBJF93qjNeR0Vnu6M','TÚ','NGUYỄN ANH','tu.nguyendevwork@hcmut.edu.vn','https://img.clerk.com/eyJ0eXBlIjoicHJveHkiLCJzcmMiOiJodHRwczovL2ltYWdlcy5jbGVyay5kZXYvb2F1dGhfZ29vZ2xlL2ltZ18ydjlQeU5SMkV2TTV4ekVRVXNEd3B0S1M0bE8ifQ',NULL,'2025-04-02 00:42:50'),('user_2vmy8ysqy5LL80rr0F9k8Fx9D62','Tú','Nguyễn','atunguye25@gmail.com','https://img.clerk.com/eyJ0eXBlIjoicHJveHkiLCJzcmMiOiJodHRwczovL2ltYWdlcy5jbGVyay5kZXYvb2F1dGhfZ29vZ2xlL2ltZ18ydm15OTNYYmp1VmlWQUhuRDRmekJEcUhIeUIifQ',NULL,'2025-04-16 00:46:30'),('user_PTXWyJXRmQqdoGtxn6X4ZzFFePU','Ba','Duy','ngbaduyy05@gmail.com','http://res.cloudinary.com/doxm7rnpk/image/upload/v1745647527/bright-shoes/tud9awffjqdxvefpmopz.png','female','2025-04-26 06:05:28'),('user_yU9IHOcGMl56WtsHBQPVo5emI6K','Duy','Nguyen','ngbaduyy10@gmail.com',NULL,'male','2025-04-15 12:32:09');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `user_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `shoes_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`shoes_id`),
  KEY `shoes_id` (`shoes_id`),
  CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `customer` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`shoes_id`) REFERENCES `shoes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
INSERT INTO `wishlist` VALUES ('user_2uS4gYOcj8sowabwy66XFCng8Jh',13,'2025-05-01 08:13:36'),('user_2uS4gYOcj8sowabwy66XFCng8Jh',17,'2025-04-26 04:00:58'),('user_2v9PyMPGVSfBJF93qjNeR0Vnu6M',1,'2025-04-02 00:43:11'),('user_2v9PyMPGVSfBJF93qjNeR0Vnu6M',2,'2025-04-02 00:43:29'),('user_2vmy8ysqy5LL80rr0F9k8Fx9D62',5,'2025-04-21 03:24:04'),('user_2vmy8ysqy5LL80rr0F9k8Fx9D62',7,'2025-04-21 02:02:22');
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'shoes_e-commerce'
--

--
-- Dumping routines for database 'shoes_e-commerce'
--
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-04 20:00:37
