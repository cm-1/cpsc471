-- MySQL dump 10.13  Distrib 8.0.13, for macos10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: nodekb
-- ------------------------------------------------------
-- Server version 8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Answers`
--

DROP TABLE IF EXISTS `Answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Answers` (
  `Healthcare_ID` int(11) NOT NULL,
  `Survey_ID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Score` int(11) NOT NULL,
  PRIMARY KEY (`Healthcare_ID`,`Survey_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Answers`
--

LOCK TABLES `Answers` WRITE;
/*!40000 ALTER TABLE `Answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `Answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Appointment`
--

DROP TABLE IF EXISTS `Appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Appointment` (
  `Employee_ID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Start_Time` time NOT NULL,
  `Duration` int(11) NOT NULL,
  `Reason` varchar(155) NOT NULL,
  `Attendance_Status` tinyint(4) NOT NULL,
  `Dr_Notes` varchar(155) DEFAULT NULL,
  `Dr_Private_Notes` varchar(155) DEFAULT NULL,
  `Amount_Owed` int(11) DEFAULT NULL,
  `Amount_Paid` int(11) DEFAULT NULL,
  PRIMARY KEY (`Employee_ID`,`Date`,`Start_Time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Appointment`
--

LOCK TABLES `Appointment` WRITE;
/*!40000 ALTER TABLE `Appointment` DISABLE KEYS */;
/*!40000 ALTER TABLE `Appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Attends`
--

DROP TABLE IF EXISTS `Attends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Attends` (
  `Healthcare_ID` int(11) NOT NULL,
  `Employee_ID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  PRIMARY KEY (`Healthcare_ID`,`Employee_ID`,`Date`,`Time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Attends`
--

LOCK TABLES `Attends` WRITE;
/*!40000 ALTER TABLE `Attends` DISABLE KEYS */;
/*!40000 ALTER TABLE `Attends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Emergency_Services`
--

DROP TABLE IF EXISTS `Emergency_Services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Emergency_Services` (
  `ES_ID` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Description` varchar(45) NOT NULL,
  `Type_Of_Service` varchar(45) NOT NULL,
  `Location` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Emergency_Services`
--

LOCK TABLES `Emergency_Services` WRITE;
/*!40000 ALTER TABLE `Emergency_Services` DISABLE KEYS */;
/*!40000 ALTER TABLE `Emergency_Services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Experiences`
--

DROP TABLE IF EXISTS `Experiences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Experiences` (
  `Healthcare_ID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `Employee_ID` int(11) NOT NULL,
  PRIMARY KEY (`Healthcare_ID`,`Date`,`Time`,`Employee_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Experiences`
--

LOCK TABLES `Experiences` WRITE;
/*!40000 ALTER TABLE `Experiences` DISABLE KEYS */;
/*!40000 ALTER TABLE `Experiences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Family_Group`
--

DROP TABLE IF EXISTS `Family_Group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Family_Group` (
  `ID` int(11) NOT NULL,
  `Description` varchar(45) DEFAULT NULL,
  `Assigned_Employee_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`,`Assigned_Employee_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Family_Group`
--

LOCK TABLES `Family_Group` WRITE;
/*!40000 ALTER TABLE `Family_Group` DISABLE KEYS */;
/*!40000 ALTER TABLE `Family_Group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Incident`
--

DROP TABLE IF EXISTS `Incident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Incident` (
  `Employee_ID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `Description` varchar(150) NOT NULL,
  `Severity` varchar(150) NOT NULL,
  `Category` varchar(20) NOT NULL,
  `Resolution` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`Employee_ID`,`Date`,`Time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Incident`
--

LOCK TABLES `Incident` WRITE;
/*!40000 ALTER TABLE `Incident` DISABLE KEYS */;
/*!40000 ALTER TABLE `Incident` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Informed_Of`
--

DROP TABLE IF EXISTS `Informed_Of`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Informed_Of` (
  `Employee_ID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `ES_ID` int(11) NOT NULL,
  PRIMARY KEY (`Employee_ID`,`Date`,`Time`,`ES_ID`),
  KEY `ES_ID_idx` (`ES_ID`),
  CONSTRAINT `ES_ID` FOREIGN KEY (`ES_ID`) REFERENCES `emergency_services` (`es_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Informed_Of`
--

LOCK TABLES `Informed_Of` WRITE;
/*!40000 ALTER TABLE `Informed_Of` DISABLE KEYS */;
/*!40000 ALTER TABLE `Informed_Of` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Medication`
--

DROP TABLE IF EXISTS `Medication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Medication` (
  `ID` int(11) NOT NULL,
  `med_id` varchar(10) NOT NULL,
  `name` varchar(45) NOT NULL,
  `man` varchar(45) NOT NULL,
  `use` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Medication`
--

LOCK TABLES `Medication` WRITE;
/*!40000 ALTER TABLE `Medication` DISABLE KEYS */;
INSERT INTO `Medication` VALUES (1,'1238','cam','cam\'s parents','peanut allergy'),(2,'6969','sim','hogwarts','love potion'),(3,'omar','sim','cam','chris'),(4,'test','test','omar','sim'),(5,'1234','test','onetwo','omar'),(6,'54321','sim','chris','lindsay'),(7,'42069','weed','lindsay\'s house','stress'),(8,'6969','simran','cam','omar');
/*!40000 ALTER TABLE `Medication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Psychologist`
--

DROP TABLE IF EXISTS `Psychologist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Psychologist` (
  `Employee_ID` int(11) NOT NULL,
  `Facilitator_Flag` varchar(45) NOT NULL,
  PRIMARY KEY (`Employee_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Psychologist`
--

LOCK TABLES `Psychologist` WRITE;
/*!40000 ALTER TABLE `Psychologist` DISABLE KEYS */;
/*!40000 ALTER TABLE `Psychologist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Question`
--

DROP TABLE IF EXISTS `Question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Question` (
  `Survey_ID` int(11) NOT NULL,
  `Number` varchar(45) NOT NULL,
  `Answer_format` varchar(45) NOT NULL,
  `Required` varchar(45) NOT NULL,
  `Prompt` varchar(45) NOT NULL,
  PRIMARY KEY (`Survey_ID`,`Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Question`
--

LOCK TABLES `Question` WRITE;
/*!40000 ALTER TABLE `Question` DISABLE KEYS */;
/*!40000 ALTER TABLE `Question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reason_Category`
--

DROP TABLE IF EXISTS `Reason_Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Reason_Category` (
  `Employee_ID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `Reason_Category` varchar(45) NOT NULL,
  PRIMARY KEY (`Employee_ID`,`Date`,`Time`,`Reason_Category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reason_Category`
--

LOCK TABLES `Reason_Category` WRITE;
/*!40000 ALTER TABLE `Reason_Category` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reason_Category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Survey`
--

DROP TABLE IF EXISTS `Survey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Survey` (
  `ID` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Survey`
--

LOCK TABLES `Survey` WRITE;
/*!40000 ALTER TABLE `Survey` DISABLE KEYS */;
/*!40000 ALTER TABLE `Survey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Survey_Response`
--

DROP TABLE IF EXISTS `Survey_Response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Survey_Response` (
  `Survey_ID` int(11) NOT NULL,
  `Healthcare_ID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Score` int(11) NOT NULL,
  PRIMARY KEY (`Survey_ID`,`Healthcare_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Survey_Response`
--

LOCK TABLES `Survey_Response` WRITE;
/*!40000 ALTER TABLE `Survey_Response` DISABLE KEYS */;
/*!40000 ALTER TABLE `Survey_Response` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Table structure for table `Caregiver_In`
--

DROP TABLE IF EXISTS `Caregiver_In`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Caregiver_In` (
  `Healthcare_ID` int(11) NOT NULL,
  `Family_group_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Healthcare_ID`,`Family_group_ID`),
  CONSTRAINT `Healthcare_ID` FOREIGN KEY (`Healthcare_ID`) REFERENCES `Patient` (`Health_care_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Caregiver_In`
--

LOCK TABLES `Caregiver_In` WRITE;
/*!40000 ALTER TABLE `Caregiver_In` DISABLE KEYS */;
/*!40000 ALTER TABLE `Caregiver_In` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Caregiver_Of`
--

DROP TABLE IF EXISTS `Caregiver_Of`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Caregiver_Of` (
  `Caregiver_Id` int(11) NOT NULL,
  `Child_Id` int(11) NOT NULL,
  PRIMARY KEY (`Caregiver_Id`,`Child_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Caregiver_Of`
--

LOCK TABLES `Caregiver_Of` WRITE;
/*!40000 ALTER TABLE `Caregiver_Of` DISABLE KEYS */;
/*!40000 ALTER TABLE `Caregiver_Of` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Client_Accounts`
--

DROP TABLE IF EXISTS `Client_Accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Client_Accounts` (
  `Username` varchar(45) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `Email` varchar(255) NOT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Client_Accounts`
--

LOCK TABLES `Client_Accounts` WRITE;
/*!40000 ALTER TABLE `Client_Accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `Client_Accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Contact_Info`
--

DROP TABLE IF EXISTS `Contact_Info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Contact_Info` (
  `CI_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(5) DEFAULT NULL,
  `Fname` varchar(45) DEFAULT NULL,
  `Lname` varchar(45) DEFAULT NULL,
  `Address` varchar(45) DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `Home_phone` varchar(45) DEFAULT NULL,
  `Cell_phone` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CI_ID`),
  UNIQUE KEY `CI_ID_UNIQUE` (`CI_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Contact_Info`
--

LOCK TABLES `Contact_Info` WRITE;
/*!40000 ALTER TABLE `Contact_Info` DISABLE KEYS */;
/*!40000 ALTER TABLE `Contact_Info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Dependent_In`
--

DROP TABLE IF EXISTS `Dependent_In`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Dependent_In` (
  `Healthcare_id` int(11) NOT NULL,
  `Family_Group_id` int(11) NOT NULL,
  PRIMARY KEY (`Healthcare_id`),
  CONSTRAINT `Health_Care_ID` FOREIGN KEY (`Healthcare_id`) REFERENCES `Patient` (`Health_care_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dependent_In`
--

LOCK TABLES `Dependent_In` WRITE;
/*!40000 ALTER TABLE `Dependent_In` DISABLE KEYS */;
/*!40000 ALTER TABLE `Dependent_In` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Diagnosis`
--

DROP TABLE IF EXISTS `Diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Diagnosis` (
  `Healthcare_ID` int(11) NOT NULL,
  `Diagnosis` varchar(45) NOT NULL,
  PRIMARY KEY (`Healthcare_ID`,`Diagnosis`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Diagnosis`
--

LOCK TABLES `Diagnosis` WRITE;
/*!40000 ALTER TABLE `Diagnosis` DISABLE KEYS */;
/*!40000 ALTER TABLE `Diagnosis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Emergency_Contacts`
--

DROP TABLE IF EXISTS `Emergency_Contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Emergency_Contacts` (
  `Healthcare_ID` int(11) NOT NULL,
  `CI_ID` int(11) NOT NULL,
  `Relationship` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Healthcare_ID`,`CI_ID`),
  KEY `CI_ID_idx` (`CI_ID`),
  CONSTRAINT `CI_ID2` FOREIGN KEY (`CI_ID`) REFERENCES `Contact_Info` (`CI_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Healthcare_ID2` FOREIGN KEY (`Healthcare_ID`) REFERENCES `Patient` (`Health_care_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Emergency_Contacts`
--

LOCK TABLES `Emergency_Contacts` WRITE;
/*!40000 ALTER TABLE `Emergency_Contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `Emergency_Contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Employee` (
  `Employee_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Start_Date` date NOT NULL,
  `Job_Type` varchar(45) DEFAULT NULL,
  `Status` varchar(45) NOT NULL,
  PRIMARY KEY (`Employee_ID`),
  UNIQUE KEY `Employee_ID_UNIQUE` (`Employee_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employee_Account`
--

DROP TABLE IF EXISTS `Employee_Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Employee_Account` (
  `Username` varchar(45) NOT NULL COMMENT '17:04:09 SELECT * FROM Employee_Accounts LIMIT 0, 1000 Error Code: 1146. Table ''clinicdb.employee_accounts'' doesn''t exist 0.00064 sec\n',
  `Password` varchar(45) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Employee_ID` int(11) NOT NULL,
  PRIMARY KEY (`Username`,`Employee_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee_Account`
--

LOCK TABLES `Employee_Account` WRITE;
/*!40000 ALTER TABLE `Employee_Account` DISABLE KEYS */;
/*!40000 ALTER TABLE `Employee_Account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient`
--

DROP TABLE IF EXISTS `Patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Patient` (
  `Health_care_id` int(11) NOT NULL,
  `Birthdate` date DEFAULT NULL,
  `Sex` varchar(45) DEFAULT NULL,
  `CI_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Health_care_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient`
--

LOCK TABLES `Patient` WRITE;
/*!40000 ALTER TABLE `Patient` DISABLE KEYS */;
/*!40000 ALTER TABLE `Patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Qualifications`
--

DROP TABLE IF EXISTS `Qualifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Qualifications` (
  `Employee_ID` int(11) NOT NULL,
  `Qualifications` varchar(45) NOT NULL,
  PRIMARY KEY (`Employee_ID`,`Qualifications`),
  CONSTRAINT `Employee_ID` FOREIGN KEY (`Employee_ID`) REFERENCES `Employee` (`Employee_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Qualifications`
--

LOCK TABLES `Qualifications` WRITE;
/*!40000 ALTER TABLE `Qualifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `Qualifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Side_Effect`
--

DROP TABLE IF EXISTS `Side_Effect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Side_Effect` (
  `Med_ID` int(11) NOT NULL,
  `Side_Effect` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Med_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Side_Effect`
--

LOCK TABLES `Side_Effect` WRITE;
/*!40000 ALTER TABLE `Side_Effect` DISABLE KEYS */;
/*!40000 ALTER TABLE `Side_Effect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Takes`
--

DROP TABLE IF EXISTS `Takes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Takes` (
  `Health_care_ID` int(11) NOT NULL,
  `Med_ID` int(11) NOT NULL,
  `Dosage` int(11) NOT NULL,
  PRIMARY KEY (`Med_ID`,`Health_care_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Takes`
--

LOCK TABLES `Takes` WRITE;
/*!40000 ALTER TABLE `Takes` DISABLE KEYS */;
/*!40000 ALTER TABLE `Takes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Use`
--

DROP TABLE IF EXISTS `Use`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Use` (
  `Med_ID` int(11) NOT NULL,
  `Use` varchar(65) NOT NULL,
  PRIMARY KEY (`Med_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Use`
--

LOCK TABLES `Use` WRITE;
/*!40000 ALTER TABLE `Use` DISABLE KEYS */;
/*!40000 ALTER TABLE `Use` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-27 19:19:01

