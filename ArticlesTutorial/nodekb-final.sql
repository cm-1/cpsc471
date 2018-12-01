-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: nodekb
-- ------------------------------------------------------
-- Server version	5.7.13-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `author` varchar(45) NOT NULL,
  `body` varchar(255) NOT NULL,
  `authorID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `article_auth_idx` (`authorID`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (1,'Title One','Mark Twain','This is my new favourite thing I have ever written!',4),(2,'Title Two','Mark Twain','This is my NEW favourite thing I have ever written!!!',4),(3,'Title Three','Mark Twain','This is my SUPER NEW favourite thing I have ever written!',4),(4,'Title Four','Mark Shakespeare','I\'m the best Mark.',5),(5,'Title Five','Mark Best','I\'m the Mark Best.',6),(23,'Hi 2','BFN','I finally did it 2\r\n!!\r\n',1);
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `username` varchar(128) NOT NULL,
  `email` varchar(254) NOT NULL,
  `password` char(60) NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('BFN','bfn@gmail.com','$2a$10$q66FNt6V.36UFoLuODBTLOMZqq3kl25qy9BGkHxLUcQVeKimd.GO2','Chris',1),('Charles','charlie@gmail.com','$2a$10$B855Sz/KFT9OwTaTZ6ltde3eQJyjQ/o4mZoXJULg3Q4POtFZtHnyq','Charlie',2),('davem','dm@telus.net','$2a$10$q5jhSEcaJxZc7zzranGsX.fVXopgKvLdL.w3C8G/Jiw..IUP4gSmu','Dave',3),('Mark Twain','twain@yahoo.net','$2a$10$SJXyU4b99TWtfyZsGoYONOZHXOfDOtjB2HdaHAxDLauz8Hh90JhMq','Mark Twain',4),('Mark Shakespeare','tobeornottobe@gmail.com','$2a$10$hH7ZQ16JQxUYN03OKFExzemER/sOMmmadxqrjgxq1twr7QKUC4OOK','Mark Shakespeare',5),('Mark Best','best@best.best','$2a$10$4x/CtsgWXwXMr6z/QX8dKe7d4WFfW6Jw3e55iUpKn6hkAGJkLoDLK','Mark Best',6);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-30 17:17:04
