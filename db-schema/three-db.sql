-- MySQL dump 10.13  Distrib 8.0.25, for macos11 (x86_64)
--
-- Host: 192.168.0.19    Database: three
-- ------------------------------------------------------
-- Server version	8.0.29-0ubuntu0.20.04.3

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

--
-- Table structure for table `AccountDelete`
--

DROP TABLE IF EXISTS `AccountDelete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AccountDelete` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=200218 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AccountSet`
--

DROP TABLE IF EXISTS `AccountSet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AccountSet` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=329568 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CheckCancel`
--

DROP TABLE IF EXISTS `CheckCancel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CheckCancel` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CheckCash`
--

DROP TABLE IF EXISTS `CheckCash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CheckCash` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CheckCreate`
--

DROP TABLE IF EXISTS `CheckCreate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CheckCreate` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DEXTrades`
--

DROP TABLE IF EXISTS `DEXTrades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DEXTrades` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `hash` varchar(128) NOT NULL,
  `maker` varchar(128) DEFAULT NULL,
  `taker` varchar(128) DEFAULT NULL,
  `sequence` bigint DEFAULT NULL,
  `base_currency` varchar(45) DEFAULT NULL,
  `base_issuer` varchar(128) DEFAULT NULL,
  `quote_currency` varchar(45) DEFAULT NULL,
  `quote_issuer` varchar(128) DEFAULT NULL,
  `price` decimal(25,10) DEFAULT NULL,
  `volume` bigint DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `DEX_LOOKUP` (`maker`,`taker`,`base_currency`,`base_issuer`,`quote_currency`,`quote_issuer`,`created`,`volume`,`price`),
  KEY `TOKENS` (`maker`,`taker`,`base_currency`,`base_issuer`,`quote_currency`,`quote_issuer`,`created`),
  KEY `maker_idx` (`maker`),
  KEY `taker_idx` (`taker`),
  KEY `base_currency_idx` (`base_currency`),
  KEY `base_issuer_idx` (`base_issuer`),
  KEY `quote_currency_idx` (`quote_currency`),
  KEY `quote_issuer_idx` (`quote_issuer`),
  KEY `created_idx` (`created`),
  KEY `created_desc_idx` (`created` DESC)
) ENGINE=InnoDB AUTO_INCREMENT=13885712 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`stick`@`%`*/ /*!50003 TRIGGER `DEXTrades_ins` AFTER INSERT ON `DEXTrades` FOR EACH ROW BEGIN

  INSERT INTO DEXTrades_mvl
  VALUES (NULL, NEW.hash, NEW.maker, NEW.taker, NEW.sequence, NEW.base_currency, NEW.base_issuer, NEW.quote_currency, NEW.quote_issuer, NEW.price, NEW.volume, NEW.created, NEW.ledger, NOW());

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `DEXTrades_mv`
--

DROP TABLE IF EXISTS `DEXTrades_mv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DEXTrades_mv` (
  `base_currency` varchar(45) NOT NULL,
  `base_issuer` varchar(128) NOT NULL,
  `base_volume` decimal(40,10) DEFAULT NULL,
  `quote_issuer` varchar(128) NOT NULL,
  `quote_currency` varchar(45) NOT NULL,
  `quote_volume` decimal(40,10) DEFAULT NULL,
  `trades` bigint DEFAULT NULL,
  `created` timestamp NOT NULL,
  PRIMARY KEY (`base_currency`,`base_issuer`,`quote_issuer`,`quote_currency`,`created`),
  KEY `base_currency_idx` (`base_currency`),
  KEY `base_issuer_idx` (`base_issuer`),
  KEY `quote_issuer_idx` (`quote_issuer`),
  KEY `quote_currency_idx` (`quote_currency`),
  KEY `created_idx` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DEXTrades_mvl`
--

DROP TABLE IF EXISTS `DEXTrades_mvl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DEXTrades_mvl` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `hash` varchar(128) NOT NULL,
  `maker` varchar(128) DEFAULT NULL,
  `taker` varchar(128) DEFAULT NULL,
  `sequence` bigint DEFAULT NULL,
  `base_currency` varchar(45) DEFAULT NULL,
  `base_issuer` varchar(128) DEFAULT NULL,
  `quote_currency` varchar(45) DEFAULT NULL,
  `quote_issuer` varchar(128) DEFAULT NULL,
  `price` decimal(25,10) DEFAULT NULL,
  `volume` bigint DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `ledger` bigint NOT NULL,
  `record_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `maker_idx` (`maker`),
  KEY `taker_idx` (`taker`),
  KEY `base_currency_idx` (`base_currency`),
  KEY `base_issuer_idx` (`base_issuer`),
  KEY `quote_currency_idx` (`quote_currency`),
  KEY `quote_issuer_idx` (`quote_issuer`),
  KEY `created_idx` (`created`),
  KEY `created_desc_idx` (`created` DESC),
  KEY `record_ts_idx` (`record_ts`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DepositPreauth`
--

DROP TABLE IF EXISTS `DepositPreauth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DepositPreauth` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EscrowCancel`
--

DROP TABLE IF EXISTS `EscrowCancel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EscrowCancel` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=297 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EscrowCreate`
--

