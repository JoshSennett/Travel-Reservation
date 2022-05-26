-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: airportdb
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `aircraft`
--

DROP TABLE IF EXISTS `aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircraft` (
  `Aircraft_ID` int NOT NULL,
  `First_class_seats` int DEFAULT NULL,
  `Biz_class_seats` int DEFAULT NULL,
  `Econ_class_seats` int DEFAULT NULL,
  `Airline_ID` char(2) NOT NULL,
  PRIMARY KEY (`Aircraft_ID`,`Airline_ID`),
  KEY `Airline_ID` (`Airline_ID`),
  CONSTRAINT `aircraft_ibfk_1` FOREIGN KEY (`Airline_ID`) REFERENCES `airline` (`Airline_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft`
--

LOCK TABLES `aircraft` WRITE;
/*!40000 ALTER TABLE `aircraft` DISABLE KEYS */;
/*!40000 ALTER TABLE `aircraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aircraft_day_of_the_week`
--

DROP TABLE IF EXISTS `aircraft_day_of_the_week`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircraft_day_of_the_week` (
  `Day_of_the_week` int NOT NULL,
  PRIMARY KEY (`Day_of_the_week`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft_day_of_the_week`
--

LOCK TABLES `aircraft_day_of_the_week` WRITE;
/*!40000 ALTER TABLE `aircraft_day_of_the_week` DISABLE KEYS */;
INSERT INTO `aircraft_day_of_the_week` VALUES (1),(2),(3),(4),(5),(6),(7);
/*!40000 ALTER TABLE `aircraft_day_of_the_week` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airline`
--

DROP TABLE IF EXISTS `airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airline` (
  `Airline_ID` char(2) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Airline_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airline`
--

LOCK TABLES `airline` WRITE;
/*!40000 ALTER TABLE `airline` DISABLE KEYS */;
INSERT INTO `airline` VALUES ('AA','American Airline'),('BA','Boinge Airlines'),('DA','Delta Airline'),('SO','Southwest'),('SW','Swiss');
/*!40000 ALTER TABLE `airline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport` (
  `Airport_ID` char(3) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Airport_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport`
--

LOCK TABLES `airport` WRITE;
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer` (
  `answer` varchar(200) DEFAULT NULL,
  `aid` int NOT NULL,
  `qid` int NOT NULL,
  `author_ID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`aid`),
  KEY `qid` (`qid`),
  KEY `author_ID` (`author_ID`),
  CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`qid`) REFERENCES `question` (`qid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `answer_ibfk_2` FOREIGN KEY (`author_ID`) REFERENCES `user` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `Passenger_ID` int NOT NULL,
  `User_ID` varchar(20) NOT NULL,
  `First_name` varchar(30) NOT NULL,
  `Last_name` varchar(30) NOT NULL,
  PRIMARY KEY (`Passenger_ID`),
  KEY `User_ID` (`User_ID`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `user` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flies`
--

DROP TABLE IF EXISTS `flies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flies` (
  `Day_of_the_week` int NOT NULL,
  `Aircraft_ID` int NOT NULL,
  `Airline_ID` char(2) NOT NULL,
  PRIMARY KEY (`Day_of_the_week`,`Aircraft_ID`,`Airline_ID`),
  KEY `Aircraft_ID` (`Aircraft_ID`,`Airline_ID`),
  CONSTRAINT `flies_ibfk_1` FOREIGN KEY (`Aircraft_ID`, `Airline_ID`) REFERENCES `aircraft` (`Aircraft_ID`, `Airline_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `flies_ibfk_2` FOREIGN KEY (`Day_of_the_week`) REFERENCES `aircraft_day_of_the_week` (`Day_of_the_week`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flies`
--

LOCK TABLES `flies` WRITE;
/*!40000 ALTER TABLE `flies` DISABLE KEYS */;
/*!40000 ALTER TABLE `flies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `Flight_number` int NOT NULL,
  `First_class_price` decimal(9,2) DEFAULT NULL,
  `Business_class_price` decimal(9,2) DEFAULT NULL,
  `Econ_class_price` decimal(9,2) DEFAULT NULL,
  `Take_off_time` time DEFAULT NULL,
  `Landing_time` time DEFAULT NULL,
  `Flight_date` date DEFAULT NULL,
  `Flight_type` char(3) DEFAULT NULL,
  `Airline_ID` char(2) NOT NULL,
  `Landing_airport_ID` char(3) NOT NULL,
  `Departing_airport_ID` char(3) NOT NULL,
  `Aircraft_ID` int NOT NULL,
  `Landing_date` date DEFAULT NULL,
  PRIMARY KEY (`Flight_number`,`Airline_ID`),
  KEY `Landing_airport_ID` (`Landing_airport_ID`),
  KEY `Departing_airport_ID` (`Departing_airport_ID`),
  KEY `Airline_ID` (`Airline_ID`),
  KEY `Aircraft_ID` (`Aircraft_ID`),
  CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`Landing_airport_ID`) REFERENCES `airport` (`Airport_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `flight_ibfk_2` FOREIGN KEY (`Departing_airport_ID`) REFERENCES `airport` (`Airport_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `flight_ibfk_3` FOREIGN KEY (`Airline_ID`) REFERENCES `airline` (`Airline_ID`),
  CONSTRAINT `flight_ibfk_4` FOREIGN KEY (`Aircraft_ID`) REFERENCES `aircraft` (`Aircraft_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `valid_dates` CHECK (((`Flight_date` < `Landing_date`) or ((`Flight_date` = `Landing_date`) and (`Take_off_time` < `Landing_time`))))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operates_with`
--

DROP TABLE IF EXISTS `operates_with`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operates_with` (
  `Airport_ID` char(3) NOT NULL,
  `Airline_ID` char(2) NOT NULL,
  PRIMARY KEY (`Airport_ID`,`Airline_ID`),
  CONSTRAINT `operates_with_ibfk_1` FOREIGN KEY (`Airport_ID`) REFERENCES `airport` (`Airport_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operates_with_ibfk_2` FOREIGN KEY (`Airport_ID`) REFERENCES `airline` (`Airline_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operates_with`
--

LOCK TABLES `operates_with` WRITE;
/*!40000 ALTER TABLE `operates_with` DISABLE KEYS */;
/*!40000 ALTER TABLE `operates_with` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question` (
  `title` varchar(100) DEFAULT NULL,
  `question` varchar(200) DEFAULT NULL,
  `qid` int NOT NULL,
  `author_ID` varchar(20) DEFAULT NULL,
  `answered` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`qid`),
  KEY `author_ID` (`author_ID`),
  CONSTRAINT `question_ibfk_1` FOREIGN KEY (`author_ID`) REFERENCES `user` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat`
--

DROP TABLE IF EXISTS `seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seat` (
  `Seat_number` int NOT NULL,
  `Flight_number` int NOT NULL,
  `Airline_ID` char(2) NOT NULL,
  `Class` char(3) DEFAULT NULL,
  `Change_fee` decimal(9,2) DEFAULT NULL,
  `Is_available` int DEFAULT NULL,
  `Ticket_number` int DEFAULT NULL,
  PRIMARY KEY (`Seat_number`,`Flight_number`,`Airline_ID`),
  KEY `Flight_number` (`Flight_number`),
  KEY `Airline_ID` (`Airline_ID`),
  KEY `Ticket_number` (`Ticket_number`),
  CONSTRAINT `seat_ibfk_1` FOREIGN KEY (`Flight_number`) REFERENCES `flight` (`Flight_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `seat_ibfk_2` FOREIGN KEY (`Airline_ID`) REFERENCES `airline` (`Airline_ID`),
  CONSTRAINT `seat_ibfk_3` FOREIGN KEY (`Ticket_number`) REFERENCES `ticket` (`Ticket_number`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat`
--

LOCK TABLES `seat` WRITE;
/*!40000 ALTER TABLE `seat` DISABLE KEYS */;
/*!40000 ALTER TABLE `seat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `Ticket_number` int NOT NULL,
  `Passenger_ID` int NOT NULL,
  `Total_fare` decimal(9,2) DEFAULT NULL,
  `Time_purchased` time DEFAULT NULL,
  `Booking_fee` decimal(9,2) DEFAULT NULL,
  `Date_purchased` date DEFAULT NULL,
  PRIMARY KEY (`Ticket_number`),
  KEY `Passenger_ID` (`Passenger_ID`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`Passenger_ID`) REFERENCES `customer` (`Passenger_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `User_ID` varchar(20) NOT NULL,
  `User_password` varchar(20) NOT NULL,
  `accessLevel` int NOT NULL,
  PRIMARY KEY (`User_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('admin','password',2),('cusrep','password',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waitlist`
--

DROP TABLE IF EXISTS `waitlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `waitlist` (
  `Passenger_ID` int NOT NULL,
  `Airline_ID` char(2) NOT NULL,
  `Flight_number` int NOT NULL,
  `Date_purchased` date DEFAULT NULL,
  `Seat_class` char(3) DEFAULT NULL,
  `Ticket_number` int DEFAULT NULL,
  `Time_purchased` time DEFAULT NULL,
  `Waitlist_id` int NOT NULL,
  PRIMARY KEY (`Passenger_ID`,`Airline_ID`,`Flight_number`,`Waitlist_id`),
  KEY `Airline_ID` (`Airline_ID`),
  KEY `Flight_number` (`Flight_number`),
  KEY `Ticket_number` (`Ticket_number`),
  CONSTRAINT `waitlist_ibfk_1` FOREIGN KEY (`Passenger_ID`) REFERENCES `customer` (`Passenger_ID`),
  CONSTRAINT `waitlist_ibfk_2` FOREIGN KEY (`Airline_ID`) REFERENCES `airline` (`Airline_ID`),
  CONSTRAINT `waitlist_ibfk_3` FOREIGN KEY (`Flight_number`) REFERENCES `flight` (`Flight_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `waitlist_ibfk_4` FOREIGN KEY (`Ticket_number`) REFERENCES `ticket` (`Ticket_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waitlist`
--

LOCK TABLES `waitlist` WRITE;
/*!40000 ALTER TABLE `waitlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `waitlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-05 11:54:28
