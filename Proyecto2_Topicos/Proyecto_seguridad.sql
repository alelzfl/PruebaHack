CREATE DATABASE  IF NOT EXISTS `proyecto_seguridad` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `proyecto_seguridad`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: proyecto_seguridad
-- ------------------------------------------------------
-- Server version	8.0.46

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

-- Tabla delitos
DROP TABLE IF EXISTS `tbldelitos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldelitos` (
  `id_delito` int NOT NULL,
  `tipo` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_delito`),
  UNIQUE KEY `tipo` (`tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `tbldelitos` WRITE;
/*!40000 ALTER TABLE `tbldelitos` DISABLE KEYS */;
INSERT INTO `tbldelitos` VALUES (1,'Homicidio'),(2,'Feminicidio'),(3,'Lesiones'),(4,'Secuestro'),(5,'Extorsión'),(6,'Robo de vehículo'),(7,'Robo a casa habitación'),(8,'Robo a negocio'),(9,'Robo a transeúnte'),(10,'Violación'),(11,'Violencia familiar'),(12,'Fraude'),(13,'Narcomenudeo');
/*!40000 ALTER TABLE `tbldelitos` ENABLE KEYS */;
UNLOCK TABLES;

-- Tabla entidades

DROP TABLE IF EXISTS `tblentidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblentidades` (
  `id_entidad` int NOT NULL,
  `nombre` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_entidad`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `tblentidades` WRITE;
/*!40000 ALTER TABLE `tblentidades` DISABLE KEYS */;
INSERT INTO `tblentidades` VALUES (5,'Coahuila de Zaragoza');
/*!40000 ALTER TABLE `tblentidades` ENABLE KEYS */;
UNLOCK TABLES;

-- Tabla incidencias

DROP TABLE IF EXISTS `tblincidencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblincidencias` (
  `id_incidencia` int NOT NULL,
  `id_entidad` int NOT NULL,
  `id_delito` int NOT NULL,
  `anio` smallint NOT NULL,
  `total_casos` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_incidencia`),
  KEY `fk_inc_entidad` (`id_entidad`),
  KEY `fk_inc_delito` (`id_delito`),
  CONSTRAINT `fk_inc_delito` FOREIGN KEY (`id_delito`) REFERENCES `tbldelitos` (`id_delito`),
  CONSTRAINT `fk_inc_entidad` FOREIGN KEY (`id_entidad`) REFERENCES `tblentidades` (`id_entidad`),
  CONSTRAINT `tblincidencias_chk_1` CHECK ((`total_casos` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `tblincidencias` WRITE;
/*!40000 ALTER TABLE `tblincidencias` DISABLE KEYS */;
INSERT INTO `tblincidencias` VALUES (1,5,1,2023,100),(2,5,1,2024,95),(3,5,6,2023,200),(4,5,6,2024,180),(5,5,7,2023,150),(6,5,7,2024,140),(7,5,11,2023,300),(8,5,11,2024,320);
/*!40000 ALTER TABLE `tblincidencias` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `vw_reporte_incidencias`;
/*!50001 DROP VIEW IF EXISTS `vw_reporte_incidencias`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_reporte_incidencias` AS SELECT 
 1 AS `id_incidencia`,
 1 AS `entidad`,
 1 AS `delito`,
 1 AS `anio`,
 1 AS `total_casos`*/;
SET character_set_client = @saved_cs_client;

/*!50001 DROP VIEW IF EXISTS `vw_reporte_incidencias`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `vw_reporte_incidencias` AS select `i`.`id_incidencia` AS `id_incidencia`,`e`.`nombre` AS `entidad`,`d`.`tipo` AS `delito`,`i`.`anio` AS `anio`,`i`.`total_casos` AS `total_casos` from ((`tblincidencias` `i` join `tblentidades` `e` on((`e`.`id_entidad` = `i`.`id_entidad`))) join `tbldelitos` `d` on((`d`.`id_delito` = `i`.`id_delito`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;