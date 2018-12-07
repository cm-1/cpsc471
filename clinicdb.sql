-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: clinicdb
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
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answers` (
  `Survey_ID` int(11) NOT NULL,
  `Healthcare_ID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Question_Number` int(11) NOT NULL,
  `Response` int(11) DEFAULT NULL,
  PRIMARY KEY (`Survey_ID`,`Healthcare_ID`,`Date`,`Question_Number`),
  KEY `answer_question_idx` (`Healthcare_ID`,`Question_Number`),
  KEY `answer_question_idx1` (`Survey_ID`,`Question_Number`),
  CONSTRAINT `answer_question` FOREIGN KEY (`Survey_ID`, `Question_Number`) REFERENCES `question` (`Survey_ID`, `Number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `answer_survresp` FOREIGN KEY (`Survey_ID`, `Healthcare_ID`, `Date`) REFERENCES `survey_response` (`Survey_ID`, `Healthcare_ID`, `Date`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment` (
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
  PRIMARY KEY (`Employee_ID`,`Date`,`Start_Time`),
  CONSTRAINT `appt_emp` FOREIGN KEY (`Employee_ID`) REFERENCES `psychologist` (`Employee_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (1,'2012-12-12','11:00:00',1,'Crushing deadlines',0,NULL,NULL,100,0);
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attends`
--

DROP TABLE IF EXISTS `attends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attends` (
  `Healthcare_ID` int(11) NOT NULL,
  `Employee_ID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  PRIMARY KEY (`Healthcare_ID`,`Employee_ID`,`Date`,`Time`),
  KEY `attends_appt_idx` (`Employee_ID`,`Date`),
  KEY `attends_appt` (`Employee_ID`,`Date`,`Time`),
  CONSTRAINT `attends_appt` FOREIGN KEY (`Employee_ID`, `Date`, `Time`) REFERENCES `appointment` (`Employee_ID`, `Date`, `Start_Time`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `attends_patient` FOREIGN KEY (`Healthcare_ID`) REFERENCES `patient` (`Health_care_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attends`
--

LOCK TABLES `attends` WRITE;
/*!40000 ALTER TABLE `attends` DISABLE KEYS */;
/*!40000 ALTER TABLE `attends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caregiver_in`
--

DROP TABLE IF EXISTS `caregiver_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caregiver_in` (
  `Healthcare_ID` int(11) NOT NULL,
  `Family_group_ID` int(11) NOT NULL,
  PRIMARY KEY (`Healthcare_ID`,`Family_group_ID`),
  KEY `carein_fg_idx` (`Family_group_ID`),
  CONSTRAINT `carein_fg` FOREIGN KEY (`Family_group_ID`) REFERENCES `family_group` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `carein_patient` FOREIGN KEY (`Healthcare_ID`) REFERENCES `patient` (`Health_care_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caregiver_in`
--

LOCK TABLES `caregiver_in` WRITE;
/*!40000 ALTER TABLE `caregiver_in` DISABLE KEYS */;
/*!40000 ALTER TABLE `caregiver_in` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caregiver_of`
--

DROP TABLE IF EXISTS `caregiver_of`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caregiver_of` (
  `Caregiver_Id` int(11) NOT NULL,
  `Child_Id` int(11) NOT NULL,
  PRIMARY KEY (`Caregiver_Id`,`Child_Id`),
  KEY `careof_child_idx` (`Child_Id`),
  CONSTRAINT `careof_caregiver` FOREIGN KEY (`Caregiver_Id`) REFERENCES `patient` (`Health_care_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `careof_child` FOREIGN KEY (`Child_Id`) REFERENCES `patient` (`Health_care_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caregiver_of`
--

LOCK TABLES `caregiver_of` WRITE;
/*!40000 ALTER TABLE `caregiver_of` DISABLE KEYS */;
/*!40000 ALTER TABLE `caregiver_of` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_account`
--

DROP TABLE IF EXISTS `client_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_account` (
  `accountID` int(11) NOT NULL,
  `healthcare_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`accountID`),
  KEY `clientAcc_hcid_idx` (`healthcare_ID`),
  CONSTRAINT `clientAcc_hcid` FOREIGN KEY (`healthcare_ID`) REFERENCES `patient` (`Health_care_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `clientAcc_userAcc` FOREIGN KEY (`accountID`) REFERENCES `user_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_account`
--

LOCK TABLES `client_account` WRITE;
/*!40000 ALTER TABLE `client_account` DISABLE KEYS */;
INSERT INTO `client_account` VALUES (5,11);
/*!40000 ALTER TABLE `client_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_info`
--

DROP TABLE IF EXISTS `contact_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_info` (
  `CI_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(5) DEFAULT NULL,
  `Fname` varchar(255) DEFAULT NULL,
  `Lname` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Email` varchar(254) DEFAULT NULL,
  `Home_phone` varchar(15) DEFAULT NULL,
  `Cell_phone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`CI_ID`),
  UNIQUE KEY `CI_ID_UNIQUE` (`CI_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_info`
--

LOCK TABLES `contact_info` WRITE;
/*!40000 ALTER TABLE `contact_info` DISABLE KEYS */;
INSERT INTO `contact_info` VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'Dr','Lucas','King','177 Streetville Drive','1@email.com','(403) 555-5555','(403) 555-5555'),(3,'Dr','A','B','C','d@email.com','444','444'),(4,'dr','a','b','c','d@email.com','4','4'),(5,'a','b','c','d','e@email.com','f','g'),(6,'a','b','c','d','e@email.com','4','4'),(7,'dr','a','b','c','d@email.com','4','444'),(8,'Dr','f','g','a','g@notakemail.com','4','4'),(9,'dr','mario','','a','b@email.com','c','d'),(10,'dr','family','given','dressad','address@address.com','5','5'),(11,'dr','a','b','a','address@address.com','403','40'),(12,'Dr','Phil','Williamson','181 Arcane Grove','will@notemail.com','(403) 555-5555','(403) 555-5555');
/*!40000 ALTER TABLE `contact_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dependent_in`
--

DROP TABLE IF EXISTS `dependent_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dependent_in` (
  `Healthcare_id` int(11) NOT NULL,
  `Family_Group_id` int(11) NOT NULL,
  PRIMARY KEY (`Healthcare_id`),
  KEY `dep_fg_idx` (`Family_Group_id`),
  CONSTRAINT `dep_fg` FOREIGN KEY (`Family_Group_id`) REFERENCES `family_group` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dep_patient` FOREIGN KEY (`Healthcare_id`) REFERENCES `patient` (`Health_care_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dependent_in`
--

LOCK TABLES `dependent_in` WRITE;
/*!40000 ALTER TABLE `dependent_in` DISABLE KEYS */;
/*!40000 ALTER TABLE `dependent_in` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diagnosis`
--

DROP TABLE IF EXISTS `diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diagnosis` (
  `Healthcare_ID` int(11) NOT NULL,
  `Diagnosis` varchar(255) NOT NULL,
  PRIMARY KEY (`Healthcare_ID`,`Diagnosis`),
  CONSTRAINT `diagnosis_patient` FOREIGN KEY (`Healthcare_ID`) REFERENCES `patient` (`Health_care_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diagnosis`
--

LOCK TABLES `diagnosis` WRITE;
/*!40000 ALTER TABLE `diagnosis` DISABLE KEYS */;
/*!40000 ALTER TABLE `diagnosis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emergency_contacts`
--

DROP TABLE IF EXISTS `emergency_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emergency_contacts` (
  `Healthcare_ID` int(11) NOT NULL,
  `CI_ID` int(11) NOT NULL,
  `Relationship` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Healthcare_ID`,`CI_ID`),
  KEY `CI_ID_idx` (`CI_ID`),
  CONSTRAINT `CI_ID2` FOREIGN KEY (`CI_ID`) REFERENCES `contact_info` (`CI_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Healthcare_ID2` FOREIGN KEY (`Healthcare_ID`) REFERENCES `patient` (`Health_care_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emergency_contacts`
--

LOCK TABLES `emergency_contacts` WRITE;
/*!40000 ALTER TABLE `emergency_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `emergency_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emergency_services`
--

DROP TABLE IF EXISTS `emergency_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emergency_services` (
  `ES_ID` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `Type_Of_Service` varchar(45) NOT NULL,
  `Location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emergency_services`
--

LOCK TABLES `emergency_services` WRITE;
/*!40000 ALTER TABLE `emergency_services` DISABLE KEYS */;
/*!40000 ALTER TABLE `emergency_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `Employee_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Start_Date` date NOT NULL,
  `Job_Type` varchar(45) DEFAULT NULL,
  `Status` varchar(45) NOT NULL,
  `SSN` int(11) NOT NULL,
  `CI_ID` int(11) NOT NULL,
  PRIMARY KEY (`Employee_ID`),
  UNIQUE KEY `Employee_ID_UNIQUE` (`Employee_ID`),
  UNIQUE KEY `SSN_UNIQUE` (`SSN`),
  KEY `emp_contact_idx` (`CI_ID`),
  CONSTRAINT `emp_contact` FOREIGN KEY (`CI_ID`) REFERENCES `contact_info` (`CI_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'2018-07-07','Employee','Active',111111111,12);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_account`
--

DROP TABLE IF EXISTS `employee_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_account` (
  `accountID` int(11) NOT NULL COMMENT '17:04:09 SELECT * FROM Employee_Accounts LIMIT 0, 1000 Error Code: 1146. Table ''clinicdb.employee_accounts'' doesn''t exist 0.00064 sec\n',
  `Employee_ID` int(11) NOT NULL,
  PRIMARY KEY (`accountID`),
  KEY `empAcc_empID_idx` (`Employee_ID`),
  CONSTRAINT `empAcc_empID` FOREIGN KEY (`Employee_ID`) REFERENCES `employee` (`Employee_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `empAcc_userAcc` FOREIGN KEY (`accountID`) REFERENCES `user_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_account`
--

LOCK TABLES `employee_account` WRITE;
/*!40000 ALTER TABLE `employee_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experiences`
--

DROP TABLE IF EXISTS `experiences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `experiences` (
  `Healthcare_ID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `Employee_ID` int(11) NOT NULL,
  PRIMARY KEY (`Healthcare_ID`,`Date`,`Time`,`Employee_ID`),
  KEY `exp_emp_idx` (`Employee_ID`),
  CONSTRAINT `exp_emp` FOREIGN KEY (`Employee_ID`) REFERENCES `psychologist` (`Employee_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `exp_patient` FOREIGN KEY (`Healthcare_ID`) REFERENCES `patient` (`Health_care_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experiences`
--

LOCK TABLES `experiences` WRITE;
/*!40000 ALTER TABLE `experiences` DISABLE KEYS */;
/*!40000 ALTER TABLE `experiences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `family_group`
--

DROP TABLE IF EXISTS `family_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `family_group` (
  `ID` int(11) NOT NULL,
  `Description` varchar(45) DEFAULT NULL,
  `Assigned_Employee_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fg_emp_idx` (`Assigned_Employee_ID`),
  CONSTRAINT `fg_emp` FOREIGN KEY (`Assigned_Employee_ID`) REFERENCES `psychologist` (`Employee_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `family_group`
--

LOCK TABLES `family_group` WRITE;
/*!40000 ALTER TABLE `family_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `family_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incident`
--

DROP TABLE IF EXISTS `incident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident` (
  `Employee_ID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `Description` varchar(150) NOT NULL,
  `Severity` varchar(150) NOT NULL,
  `Category` varchar(20) NOT NULL,
  `Resolution` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`Employee_ID`,`Date`,`Time`),
  CONSTRAINT `incident_emp` FOREIGN KEY (`Employee_ID`) REFERENCES `psychologist` (`Employee_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incident`
--

LOCK TABLES `incident` WRITE;
/*!40000 ALTER TABLE `incident` DISABLE KEYS */;
/*!40000 ALTER TABLE `incident` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `informed_of`
--

DROP TABLE IF EXISTS `informed_of`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `informed_of` (
  `Employee_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `ES_ID` int(11) NOT NULL,
  PRIMARY KEY (`Employee_ID`,`Date`,`Time`,`ES_ID`),
  KEY `ES_ID_idx` (`ES_ID`),
  CONSTRAINT `ES_ID` FOREIGN KEY (`ES_ID`) REFERENCES `emergency_services` (`ES_ID`),
  CONSTRAINT `informed_incident` FOREIGN KEY (`Employee_ID`, `Date`, `Time`) REFERENCES `incident` (`Employee_ID`, `Date`, `Time`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `informed_of`
--

LOCK TABLES `informed_of` WRITE;
/*!40000 ALTER TABLE `informed_of` DISABLE KEYS */;
/*!40000 ALTER TABLE `informed_of` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medication`
--

DROP TABLE IF EXISTS `medication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medication` (
  `ID` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `manufacturer` varchar(45) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medication`
--

LOCK TABLES `medication` WRITE;
/*!40000 ALTER TABLE `medication` DISABLE KEYS */;
INSERT INTO `medication` VALUES (1,'cam','cam\'s parents','peanut allergy'),(2,'sim','hogwarts','love potion'),(3,'sim','cam','chris'),(4,'test','omar','sim'),(5,'test','onetwo','omar'),(6,'sim','chris','lindsay'),(7,'weed','lindsay\'s house','stress'),(8,'simran','cam','omar');
/*!40000 ALTER TABLE `medication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `Health_care_id` int(11) NOT NULL,
  `Birthdate` date NOT NULL,
  `Sex` char(1) NOT NULL,
  `CI_ID` int(11) NOT NULL,
  PRIMARY KEY (`Health_care_id`),
  KEY `patient_contact_idx` (`CI_ID`),
  CONSTRAINT `patient_contact` FOREIGN KEY (`CI_ID`) REFERENCES `contact_info` (`CI_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (1,'2018-12-05','1',4),(2,'2018-12-04','1',6),(3,'2018-12-12','1',7),(4,'2018-12-11','1',8),(5,'2018-12-12','1',9),(6,'2018-12-04','1',10),(11,'2018-12-11','1',11);
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `psychologist`
--

DROP TABLE IF EXISTS `psychologist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `psychologist` (
  `Employee_ID` int(11) NOT NULL,
  `Facilitator_Flag` tinyint(1) NOT NULL,
  PRIMARY KEY (`Employee_ID`),
  CONSTRAINT `psych_emp` FOREIGN KEY (`Employee_ID`) REFERENCES `employee` (`Employee_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `psychologist`
--

LOCK TABLES `psychologist` WRITE;
/*!40000 ALTER TABLE `psychologist` DISABLE KEYS */;
INSERT INTO `psychologist` VALUES (1,0);
/*!40000 ALTER TABLE `psychologist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qualifications`
--

DROP TABLE IF EXISTS `qualifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qualifications` (
  `Employee_ID` int(11) NOT NULL,
  `Qualification` varchar(45) NOT NULL,
  KEY `Employee_ID_idx` (`Employee_ID`),
  CONSTRAINT `Employee_ID` FOREIGN KEY (`Employee_ID`) REFERENCES `psychologist` (`Employee_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qualifications`
--

LOCK TABLES `qualifications` WRITE;
/*!40000 ALTER TABLE `qualifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `qualifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question` (
  `Survey_ID` int(11) NOT NULL,
  `Number` int(11) NOT NULL,
  `Answer_format` int(11) NOT NULL,
  `Required` varchar(45) NOT NULL,
  `Prompt` varchar(45) NOT NULL,
  PRIMARY KEY (`Survey_ID`,`Number`),
  CONSTRAINT `question_survey` FOREIGN KEY (`Survey_ID`) REFERENCES `survey` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,1,5,'1','What is your age'),(1,2,5,'0','What is not your age?');
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reason_category`
--

DROP TABLE IF EXISTS `reason_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reason_category` (
  `Employee_ID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `Reason_Category` varchar(45) NOT NULL,
  PRIMARY KEY (`Employee_ID`,`Date`,`Time`,`Reason_Category`),
  CONSTRAINT `reason_appt` FOREIGN KEY (`Employee_ID`, `Date`, `Time`) REFERENCES `appointment` (`Employee_ID`, `Date`, `Start_Time`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reason_category`
--

LOCK TABLES `reason_category` WRITE;
/*!40000 ALTER TABLE `reason_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `reason_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `side_effect`
--

DROP TABLE IF EXISTS `side_effect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `side_effect` (
  `Med_ID` int(11) NOT NULL,
  `Side_Effect` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Med_ID`),
  CONSTRAINT `se_med` FOREIGN KEY (`Med_ID`) REFERENCES `medication` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `side_effect`
--

LOCK TABLES `side_effect` WRITE;
/*!40000 ALTER TABLE `side_effect` DISABLE KEYS */;
/*!40000 ALTER TABLE `side_effect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `survey`
--

DROP TABLE IF EXISTS `survey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `survey` (
  `ID` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `survey`
--

LOCK TABLES `survey` WRITE;
/*!40000 ALTER TABLE `survey` DISABLE KEYS */;
INSERT INTO `survey` VALUES (1,'Survery');
/*!40000 ALTER TABLE `survey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `survey_response`
--

DROP TABLE IF EXISTS `survey_response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `survey_response` (
  `Survey_ID` int(11) NOT NULL,
  `Healthcare_ID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Score` int(11) NOT NULL,
  PRIMARY KEY (`Survey_ID`,`Healthcare_ID`,`Date`),
  KEY `sr_patient_idx` (`Healthcare_ID`),
  CONSTRAINT `sr_patient` FOREIGN KEY (`Healthcare_ID`) REFERENCES `patient` (`Health_care_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sr_survey` FOREIGN KEY (`Survey_ID`) REFERENCES `survey` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `survey_response`
--

LOCK TABLES `survey_response` WRITE;
/*!40000 ALTER TABLE `survey_response` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_response` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `takes`
--

DROP TABLE IF EXISTS `takes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `takes` (
  `Health_care_ID` int(11) NOT NULL,
  `Med_ID` int(11) NOT NULL,
  `Dosage` int(11) NOT NULL,
  PRIMARY KEY (`Med_ID`,`Health_care_ID`),
  KEY `takes_patient_idx` (`Health_care_ID`),
  CONSTRAINT `takes_med` FOREIGN KEY (`Med_ID`) REFERENCES `medication` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `takes_patient` FOREIGN KEY (`Health_care_ID`) REFERENCES `patient` (`Health_care_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `takes`
--

LOCK TABLES `takes` WRITE;
/*!40000 ALTER TABLE `takes` DISABLE KEYS */;
/*!40000 ALTER TABLE `takes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `use`
--

DROP TABLE IF EXISTS `use`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `use` (
  `Med_ID` int(11) NOT NULL,
  `Use` varchar(65) NOT NULL,
  PRIMARY KEY (`Med_ID`),
  CONSTRAINT `use_med` FOREIGN KEY (`Med_ID`) REFERENCES `medication` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `use`
--

LOCK TABLES `use` WRITE;
/*!40000 ALTER TABLE `use` DISABLE KEYS */;
/*!40000 ALTER TABLE `use` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_account`
--

DROP TABLE IF EXISTS `user_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_account` (
  `Username` varchar(128) NOT NULL,
  `Password` char(60) NOT NULL,
  `Email` varchar(254) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Privilege_Level` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  UNIQUE KEY `Username_UNIQUE` (`Username`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_account`
--

LOCK TABLES `user_account` WRITE;
/*!40000 ALTER TABLE `user_account` DISABLE KEYS */;
INSERT INTO `user_account` VALUES ('yourname','$2a$10$2NUtaQznZUFHYFA2aVLtD.xNZic/zzZ9gwpTL4umrya7Au2e1GatS','sim@email.com',1,'0'),('simsims','$2a$10$nPxu08btTz1asvPL92HblekyEUnQdVpZTbyuFK.s1tx5n0i9sfPkm','simm@email.ca',4,'0'),('boy','$2a$10$lbrn3LNEXGBzZukLF4.j6eY38lgN0/HFvq4eEqcYpwRCYQCV/QiTG','boy@email.com',5,'0'),('girl','$2a$10$R6iYncinRr8XYXE2ja1louIVy9NMZmTNxleSfYnSSEWv5r4oGcw1W','girl@email.com',6,'0'),('admin','$2a$10$NM26BuG.TXFjJNNYqUwP1O02SygWfoTYCqpGmOSMPNWxtl9Ft36ty','admin@email.com',7,'2'),('employee','$2a$10$ON0YQGi4Ze/KzLcHok8lcepqE0TW6z8JpVTNlGjpViNfQONVVeDNK','employee@email.com',8,'1');
/*!40000 ALTER TABLE `user_account` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-07  9:28:56