DROP TABLE IF EXISTS `EscrowCreate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EscrowCreate` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint DEFAULT NULL,
  `amount` decimal(25,10) DEFAULT NULL,
  `destination` varchar(128) DEFAULT NULL,
  `finish_after` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=4872 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EscrowFinish`
--

DROP TABLE IF EXISTS `EscrowFinish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EscrowFinish` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=2264 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `KnownAddresses`
--

DROP TABLE IF EXISTS `KnownAddresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `KnownAddresses` (
  `name` varchar(128) DEFAULT NULL,
  `address` varchar(128) NOT NULL,
  `domain` varchar(128) DEFAULT NULL,
  `color` varchar(128) DEFAULT NULL,
  `validated` tinyint(1) DEFAULT NULL,
  `office_address` blob,
  `lat` decimal(9,6) DEFAULT NULL,
  `lon` decimal(9,6) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `weight` varchar(45) DEFAULT '0',
  `exchange` tinyint DEFAULT '1',
  `token_issuer` tinyint DEFAULT '0',
  PRIMARY KEY (`address`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `address_idx` (`address`),
  KEY `name_idx` (`name`),
  KEY `add_name_idx` (`name`,`address`),
  KEY `exchange_idx` (`exchange`)
) ENGINE=InnoDB AUTO_INCREMENT=91394 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Ledger`
--

DROP TABLE IF EXISTS `Ledger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ledger` (
  `ledger_index` bigint NOT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ledger_index`),
  UNIQUE KEY `hash_UNIQUE` (`hash`),
  KEY `ledger_idx` (`ledger_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NFTokenAcceptOffer`
--

DROP TABLE IF EXISTS `NFTokenAcceptOffer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NFTokenAcceptOffer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NFTokenBurn`
--

DROP TABLE IF EXISTS `NFTokenBurn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NFTokenBurn` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NFTokenCancelOffer`
--

DROP TABLE IF EXISTS `NFTokenCancelOffer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NFTokenCancelOffer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NFTokenCreateOffer`
--

DROP TABLE IF EXISTS `NFTokenCreateOffer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NFTokenCreateOffer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NFTokenMint`
--

DROP TABLE IF EXISTS `NFTokenMint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NFTokenMint` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OfferCancel`
--

DROP TABLE IF EXISTS `OfferCancel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OfferCancel` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `taker_gets_currency` varchar(40) DEFAULT NULL,
  `taker_gets_currency_hex` varchar(128) DEFAULT NULL,
  `taker_gets_issuer` varchar(128) DEFAULT NULL,
  `taker_gets_amount` decimal(25,10) DEFAULT NULL,
  `taker_pays_currency` varchar(40) DEFAULT NULL,
  `taker_pays_currency_hex` varchar(128) DEFAULT NULL,
  `taker_pays_issuer` varchar(128) DEFAULT NULL,
  `taker_pays_amount` decimal(25,10) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `flags` bigint DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44693552 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OfferCreate`
--

DROP TABLE IF EXISTS `OfferCreate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OfferCreate` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `taker_gets_currency` varchar(40) DEFAULT NULL,
  `taker_gets_currency_hex` varchar(128) DEFAULT NULL,
  `taker_gets_issuer` varchar(128) DEFAULT NULL,
  `taker_gets_amount` decimal(25,10) DEFAULT NULL,
  `taker_pays_currency` varchar(40) DEFAULT NULL,
  `taker_pays_currency_hex` varchar(128) DEFAULT NULL,
  `taker_pays_issuer` varchar(128) DEFAULT NULL,
  `taker_pays_amount` decimal(25,10) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `flags` bigint DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=363532657 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Payment`
--

DROP TABLE IF EXISTS `Payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `destination` varchar(128) DEFAULT NULL,
  `amount` decimal(25,10) DEFAULT NULL,
  `currency` varchar(40) DEFAULT NULL,
  `currency_hex` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `destination_tag` varchar(45) DEFAULT NULL,
  `source_tag` varchar(45) DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  `issuer` varchar(128) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`),
  KEY `LOOKUP` (`account`,`destination`,`amount`,`currency`,`created`,`destination_tag`,`issuer`,`transaction_result`),
  KEY `TOKENS` (`account`,`destination`,`currency`,`created`),
  KEY `account_idx` (`account`),
  KEY `destination_idx` (`destination`),
  KEY `created_idx` (`created`),
  KEY `currency_idx` (`currency`),
  KEY `destination_tag_idx` (`destination_tag`),
  KEY `issuer_idx` (`issuer`),
  KEY `transaction_result_idx` (`transaction_result`),
  KEY `currency_hex_idx` (`currency_hex`),
  KEY `created_desc_idx` (`created` DESC),
  KEY `amount_idx` (`amount`)
) ENGINE=InnoDB AUTO_INCREMENT=92269492 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`stick`@`%`*/ /*!50003 TRIGGER `Payment_ins` AFTER INSERT ON `Payment` FOR EACH ROW BEGIN	
	INSERT INTO Payment_mvl  VALUES (NEW.account, NEW.destination, NEW.amount, NEW.currency, NEW.currency_hex, NEW.hash, NEW.destination_tag, NEW.source_tag, NEW.transaction_result, NEW.fee, NEW.ledger, NEW.issuer, NEW.created, NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`stick`@`%`*/ /*!50003 TRIGGER `Payment_insg` AFTER INSERT ON `Payment` FOR EACH ROW BEGIN	
	INSERT INTO Payment_mgvl  VALUES (NEW.account, NEW.destination, NEW.amount, NEW.currency, NEW.currency_hex, NEW.hash, NEW.destination_tag, NEW.source_tag, NEW.transaction_result, NEW.fee, NEW.ledger, NEW.issuer, NEW.created, NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `PaymentChannelClaim`
--

DROP TABLE IF EXISTS `PaymentChannelClaim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PaymentChannelClaim` (
  `id` bigint NOT NULL,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PaymentChannelCreate`
--

DROP TABLE IF EXISTS `PaymentChannelCreate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PaymentChannelCreate` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PaymentChannelFund`
--

DROP TABLE IF EXISTS `PaymentChannelFund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PaymentChannelFund` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Payment_mgv`
--

DROP TABLE IF EXISTS `Payment_mgv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment_mgv` (
  `transactions` bigint DEFAULT NULL,
  `volume` decimal(25,10) DEFAULT NULL,
  `created` timestamp NOT NULL,
  `currency` varchar(128) NOT NULL,
  `issuer` varchar(128) NOT NULL,
  `gateway_in` varchar(128) NOT NULL,
  `gateway_out` varchar(128) NOT NULL,
  `direction` varchar(45) NOT NULL,
  PRIMARY KEY (`created`,`currency`,`issuer`,`direction`,`gateway_in`,`gateway_out`),
  UNIQUE KEY `index_table` (`gateway_out`,`gateway_in`,`direction`,`issuer`,`currency`,`created`),
  KEY `currency_idx` (`currency`),
  KEY `issuer_idx` (`issuer`),
  KEY `direction_idx` (`direction`),
  KEY `gateway_in_idx` (`gateway_in`),
  KEY `gateway_out_idx` (`gateway_out`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Payment_mgvl`
--

DROP TABLE IF EXISTS `Payment_mgvl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment_mgvl` (
  `account` varchar(128) DEFAULT NULL,
  `destination` varchar(128) DEFAULT NULL,
  `amount` decimal(25,10) DEFAULT NULL,
  `currency` varchar(40) DEFAULT NULL,
  `currency_hex` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `destination_tag` varchar(45) DEFAULT NULL,
  `source_tag` varchar(45) DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  `issuer` varchar(128) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `record_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `ts_idx` (`record_ts`),
  KEY `account_idx` (`account`),
  KEY `destination_idx` (`destination`),
  KEY `currency_idx` (`currency`),
  KEY `issuer_idx` (`issuer`),
  KEY `created_idx` (`created`),
  KEY `record_ts_idx` (`record_ts`),
  KEY `transaction_result_idx` (`transaction_result`),
  KEY `destination_tag_idx` (`destination_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Payment_mv`
--

DROP TABLE IF EXISTS `Payment_mv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment_mv` (
  `transactions` bigint DEFAULT NULL,
  `volume` decimal(25,10) DEFAULT NULL,
  `created` timestamp NOT NULL,
  `currency` varchar(128) NOT NULL,
  `issuer` varchar(128) NOT NULL,
  `direction` varchar(45) NOT NULL,
  PRIMARY KEY (`direction`,`issuer`,`currency`,`created`),
  KEY `currency_idx` (`currency`),
  KEY `issuer_idx` (`issuer`),
  KEY `direction_idx` (`direction`),
  KEY `created_idx` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Payment_mvl`
--

DROP TABLE IF EXISTS `Payment_mvl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment_mvl` (
  `account` varchar(128) DEFAULT NULL,
  `destination` varchar(128) DEFAULT NULL,
  `amount` decimal(25,10) DEFAULT NULL,
  `currency` varchar(40) DEFAULT NULL,
  `currency_hex` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `destination_tag` varchar(45) DEFAULT NULL,
  `source_tag` varchar(45) DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  `issuer` varchar(128) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `record_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `record_ts_idx` (`record_ts`),
  KEY `account_idx` (`account`),
  KEY `destination_idx` (`destination`),
  KEY `currency_idx` (`currency`),
  KEY `transaction_result_idx` (`transaction_result`),
  KEY `issuer_idx` (`issuer`),
  KEY `created_idx` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SetRegularKey`
--

DROP TABLE IF EXISTS `SetRegularKey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SetRegularKey` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=13009 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SignerListSet`
--

DROP TABLE IF EXISTS `SignerListSet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SignerListSet` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=701 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TicketCreate`
--

DROP TABLE IF EXISTS `TicketCreate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TicketCreate` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=134207 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TrustSet`
--

DROP TABLE IF EXISTS `TrustSet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TrustSet` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(128) DEFAULT NULL,
  `hash` varchar(128) NOT NULL,
  `currency` varchar(40) DEFAULT NULL,
  `currency_hex` varchar(128) DEFAULT NULL,
  `issuer` varchar(128) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `transaction_result` varchar(128) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `ledger` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_UNIQUE` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=66207398 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_token` varchar(128) NOT NULL,
  `whale_watch` tinyint(1) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `token_expires` varchar(45) DEFAULT NULL,
  `account` varchar(128) NOT NULL,
  PRIMARY KEY (`id`,`account`),
  KEY `id` (`id`,`user_token`,`whale_watch`,`created`,`account`,`token_expires`)
) ENGINE=InnoDB AUTO_INCREMENT=1292 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `xumm_payments`
--

DROP TABLE IF EXISTS `xumm_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xumm_payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `source` varchar(128) DEFAULT NULL,
  `destination` varchar(128) DEFAULT NULL,
  `destination_tag` bigint DEFAULT NULL,
  `source_tag` bigint DEFAULT NULL,
  `amount` decimal(14,8) DEFAULT NULL,
  `product` varchar(128) DEFAULT NULL,
  `hash` varchar(128) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `source` (`source`,`product`,`destination_tag`,`source_tag`,`amount`,`created`)
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'three'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `DEXTrades_tracking` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`stick`@`%`*/ /*!50106 EVENT `DEXTrades_tracking` ON SCHEDULE EVERY 1 HOUR STARTS '2022-06-22 01:18:35' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'Runs dex trades materialized tables inserts' DO CALL DEXTrades_refresh_mv('REFRESH FULL', NULL, @rc) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `Payments_gateway_tracking` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`stick`@`%`*/ /*!50106 EVENT `Payments_gateway_tracking` ON SCHEDULE EVERY 1 HOUR STARTS '2022-06-22 01:19:00' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'Runs payment gateway materialized tables inserts' DO CALL Payment_refresh_mgv('REFRESH FULL', NULL, @rc) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `Payments_tracking` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`stick`@`%`*/ /*!50106 EVENT `Payments_tracking` ON SCHEDULE EVERY 1 HOUR STARTS '2022-06-22 01:18:40' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'Runs payment materialized tables inserts' DO CALL Payment_refresh_mv('REFRESH FULL', NULL, @rc) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'three'
--
/*!50003 DROP PROCEDURE IF EXISTS `DEXTrades_refresh_mv` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`stick`@`%` PROCEDURE `DEXTrades_refresh_mv`(
    IN method VARCHAR(16)
  , IN ts TIMESTAMP
  , OUT rc INT
)
BEGIN

IF UPPER(method) = 'REBUILD' THEN

  TRUNCATE TABLE DEXTrades_mvl;
  TRUNCATE TABLE DEXTrades_mv;

  INSERT INTO DEXTrades_mv
    SELECT base_currency, base_issuer, SUM(volume) as base_volume, quote_issuer, quote_currency, SUM(price * volume) as quote_volume, count(id) as trades, DATE_FORMAT(created, '%Y-%m-%d') as date FROM DEXTrades
        GROUP BY date, base_currency, base_issuer, quote_currency, quote_issuer
        ORDER BY date ASC;

ELSEIF UPPER(method) = 'REFRESH FULL' THEN
    REPLACE INTO DEXTrades_mv
        SELECT base_currency, base_issuer, SUM(base_volume) AS base_volume, quote_issuer, quote_currency, SUM(quote_volume) AS quote_volume, SUM(trades) AS trades, DATE_FORMAT(created, '%Y-%m-%d') as date
        FROM (
            SELECT base_currency, base_issuer, SUM(base_volume) AS base_volume, quote_issuer, quote_currency, SUM(quote_volume) AS quote_volume, SUM(trades) AS trades, DATE_FORMAT(created, '%Y-%m-%d') as created FROM DEXTrades_mv
                GROUP BY created, base_currency, base_issuer, quote_currency, quote_issuer
            UNION
            SELECT base_currency, base_issuer, SUM(volume) as base_volume, quote_issuer, quote_currency, SUM(price * volume) as quote_volume, COUNT(id) as trades, DATE_FORMAT(created, '%Y-%m-%d') as created FROM DEXTrades_mvl
                GROUP BY created, base_currency, base_issuer, quote_currency, quote_issuer
                ORDER BY created ASC
        ) v
        GROUP BY date, base_currency, base_issuer, quote_currency, quote_issuer;

    
    TRUNCATE TABLE DEXTrades_mvl;

    SET rc = 0;
ELSEIF UPPER(method) = 'REFRESH' THEN

    REPLACE INTO DEXTrades_mv
        SELECT base_currency, base_issuer, SUM(base_volume) AS base_volume, quote_issuer, quote_currency, SUM(quote_volume) AS quote_volume, SUM(trades) AS trades, DATE_FORMAT(created, '%Y-%m-%d') as date
        FROM (
            SELECT base_currency, base_issuer, SUM(base_volume)AS base_volume, quote_issuer, quote_currency, SUM(quote_volume) AS quote_volume, SUM(trades)  AS trades, DATE_FORMAT(created, '%Y-%m-%d') as created FROM DEXTrades_mv
                GROUP BY created, base_currency, base_issuer, quote_currency, quote_issuer
            UNION
            SELECT base_currency, base_issuer, SUM(volume) as base_volume, quote_issuer, quote_currency, SUM(price * volume) as quote_volume, COUNT(id) as trades, DATE_FORMAT(created, '%Y-%m-%d') as created FROM DEXTrades_mvl
                WHERE record_ts < ts
                GROUP BY created, base_currency, base_issuer, quote_currency, quote_issuer
                ORDER BY created ASC
        ) v
        GROUP BY date, base_currency, base_issuer, quote_currency, quote_issuer;  

    DELETE FROM DEXTrades_mvl WHERE record_ts < ts;

    SET rc = 0;
ELSE
  SET rc = 1;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Payment_refresh_mgv` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`stick`@`%` PROCEDURE `Payment_refresh_mgv`(
    IN method VARCHAR(16)
  , IN ts TIMESTAMP
  , OUT rc INT
)
BEGIN

IF UPPER(method) = 'REBUILD' THEN

  TRUNCATE TABLE Payment_mgvl;
  TRUNCATE TABLE Payment_mgv;

  INSERT INTO Payment_mgv
    SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment.created, '%Y-%m-%d') as date, currency, issuer, GATEWAY_IN.name AS gateway_in, '', 'IN' AS direction FROM Payment 
        JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address)
        LEFT JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address) 
        WHERE transaction_result = 'tesSUCCESS'
        AND (GATEWAY_OUT.name IS NULL OR GATEWAY_IN.name != GATEWAY_OUT.name)
        AND GATEWAY_IN.name IS NOT NULL
        GROUP BY date, currency, issuer, gateway_in;
  INSERT INTO Payment_mgv
    SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment.created, '%Y-%m-%d') as date, currency, issuer, '', GATEWAY_OUT.name AS gateway_out, 'OUT' AS direction FROM Payment 
        JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address)
        LEFT JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address)
        WHERE transaction_result = 'tesSUCCESS'
        AND (GATEWAY_IN.name IS NULL OR GATEWAY_IN.name != GATEWAY_OUT.name)
        AND GATEWAY_OUT.name IS NOT NULL
        GROUP BY date, currency, issuer, gateway_out;
  INSERT INTO Payment_mgv
    SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment.created, '%Y-%m-%d') as date, currency, issuer, GATEWAY_IN.name AS gateway_in, GATEWAY_OUT.name AS gateway_out, 'CEX to CEX' AS direction FROM Payment 
        JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address) 
        JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address)
        WHERE transaction_result = 'tesSUCCESS'
        AND GATEWAY_OUT.name != GATEWAY_IN.name
        GROUP BY date, currency, issuer, gateway_in, gateway_out;
  INSERT INTO Payment_mgv
    SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment.created, '%Y-%m-%d') as date, currency, issuer, GATEWAY_IN.name AS gateway_in, '', 'FROM External' AS direction FROM Payment 
        JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address) 
        LEFT JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address)
        WHERE transaction_result = 'tesSUCCESS'
        AND GATEWAY_OUT.name IS NULL
        GROUP BY date, currency, issuer, gateway_in;
  INSERT INTO Payment_mgv
    SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment.created, '%Y-%m-%d') as date, currency, issuer, '', GATEWAY_OUT.name AS gateway_out, 'TO External' AS direction FROM Payment 
        JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address) 
        LEFT JOIN KnownAddresses AS GATEWAY_IN ON (destination= GATEWAY_IN.address)
        WHERE transaction_result = 'tesSUCCESS'
        AND GATEWAY_IN.name IS NULL
        GROUP BY date, currency, issuer, gateway_out;

ELSEIF UPPER(method) = 'REFRESH FULL' THEN
    REPLACE INTO Payment_mgv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction
        FROM (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction FROM Payment_mgv WHERE direction = 'IN'
				GROUP BY created, currency, issuer, gateway_in, gateway_out
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mgvl.created, '%Y-%m-%d') as created, currency, issuer, GATEWAY_IN.name AS gateway_in, '', 'IN' AS direction FROM Payment_mgvl 
                JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address)
                LEFT JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address) 
                WHERE transaction_result = 'tesSUCCESS'
                AND (GATEWAY_OUT.name IS NULL OR GATEWAY_IN.name != GATEWAY_OUT.name)
                GROUP BY created, currency, issuer, gateway_in
        ) v
        GROUP BY created, currency, issuer, direction, gateway_in, gateway_out;

    REPLACE INTO Payment_mgv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction
        FROM (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction FROM Payment_mgv WHERE direction = 'OUT'
				GROUP BY created, currency, issuer, gateway_in, gateway_out
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mgvl.created, '%Y-%m-%d') as created, currency, issuer, '', GATEWAY_OUT.name AS gateway_out, 'OUT' AS direction FROM Payment_mgvl 
                JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address)
                LEFT JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address)
                WHERE transaction_result = 'tesSUCCESS'
                AND (GATEWAY_IN.name IS NULL OR GATEWAY_IN.name != GATEWAY_OUT.name)
                GROUP BY created, currency, issuer, gateway_out
        ) w
        GROUP BY created, currency, issuer, direction, gateway_in, gateway_out;

    REPLACE INTO Payment_mgv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction 
        FROM (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction FROM Payment_mgv WHERE direction = 'CEX to CEX'
				GROUP BY created, currency, issuer, gateway_in, gateway_out
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mgvl.created, '%Y-%m-%d') as created, currency, issuer, GATEWAY_IN.name AS gateway_in, GATEWAY_OUT.name AS gateway_out, 'CEX to CEX' AS direction FROM Payment_mgvl 
                JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address) 
                JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address)
                WHERE transaction_result = 'tesSUCCESS'
                AND GATEWAY_OUT.name != GATEWAY_IN.name
                GROUP BY created, currency, issuer, gateway_in, gateway_out
        ) x
        GROUP BY created, currency, issuer, direction, gateway_in, gateway_out;
       
    REPLACE INTO Payment_mgv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction 
        FROM  (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction FROM Payment_mgv WHERE direction = 'FROM External'
				GROUP BY created, currency, issuer, gateway_in, gateway_out
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mgvl.created, '%Y-%m-%d') as created, currency, issuer, GATEWAY_IN.name AS gateway_in, '', 'FROM External' AS direction FROM Payment_mgvl 
                JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address) 
                LEFT JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address)
                WHERE transaction_result = 'tesSUCCESS'
                AND GATEWAY_OUT.name IS NULL
                GROUP BY created, currency, issuer, gateway_in
        ) y
        GROUP BY created, currency, issuer, direction, gateway_in, gateway_out;
    
    REPLACE INTO Payment_mgv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction 
        FROM (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction FROM Payment_mgv WHERE direction = 'TO External'
				GROUP BY created, currency, issuer, gateway_in, gateway_out
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mgvl.created, '%Y-%m-%d') as created, currency, issuer, '', GATEWAY_OUT.name AS gateway_out, 'TO External' AS direction FROM Payment_mgvl
                JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address) 
                LEFT JOIN KnownAddresses AS GATEWAY_IN ON (destination= GATEWAY_IN.address)
                WHERE transaction_result = 'tesSUCCESS'
                AND GATEWAY_IN.name IS NULL
                GROUP BY created, currency, issuer, gateway_out
        ) z
        GROUP BY created, currency, issuer, direction, gateway_in, gateway_out;
    
    TRUNCATE TABLE Payment_mgvl;

    SET rc = 0;
ELSEIF UPPER(method) = 'REFRESH' THEN

    REPLACE INTO Payment_mgv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction
        FROM (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction FROM Payment_mgv WHERE direction = 'IN'
				GROUP BY created, currency, issuer, gateway_in, gateway_out
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mgvl.created, '%Y-%m-%d') as created, currency, issuer, GATEWAY_IN.name AS gateway_in, '', 'IN' AS direction FROM Payment_mgvl 
                JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address)
                LEFT JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address) 
                WHERE transaction_result = 'tesSUCCESS'
                AND (GATEWAY_OUT.name IS NULL OR GATEWAY_IN.name != GATEWAY_OUT.name)
                AND record_ts < ts
                GROUP BY created, currency, issuer, gateway_in
        ) v
        GROUP BY created, currency, issuer, direction, gateway_in, gateway_out;

    REPLACE INTO Payment_mgv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction
        FROM (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction FROM Payment_mgv WHERE direction = 'OUT'
				GROUP BY created, currency, issuer, gateway_in, gateway_out
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mgvl.created, '%Y-%m-%d') as created, currency, issuer, '', GATEWAY_OUT.name AS gateway_out, 'OUT' AS direction FROM Payment_mgvl 
                JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address)
                LEFT JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address)
                WHERE transaction_result = 'tesSUCCESS'
                AND (GATEWAY_IN.name IS NULL OR GATEWAY_IN.name != GATEWAY_OUT.name)
                AND record_ts < ts
                GROUP BY created, currency, issuer, gateway_out
        ) w
        GROUP BY created, currency, issuer, direction, gateway_in, gateway_out;

    REPLACE INTO Payment_mgv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction 
        FROM (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction FROM Payment_mgv WHERE direction = 'CEX to CEX'
				GROUP BY created, currency, issuer, gateway_in, gateway_out
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mgvl.created, '%Y-%m-%d') as created, currency, issuer, GATEWAY_IN.name AS gateway_in, GATEWAY_OUT.name AS gateway_out, 'CEX to CEX' AS direction FROM Payment_mgvl 
                JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address) 
                JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address)
                WHERE transaction_result = 'tesSUCCESS'
                AND GATEWAY_OUT.name != GATEWAY_IN.name
                AND record_ts < ts
                GROUP BY created, currency, issuer, gateway_in, gateway_out
        ) x
        GROUP BY created, currency, issuer, direction, gateway_in, gateway_out;
       
    REPLACE INTO Payment_mgv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction 
        FROM  (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction FROM Payment_mgv WHERE direction = 'FROM External'
				GROUP BY created, currency, issuer, gateway_in, gateway_out
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mgvl.created, '%Y-%m-%d') as created, currency, issuer, GATEWAY_IN.name AS gateway_in, '', 'FROM External' AS direction FROM Payment_mgvl 
                JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address) 
                LEFT JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address)
                WHERE transaction_result = 'tesSUCCESS'
                AND GATEWAY_OUT.name IS NULL
                AND record_ts < ts
                GROUP BY created, currency, issuer, gateway_in
        ) y
        GROUP BY created, currency, issuer, direction, gateway_in, gateway_out;
    
    REPLACE INTO Payment_mgv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction 
        FROM (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, gateway_in, gateway_out, direction FROM Payment_mgv WHERE direction = 'TO External'
				GROUP BY created, currency, issuer, gateway_in, gateway_out
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mgvl.created, '%Y-%m-%d') as created, currency, issuer, '', GATEWAY_OUT.name AS gateway_out, 'TO External' AS direction FROM Payment_mgvl
                JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address) 
                LEFT JOIN KnownAddresses AS GATEWAY_IN ON (destination= GATEWAY_IN.address)
                WHERE transaction_result = 'tesSUCCESS'
                AND GATEWAY_IN.name IS NULL
                AND record_ts < ts
                GROUP BY created, currency, issuer, gateway_out
        ) z
        GROUP BY created, currency, issuer, direction, gateway_in, gateway_out;

    DELETE FROM Payment_mgvl WHERE record_ts < ts;

    SET rc = 0;
ELSE
  SET rc = 1;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Payment_refresh_mv` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`stick`@`%` PROCEDURE `Payment_refresh_mv`(
    IN method VARCHAR(16)
  , IN ts TIMESTAMP
  , OUT rc INT
)
BEGIN

IF UPPER(method) = 'REBUILD' THEN

  TRUNCATE TABLE Payment_mvl;
  TRUNCATE TABLE Payment_mv;

  INSERT INTO Payment_mv
    SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment.created, '%Y-%m-%d') as date, currency, issuer, 'IN' AS direction FROM Payment 
        JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address)
        LEFT JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address) 
        WHERE transaction_result = 'tesSUCCESS'
        AND (GATEWAY_OUT.name IS NULL OR GATEWAY_IN.name != GATEWAY_OUT.name)
        GROUP BY date, currency, issuer;
  INSERT INTO Payment_mv
    SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment.created, '%Y-%m-%d') as date, currency, issuer, 'OUT' AS direction FROM Payment 
        JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address)
        LEFT JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address)
        WHERE transaction_result = 'tesSUCCESS'
        AND (GATEWAY_IN.name IS NULL OR GATEWAY_IN.name != GATEWAY_OUT.name)
        GROUP BY date, currency, issuer;
  INSERT INTO Payment_mv
    SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment.created, '%Y-%m-%d') as date, currency, issuer, 'CEX to CEX' AS direction FROM Payment 
        JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address) 
        JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address)
        WHERE transaction_result = 'tesSUCCESS'
        AND GATEWAY_OUT.name != GATEWAY_IN.name
        GROUP BY date, currency, issuer;
  INSERT INTO Payment_mv
    SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment.created, '%Y-%m-%d') as date, currency, issuer, 'FROM External' AS direction FROM Payment 
        JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address) 
        LEFT JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address)
        WHERE transaction_result = 'tesSUCCESS'
        AND GATEWAY_OUT.name IS NULL
        GROUP BY date, currency, issuer;
  INSERT INTO Payment_mv
    SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment.created, '%Y-%m-%d') as date, currency, issuer, 'TO External' AS direction FROM Payment 
        JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address) 
        LEFT JOIN KnownAddresses AS GATEWAY_IN ON (destination= GATEWAY_IN.address)
        WHERE transaction_result = 'tesSUCCESS'
        AND GATEWAY_IN.name IS NULL
        GROUP BY date, currency, issuer;

ELSEIF UPPER(method) = 'REFRESH FULL' THEN
    REPLACE INTO Payment_mv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction
        FROM (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction FROM Payment_mv WHERE direction = 'IN'
				GROUP BY created, currency, issuer
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mvl.created, '%Y-%m-%d') as created, currency, issuer, 'IN' AS direction FROM Payment_mvl 
                JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address)
                LEFT JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address) 
                WHERE transaction_result = 'tesSUCCESS'
                AND (GATEWAY_OUT.name IS NULL OR GATEWAY_IN.name != GATEWAY_OUT.name)
                GROUP BY created, currency, issuer
        ) v
        GROUP BY created, currency, issuer, direction;

    REPLACE INTO Payment_mv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction
        FROM (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction FROM Payment_mv WHERE direction = 'OUT'
				GROUP BY created, currency, issuer
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mvl.created, '%Y-%m-%d') as created, currency, issuer, 'OUT' AS direction FROM Payment_mvl 
                JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address)
                LEFT JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address)
                WHERE transaction_result = 'tesSUCCESS'
                AND (GATEWAY_IN.name IS NULL OR GATEWAY_IN.name != GATEWAY_OUT.name)
                GROUP BY created, currency, issuer
        ) w
        GROUP BY created, currency, issuer, direction;

    REPLACE INTO Payment_mv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction 
        FROM (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction FROM Payment_mv WHERE direction = 'CEX to CEX'
				GROUP BY created, currency, issuer
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mvl.created, '%Y-%m-%d') as created, currency, issuer, 'CEX to CEX' AS direction FROM Payment_mvl 
                JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address) 
                JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address)
                WHERE transaction_result = 'tesSUCCESS'
                AND GATEWAY_OUT.name != GATEWAY_IN.name
                GROUP BY created, currency, issuer
        ) x
        GROUP BY created, currency, issuer, direction;
       
    REPLACE INTO Payment_mv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction 
        FROM  (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction FROM Payment_mv WHERE direction = 'FROM External'
				GROUP BY created, currency, issuer
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mvl.created, '%Y-%m-%d') as created, currency, issuer, 'FROM External' AS direction FROM Payment_mvl 
                JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address) 
                LEFT JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address)
                WHERE transaction_result = 'tesSUCCESS'
                AND GATEWAY_OUT.name IS NULL
                GROUP BY created, currency, issuer
        ) y
        GROUP BY created, currency, issuer, direction;
    
    REPLACE INTO Payment_mv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction 
        FROM (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction FROM Payment_mv WHERE direction = 'TO External'
				GROUP BY created, currency, issuer
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mvl.created, '%Y-%m-%d') as created, currency, issuer, 'TO External' AS direction FROM Payment_mvl
                JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address) 
                LEFT JOIN KnownAddresses AS GATEWAY_IN ON (destination= GATEWAY_IN.address)
                WHERE transaction_result = 'tesSUCCESS'
                AND GATEWAY_IN.name IS NULL
                GROUP BY created, currency, issuer
        ) z
        GROUP BY created, currency, issuer, direction;
    
    TRUNCATE TABLE Payment_mvl;

    SET rc = 0;
ELSEIF UPPER(method) = 'REFRESH' THEN

    REPLACE INTO Payment_mv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction
        FROM (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction FROM Payment_mv WHERE direction = 'IN'
				GROUP BY created, currency, issuer
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mvl.created, '%Y-%m-%d') as created, currency, issuer, 'IN' AS direction FROM Payment_mvl 
                JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address)
                LEFT JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address) 
                WHERE transaction_result = 'tesSUCCESS'
                AND (GATEWAY_OUT.name IS NULL OR GATEWAY_IN.name != GATEWAY_OUT.name)
                AND record_ts < ts
                GROUP BY created, currency, issuer
        ) v
        GROUP BY created, currency, issuer, direction;

    REPLACE INTO Payment_mv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction
        FROM (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction FROM Payment_mv WHERE direction = 'OUT'
				GROUP BY created, currency, issuer
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mvl.created, '%Y-%m-%d') as created, currency, issuer, 'OUT' AS direction FROM Payment_mvl 
                JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address)
                LEFT JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address)
                WHERE transaction_result = 'tesSUCCESS'
                AND (GATEWAY_IN.name IS NULL OR GATEWAY_IN.name != GATEWAY_OUT.name)
                AND record_ts < ts
                GROUP BY created, currency, issuer
        ) w
        GROUP BY created, currency, issuer, direction;

    REPLACE INTO Payment_mv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction 
        FROM (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction FROM Payment_mv WHERE direction = 'CEX to CEX'
				GROUP BY created, currency, issuer
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mvl.created, '%Y-%m-%d') as created, currency, issuer, 'CEX to CEX' AS direction FROM Payment_mvl 
                JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address) 
                JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address)
                WHERE transaction_result = 'tesSUCCESS'
                AND GATEWAY_OUT.name != GATEWAY_IN.name
                AND record_ts < ts
                GROUP BY created, currency, issuer
        ) x
        GROUP BY created, currency, issuer, direction;
       
    REPLACE INTO Payment_mv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction 
        FROM  (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction FROM Payment_mv WHERE direction = 'FROM External'
				GROUP BY created, currency, issuer
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mvl.created, '%Y-%m-%d') as created, currency, issuer, 'FROM External' AS direction FROM Payment_mvl 
                JOIN KnownAddresses AS GATEWAY_IN ON (destination = GATEWAY_IN.address) 
                LEFT JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address)
                WHERE transaction_result = 'tesSUCCESS'
                AND GATEWAY_OUT.name IS NULL
                AND record_ts < ts
                GROUP BY created, currency, issuer
        ) y
        GROUP BY created, currency, issuer, direction;
    
    REPLACE INTO Payment_mv
        SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction 
        FROM (
            SELECT SUM(transactions) AS transactions, SUM(volume) AS volume, DATE_FORMAT(created, '%Y-%m-%d') as created, currency, issuer, direction FROM Payment_mv WHERE direction = 'TO External'
				GROUP BY created, currency, issuer
            UNION
            SELECT COUNT(amount) AS transactions, SUM(amount) AS volume, DATE_FORMAT(Payment_mvl.created, '%Y-%m-%d') as created, currency, issuer, 'TO External' AS direction FROM Payment_mvl
                JOIN KnownAddresses AS GATEWAY_OUT ON (account = GATEWAY_OUT.address) 
                LEFT JOIN KnownAddresses AS GATEWAY_IN ON (destination= GATEWAY_IN.address)
                WHERE transaction_result = 'tesSUCCESS'
                AND GATEWAY_IN.name IS NULL
                AND record_ts < ts
                GROUP BY created, currency, issuer
        ) z
        GROUP BY created, currency, issuer, direction;

    DELETE FROM Payment_mvl WHERE record_ts < ts;

    SET rc = 0;
ELSE
  SET rc = 1;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-21 21:25:06
