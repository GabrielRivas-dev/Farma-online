-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: farmacia_online
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;

--
-- Table structure for table `carritos`
--

DROP TABLE IF EXISTS `carritos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carritos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint unsigned NOT NULL,
  `producto_id` bigint unsigned NOT NULL,
  `cantidad` int NOT NULL DEFAULT '1',
  `precio_unitario` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `carritos_usuario_id_producto_id_unique` (`usuario_id`,`producto_id`),
  KEY `carritos_usuario_id_index` (`usuario_id`),
  KEY `carritos_producto_id_index` (`producto_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carritos`
--

/*!40000 ALTER TABLE `carritos` DISABLE KEYS */;
INSERT INTO `carritos` VALUES (35,1,1,1,8.50,'2025-11-27 07:21:55','2025-11-27 07:21:55'),(55,21,2,2,5.50,'2026-02-17 00:37:31','2026-02-17 04:23:23'),(56,21,4,1,16.80,'2026-02-17 04:23:16','2026-02-17 17:43:21');
/*!40000 ALTER TABLE `carritos` ENABLE KEYS */;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Aseo Personal','aseo-personal','Productos de higiene y cuidado personal','2025-11-17 23:58:56','2025-11-17 23:58:56'),(2,'Medicamentos','medicamentos','Medicamentos de venta libre','2025-11-17 23:58:56','2025-11-17 23:58:56'),(3,'Cuidado Bebés','cuidado-bebes','Productos especializados para bebés','2025-11-17 23:58:56','2025-11-17 23:58:56'),(4,'Cuidado Piel','cuidado-piel','Cremas y cuidado dermatológico','2025-11-17 23:58:56','2025-11-17 23:58:56'),(5,'Vitaminas','vitaminas','Suplementos y vitaminas','2025-11-17 23:58:56','2025-11-17 23:58:56'),(6,'Primeros Auxilios','primeros-auxilios','Material de curación y emergencia','2025-11-17 23:58:56','2025-11-17 23:58:56'),(7,'Bebidas y Alimentos','bebidas-alimentos','Bebidas y alimentos básicos','2025-11-17 23:58:56','2026-01-09 18:05:26');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;

--
-- Table structure for table `conversations`
--

DROP TABLE IF EXISTS `conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conversations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_closed` tinyint(1) NOT NULL DEFAULT '0',
  `last_message_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conversations_user_id_foreign` (`user_id`),
  CONSTRAINT `conversations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversations`
--

/*!40000 ALTER TABLE `conversations` DISABLE KEYS */;
INSERT INTO `conversations` VALUES (1,10,'conexion',0,'2025-11-25 20:56:29','2025-11-25 19:15:54','2025-11-25 20:56:29'),(2,11,'ya sirve?',0,'2025-11-26 06:15:53','2025-11-26 06:15:53','2025-11-26 06:15:53');
/*!40000 ALTER TABLE `conversations` ENABLE KEYS */;

--
-- Table structure for table `favoritos`
--

DROP TABLE IF EXISTS `favoritos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favoritos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` int unsigned NOT NULL,
  `producto_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `favoritos_usuario_id_producto_id_unique` (`usuario_id`,`producto_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favoritos`
--

/*!40000 ALTER TABLE `favoritos` DISABLE KEYS */;
INSERT INTO `favoritos` VALUES (18,21,1,'2026-02-17 00:35:35','2026-02-17 00:35:35'),(20,21,2,'2026-02-17 00:58:09','2026-02-17 00:58:09');
/*!40000 ALTER TABLE `favoritos` ENABLE KEYS */;

--
-- Table structure for table `items_pedido`
--

DROP TABLE IF EXISTS `items_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_pedido` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pedido_id` int NOT NULL,
  `producto_id` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pedido_id` (`pedido_id`),
  KEY `producto_id` (`producto_id`),
  CONSTRAINT `items_pedido_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `items_pedido_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  CONSTRAINT `items_pedido_chk_1` CHECK ((`cantidad` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_pedido`
--

/*!40000 ALTER TABLE `items_pedido` DISABLE KEYS */;
INSERT INTO `items_pedido` VALUES (1,5,1,2,8.50,'2025-11-20 19:42:23'),(2,6,2,1,5.50,'2025-11-21 02:26:32'),(3,7,1,1,8.50,'2025-11-21 02:56:52'),(4,8,3,1,18.50,'2025-11-27 03:13:51'),(5,9,3,1,18.50,'2025-11-27 03:35:53'),(6,10,3,1,18.50,'2025-11-27 03:41:51'),(10,14,2,1,5.50,'2025-11-29 16:23:10'),(12,16,1,1,8.50,'2025-11-29 16:32:06'),(13,17,2,1,5.50,'2025-11-29 16:37:46'),(14,18,2,1,5.50,'2026-02-01 03:04:30');
/*!40000 ALTER TABLE `items_pedido` ENABLE KEYS */;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `conversation_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `messages_conversation_id_foreign` (`conversation_id`),
  KEY `messages_user_id_foreign` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,10,'conectividad',0,'2025-11-25 19:15:54','2025-11-25 19:15:54'),(2,1,10,'conecta',0,'2025-11-25 19:16:07','2025-11-25 19:16:07'),(3,1,10,'conectado',0,'2025-11-25 20:56:29','2025-11-25 20:56:29'),(4,2,11,'sirvio',0,'2025-11-26 06:15:53','2025-11-26 06:15:53');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (7,'0001_01_01_000000_create_users_table',1),(8,'0001_01_01_000001_create_cache_table',1),(9,'0001_01_01_000002_create_jobs_table',1),(10,'2025_11_18_153201_create_sessions_table',2),(11,'2025_11_18_180406_create_categorias_table',2),(12,'2025_11_18_180441_create_productos_table',2),(13,'2025_11_18_180514_create_pedidos_table',2),(14,'2025_11_18_180546_create_item_pedido_table',2),(17,'2025_11_18_180605_create_promociones_table',3),(20,'2025_11_19_024414_create_carritos_table',4),(22,'2025_11_22_195722_add_is_admin_to_users_table',5),(24,'2025_11_24_003726_add_direccion_telefono_to_users_table',6),(25,'2025_11_24_154151_create_favoritos_table',7),(26,'2025_11_24_154618_create_resenas_table',7),(27,'2025_11_25_142133_create_conversations_table',8),(28,'2025_11_25_142206_create_messages_table',8),(29,'2025_11_27_170635_create_password_resets_table',9),(32,'2025_11_27_192333_create_proveedores_table',10),(33,'2025_11_27_193034_create_movimientos_inventario_table',11),(34,'2025_11_27_193331_add_inventory_fields_to_productos_table',12),(35,'2025_12_09_132440_create_personal_access_tokens_table',13);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

--
-- Table structure for table `movimientos_inventario`
--

DROP TABLE IF EXISTS `movimientos_inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimientos_inventario` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `producto_id` bigint unsigned NOT NULL,
  `tipo` enum('entrada','salida','ajuste') COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` int NOT NULL,
  `stock_anterior` int NOT NULL,
  `stock_nuevo` int NOT NULL,
  `motivo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `usuario_id` bigint unsigned NOT NULL,
  `proveedor_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos_inventario`
--

/*!40000 ALTER TABLE `movimientos_inventario` DISABLE KEYS */;
INSERT INTO `movimientos_inventario` VALUES (1,6,'entrada',10,5,15,'compra',NULL,10,NULL,'2025-11-28 00:17:50','2025-11-28 00:17:50'),(2,6,'entrada',6,3,9,'compra',NULL,10,NULL,'2025-11-28 00:22:09','2025-11-28 00:22:09'),(3,6,'ajuste',6,9,6,'compra','d',10,NULL,'2025-11-28 00:22:44','2025-11-28 00:22:44'),(4,6,'entrada',4,6,10,'compra','compra',10,NULL,'2025-11-28 00:36:33','2025-11-28 00:36:33'),(5,7,'entrada',6,4,10,'compra','compra',10,NULL,'2025-11-28 00:36:51','2025-11-28 00:36:51'),(6,6,'entrada',4,6,10,'compra',NULL,10,NULL,'2025-11-29 05:25:18','2025-11-29 05:25:18'),(7,7,'entrada',1,9,10,'compra',NULL,10,NULL,'2025-11-29 05:25:26','2025-11-29 05:25:26'),(8,1,'entrada',20,46,66,'compra',NULL,21,NULL,'2026-01-10 22:31:35','2026-01-10 22:31:35');
/*!40000 ALTER TABLE `movimientos_inventario` ENABLE KEYS */;

--
-- Table structure for table `pagos`
--

DROP TABLE IF EXISTS `pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `pedido_id` bigint unsigned NOT NULL,
  `metodo_pago` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `referencia` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estado` enum('pendiente','verificado','rechazado') COLLATE utf8mb4_general_ci DEFAULT 'pendiente',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `banco` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos`
--

/*!40000 ALTER TABLE `pagos` DISABLE KEYS */;
INSERT INTO `pagos` VALUES (1,16,'pago_movil','1212','pendiente','2025-11-29 16:32:06','Banesco','0424',8.50,'2025-11-29 16:32:06'),(2,17,'pago_movil','1212','pendiente','2025-11-29 16:37:46','BDV','0424',5.50,'2025-11-29 16:37:46'),(3,18,'pago_movil','2589292','pendiente','2026-02-01 03:04:31','BDV','04245014816',5.50,'2026-02-01 03:04:31');
/*!40000 ALTER TABLE `pagos` ENABLE KEYS */;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
INSERT INTO `password_resets` VALUES ('favian@gmail.com','$2y$12$MrzdKGX.g9iKQxf0z0deqO4plkWWfIkq8TlRGv6oOUucsu9Ynh9rC','2025-11-27 22:57:17');
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint unsigned DEFAULT NULL,
  `numero_orden` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `estado` enum('pendiente','confirmado','enviado','entregado','cancelado') COLLATE utf8mb4_general_ci DEFAULT 'pendiente',
  `direccion_envio` text COLLATE utf8mb4_general_ci NOT NULL,
  `ciudad_envio` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `telefono_contacto` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `metodo_pago` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `metodo_pago_detalle` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `referencia_pago` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `banco` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telefono_pago` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `monto_pagado` decimal(10,2) DEFAULT NULL,
  `fecha_pago` timestamp NULL DEFAULT NULL,
  `estado_pago` enum('pendiente','verificado','rechazado') COLLATE utf8mb4_general_ci DEFAULT 'pendiente',
  `comprobante_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_orden` (`numero_orden`),
  KEY `pedidos_usuario_id_foreign` (`usuario_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (5,3,'ORD20251120F91EB7',17.00,'pendiente','Av. Reforma 456, Col. Centro','Ciudad de México','555-9876','efectivo','2025-11-20 23:42:23','2025-11-20 23:42:23',NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',NULL),(6,10,'ORD20251121881624',5.50,'pendiente','barinas','barinas','04245200575','efectivo','2025-11-21 06:26:32','2025-11-23 06:20:42',NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',NULL),(7,10,'ORD20251121423614',8.50,'confirmado','barinas','barinas','04245200575','efectivo','2025-11-21 06:56:52','2025-11-23 05:15:53',NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',NULL),(8,11,'ORD20251127F7371B',18.50,'pendiente','barinas','barinas','0273','efectivo','2025-11-27 07:13:51','2025-11-27 07:13:51',NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',NULL),(9,11,'ORD2025112790B557',18.50,'confirmado','zulia','zulia','04241212121','movil','2025-11-27 07:35:53','2026-01-10 22:21:45',NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',NULL),(10,11,'ORD20251127F0D294',18.50,'confirmado','zulia','zulia','04241212121','movil','2025-11-27 07:41:51','2025-11-27 19:19:02',NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',NULL),(14,10,'ORD20251129E4952C',5.50,'confirmado','barinas','barinas','04245200575','efectivo','2025-11-29 20:23:10','2025-11-29 20:23:10',NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',NULL),(16,10,'ORD202511296B2353',8.50,'cancelado','barinas','barinas','0424','pago_movil','2025-11-29 20:32:06','2025-11-29 20:34:34',NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',NULL),(17,10,'ORD20251129ACA8BB',5.50,'confirmado','barinas','barinas','0424','pago_movil','2025-11-29 20:37:46','2025-11-29 20:38:39',NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',NULL),(18,21,'ORD20260201E8C63F',5.50,'pendiente','llano alto','barinas','04245014816','pago_movil','2026-02-01 07:04:30','2026-02-01 07:04:30',NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',NULL);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_general_ci,
  `precio` decimal(10,2) NOT NULL,
  `precio_original` decimal(10,2) DEFAULT NULL,
  `stock` int DEFAULT '0',
  `imagen` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `categoria_id` int NOT NULL,
  `badge` enum('mas-vendido','oferta','nuevo','esencial') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `stock_minimo` int NOT NULL DEFAULT '10',
  `stock_maximo` int NOT NULL DEFAULT '100',
  `proveedor_id` bigint unsigned DEFAULT NULL,
  `costo` decimal(8,2) DEFAULT NULL,
  `alertar_stock_bajo` tinyint(1) NOT NULL DEFAULT '1',
  `ultima_reposicion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categoria_id` (`categoria_id`),
  KEY `productos_proveedor_id_foreign` (`proveedor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Aceite para bebé Johnson','Hidratación suave para la piel del bebé',8.50,NULL,66,'https://www.locatelonline.com/cdn/shop/files/900_92ab1100-3f7c-4408-86a4-5c008db0fea7_800x.jpg?v=1711148402',1,'esencial',1,'2025-11-17 23:58:57','2026-01-10 22:31:35',10,100,NULL,NULL,1,'2026-01-10 22:31:35'),(2,'Paracetamol 500mg','Alivia el dolor y reduce la fiebre',5.50,NULL,96,'http://coleccionlaintegral.com/integral/tienda/img/p/3/2/32-large_default.jpg',2,'mas-vendido',1,'2025-11-17 23:58:57','2026-02-01 07:04:30',10,100,NULL,NULL,1,NULL),(3,'Protector solar FPS 50','Protección alta contra rayos UV',18.50,NULL,32,'',4,'nuevo',0,'2025-11-17 23:58:57','2026-01-09 19:09:39',10,100,NULL,NULL,1,NULL),(4,'Complejo B','Suplemento de vitaminas del grupo B',16.80,NULL,65,'https://i.ebayimg.com/images/g/J~gAAOSwP6hdiMzM/s-l1600.webp',5,NULL,1,'2025-11-17 23:58:57','2026-01-09 18:55:13',10,100,NULL,NULL,1,NULL),(5,'Alcohol etílico 250ml','Antiséptico para limpieza de heridas',4.20,NULL,65,'https://lh3.googleusercontent.com/X8roIK1MKbhcjZiVc6vwWkuew-pF9QymEQdOf-Ghk5HjOo6XS2RaBH_ozOt7DoN42lvZlX_t8VVjHhf9JmXguFC5LDWm8wzVhCFSGVizaLa4BEw9sw',6,'esencial',1,'2025-11-17 23:58:57','2026-01-09 18:58:31',10,100,NULL,NULL,1,NULL),(6,'Coca cola','refresco',1.00,1.00,10,'https://212global.com/wp-content/uploads/2024/06/5f160a7925392f115e15968c_thumbnail-600x600.png',7,'oferta',1,'2025-11-23 08:40:53','2026-01-09 18:31:47',10,100,NULL,NULL,1,'2025-11-29 05:25:18'),(7,'algodon','algodon',2.00,2.00,10,'https://lh3.googleusercontent.com/HzAjbjarjHqvl4dOJ60xiXsji8zZjVLnCSQN3uuVBV__ujYuRpfsF2GOD7Ltl8eG57WHeDZd_tnI1z6R6Oq1FwHTY8NCtNxk8ipOQ29PLwAkTYnV',2,NULL,1,'2025-11-23 09:32:44','2026-01-09 18:59:20',10,100,NULL,NULL,1,'2025-11-29 05:25:26'),(9,'Jabón de Baño Neutro','Jabón suave para higiene diaria de toda la familia',3.50,NULL,50,'https://locatelvenezuela.vtexassets.com/arquivos/ids/168961-800-auto?v=637860658447770000&width=800&height=auto&aspect=true',1,NULL,1,'2025-11-28 15:57:19','2026-01-09 19:04:52',10,100,NULL,NULL,1,NULL),(10,'Shampoo Anticaspa','Control efectivo de caspa y picazón en el cuero cabelludo',8.00,NULL,30,'https://locatelvenezuela.vtexassets.com/arquivos/ids/169509-800-auto?v=637860660042000000&width=800&height=auto&aspect=true',1,NULL,1,'2025-11-28 15:57:19','2026-01-09 19:05:39',10,100,NULL,NULL,1,NULL),(11,'Desodorante Roll-On','Protección 48 horas contra el mal olor y la humedad',5.50,NULL,40,'https://locatelvenezuela.vtexassets.com/arquivos/ids/187518-800-auto?v=638778295064500000&width=800&height=auto&aspect=true',1,NULL,1,'2025-11-28 15:57:19','2026-01-09 19:06:14',10,100,NULL,NULL,1,NULL),(12,'Pasta Dental Blanqueadora','Protección contra caries y efecto blanqueador suave',4.20,NULL,60,'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/crr/crr51210/g/39.jpg',1,NULL,1,'2025-11-28 15:57:19','2026-01-09 18:52:35',10,100,NULL,NULL,1,NULL),(13,'Enjuague Bucal Anticaries','Protección completa y aliento fresco por horas',6.80,NULL,35,'https://images.ctfassets.net/jskpuycrg1jn/1OieKwEo2MHmDLUwsViawp/8f5f51a647edc875724187685e90d025/Listerine_anticaries_250ml_front_ALTPKG0.jpg?fm=webp&w=1024',1,NULL,1,'2025-11-28 15:57:19','2026-01-09 19:06:49',10,100,NULL,NULL,1,NULL),(14,'Ibuprofeno 400mg','Antiinflamatorio y analgésico para dolores musculares y de cabeza',6.80,NULL,25,'https://lh3.googleusercontent.com/ggmZ0OFr4YtQ2Ly-FC3w50uC_F8TSI9kMmfvmyfOPUDrf4ugVR-LeENfe0QyCNP-S1KgjHqILBAYj0rXEY5MNZkdhWHeDh6xHpDatzomK8t34XenFg',2,NULL,1,'2025-11-28 15:57:19','2026-01-09 19:07:38',10,100,NULL,NULL,1,NULL),(15,'Amoxicilina 500mg','Antibiótico de amplio espectro para infecciones bacterianas',12.50,NULL,15,'https://calox.com/wp-content/uploads/2025/11/amoxicilina-acido-clavulanico.webp',2,NULL,1,'2025-11-28 15:57:19','2026-01-09 19:08:30',10,100,NULL,NULL,1,NULL),(16,'Loratadina 10mg','Antihistamínico para alergias que no produce sueño',8.20,NULL,30,'https://calox.com/wp-content/uploads/2022/12/LORATADINA.jpg',2,NULL,1,'2025-11-28 15:57:19','2026-01-09 19:09:25',10,100,NULL,NULL,1,NULL),(17,'Omeprazol 20mg','Protector gástrico para acidez, reflujo y gastritis',9.50,NULL,40,'https://calox.com/wp-content/uploads/2025/11/Omeprazol-20x14-1.webp',2,NULL,1,'2025-11-28 15:57:19','2026-01-09 19:10:16',10,100,NULL,NULL,1,NULL),(18,'Diazepam 5mg','Ansiolítico para tratamiento de ansiedad e insomnio',15.00,NULL,10,NULL,2,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(19,'Pañales Talla 3','Pañales desechables ultra absorbentes para bebés',15.00,NULL,20,NULL,3,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(20,'Talco para Bebé','Polvo suave para prevenir irritaciones y rozaduras',4.20,NULL,35,NULL,3,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(21,'Toallitas Húmedas','Toallitas limpiadoras con aloe vera para bebé',5.80,NULL,50,NULL,3,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(22,'Shampoo Infantil','Shampoo suave sin lágrimas para cabello delicado',6.50,NULL,25,NULL,3,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(23,'Crema para Pañalitis','Previene y trata la dermatitis del pañal',8.80,NULL,30,NULL,3,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(24,'Crema Hidratante Facial','Hidratación profunda 24 horas para todo tipo de piel',12.00,NULL,30,NULL,4,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(25,'Gel Limpiador Facial','Limpieza suave diaria que no reseca la piel',9.80,NULL,40,NULL,4,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(26,'Crema Antiarrugas','Reducción visible de líneas de expresión y arrugas',25.00,NULL,15,NULL,4,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(27,'Jabón Líquido Corporal','Jabón nutritivo para piel sensible y delicada',7.50,NULL,60,NULL,4,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(29,'Vitamina C 1000mg','Refuerzo del sistema inmunológico y antioxidante',14.50,NULL,35,NULL,5,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(30,'Multivitamínico Completo','Suplemento con todas las vitaminas esenciales',22.00,NULL,20,NULL,5,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(31,'Vitamina D3 2000UI','Salud ósea y reforzamiento del sistema inmune',18.00,NULL,25,NULL,5,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(32,'Omega 3 1000mg','Ácidos grasos esenciales para salud cardiovascular',20.00,NULL,18,NULL,5,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(33,'Hierro 65mg','Combate la anemia, fatiga y mejora la energía',16.50,NULL,22,NULL,5,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(34,'Curitas Adhesivas','Curitas estériles para heridas pequeñas y cortes',3.50,NULL,100,NULL,6,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(35,'Vendas Elásticas','Vendas para esguinces, lesiones y soporte muscular',7.80,NULL,30,NULL,6,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(36,'Crema Antibiótica','Crema para prevenir infecciones en heridas',8.50,NULL,25,NULL,6,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(37,'Termómetro Digital','Termómetro preciso con lectura rápida en segundos',12.00,NULL,15,NULL,6,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(38,'Tijeras Medicinales','Tijeras seguras de punta roma para curaciones',6.20,NULL,20,NULL,6,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(39,'Agua Mineral 500ml','Agua purificada y mineralizada de manantial',1.20,NULL,80,NULL,7,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(40,'Jugo de Naranja Natural','Jugo 100% natural sin conservantes ni azúcar añadida',3.50,NULL,40,NULL,7,NULL,1,'2025-11-28 15:57:19','2025-11-28 15:57:19',10,100,NULL,NULL,1,NULL),(41,'Barra Energética','Snack nutritivo con proteínas para energía inmediata',2.80,NULL,60,'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/crr/crr51210/g/39.jpg',7,NULL,1,'2025-11-28 15:57:19','2026-01-09 18:53:04',10,100,NULL,NULL,1,NULL),(42,'Galletas Integrales','Galletas con fibra natural y bajo contenido de azúcar',4.20,NULL,45,'https://www.supermercadoseljamon.com/documents/10180/892067/19006178_G.jpg',7,NULL,1,'2025-11-28 15:57:19','2026-01-09 18:53:43',10,100,NULL,NULL,1,NULL),(43,'Té Verde Natural','Té antioxidante para digestión y bienestar general',5.50,NULL,35,'https://lh3.googleusercontent.com/vWo5xjcLAL8OKMYwRo6MMCZIIWwJ5fy9yGbXx6fe6kJUDvPhsF2pBqIY7UaQ4WoEVDwuSth-mdBBw09o92opUNtumxhZtwhqwuzxdvs-JrJo3gKe',7,NULL,1,'2025-11-28 15:57:19','2026-01-09 18:54:31',10,100,NULL,NULL,1,NULL),(47,'crema','dental',1.00,NULL,10,'https://locatelvenezuela.vtexassets.com/arquivos/ids/164975-800-auto?v=637750341133000000&width=800&height=auto&aspect=true',1,NULL,1,'2025-11-29 18:45:01','2026-01-08 01:48:03',10,100,NULL,NULL,1,NULL),(48,'Pepsi','bebida gaseaosa de 50ml',1.00,NULL,15,'https://www.diadeburgers.com/cdn/shop/products/pepsi_1_1024x1024.jpg?v=1606501800',7,NULL,1,'2026-01-07 18:40:37','2026-01-09 17:52:38',10,100,NULL,NULL,1,NULL);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;

--
-- Table structure for table `promociones`
--

DROP TABLE IF EXISTS `promociones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promociones` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `descuento_porcentaje` int DEFAULT NULL,
  `imagen` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promociones`
--

/*!40000 ALTER TABLE `promociones` DISABLE KEYS */;
INSERT INTO `promociones` VALUES (1,'Paracetamol 2x1','Llévate 2 Paracetamol y paga solo 1',50,'https://via.placeholder.com/80x80/4CAF50/white?text=2x1',1,'2025-11-01','2025-12-31','2025-11-21 00:53:20',NULL),(2,'Kit Primeros Auxilios','Todo lo esencial en un kit completo',30,'https://via.placeholder.com/80x80/2196F3/white?text=Kit',1,'2025-11-01','2025-12-15','2025-11-21 00:53:20',NULL),(3,'Vitaminas Esenciales','Complejo vitamínico mensual',25,'https://via.placeholder.com/80x80/FF9800/white?text=Vitaminas',1,'2025-11-10','2025-12-20','2025-11-21 00:53:20',NULL);
/*!40000 ALTER TABLE `promociones` ENABLE KEYS */;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contacto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` text COLLATE utf8mb4_unicode_ci,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `tiempo_entrega_dias` int NOT NULL DEFAULT '7',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (1,'Laboratorios Pfizer','Juan Pérez','123456789','contacto@pfizer.com','Av. Principal 123',1,7,'2025-11-27 20:43:42','2025-11-27 20:43:42'),(2,'Bayer Pharmaceuticals','María García','987654321','ventas@bayer.com','Calle Secundaria 456',1,5,'2025-11-27 20:43:42','2025-11-27 20:43:42'),(3,'Johnson & Johnson','Carlos López','555444333','info@johnson.com','Plaza Central 789',1,10,'2025-11-27 20:43:42','2025-11-27 20:43:42');
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;

--
-- Table structure for table `resenas`
--

DROP TABLE IF EXISTS `resenas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resenas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` int unsigned NOT NULL,
  `producto_id` int unsigned NOT NULL,
  `rating` int unsigned NOT NULL,
  `comentario` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resenas_usuario_id_producto_id_unique` (`usuario_id`,`producto_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resenas`
--

/*!40000 ALTER TABLE `resenas` DISABLE KEYS */;
INSERT INTO `resenas` VALUES (1,11,2,5,'buen producto','2025-11-24 23:26:20','2025-11-24 23:26:20'),(2,11,3,5,'k','2025-11-24 23:27:13','2025-11-24 23:27:13'),(3,21,6,5,'sabrosa','2026-02-17 00:40:08','2026-02-17 00:40:08');
/*!40000 ALTER TABLE `resenas` ENABLE KEYS */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('6gOpqzhozNVuuTnSvQ9IyUmrFVG3OlnaMvQVTuni',NULL,'127.0.0.1','PostmanRuntime/7.49.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoicndFZ1pCRERZZHFTbnhYR2l6cEUxRGEwbU1tVXlrNVg0aHF3VWlxbSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9zYW5jdHVtL2NzcmYtY29va2llIjtzOjU6InJvdXRlIjtzOjE5OiJzYW5jdHVtLmNzcmYtY29va2llIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1765289703),('HsymfksazwiIitKB9H8V6iPW7GhQwmasVeYQviBg',NULL,'::1','PostmanRuntime/7.49.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoibFltRXVRaDF4RWNubnZCRUU4aEJMUlhaRE1Db1lIcUVvWW9mVlo5ayI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9zYW5jdHVtL2NzcmYtY29va2llIjtzOjU6InJvdXRlIjtzOjE5OiJzYW5jdHVtLmNzcmYtY29va2llIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1765290773);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Maria Garcia','maria@test.com',NULL,NULL,NULL,'$2y$12$37e1tjO7nsgztVkwXgLbsufRDbT.I7OoU3eeUm6oc8CXiVN5unCqS',NULL,'2025-11-18 23:32:19','2025-11-18 23:32:19',0),(3,'Carlos Rodrígues','carlos.rodrigues@farmacia.com',NULL,NULL,NULL,'$2y$12$ziOIKAhIEYsPYXiTtq20I.taqvT2o2AXoydg7I6tpJjIBM1dqvqI6',NULL,'2025-11-20 23:22:17','2025-11-23 19:50:32',0),(7,'Ana Garcia','ana.garcia@farmacia.com',NULL,NULL,NULL,'$2y$12$YSr8nVgyvGWZ.DyeDP8d0enHy6vVTFncehDrBXlAiQMmRkmV88doC',NULL,'2025-11-21 02:54:37','2025-11-21 02:54:37',0),(9,'estefania montilla','esefania@gmail.com',NULL,NULL,NULL,'$2y$12$TZZY4/qAqYy8iWrMi0jEVORI3EERhJyrAyFz9jpSq174FbSQkPjBq',NULL,'2025-11-21 03:19:50','2025-11-25 03:54:05',0),(10,'faviana','faviana@gmail.com',NULL,NULL,NULL,'$2y$12$MQcunTnP7ioL9fTkZTRqceH0So4t17nbgKUFSwkJlG/SCjrw1Hvmm',NULL,'2025-11-21 03:23:20','2025-11-21 03:23:20',1),(11,'favian','favian@gmail.com','Zulia','04241212121',NULL,'$2y$12$vs2VGdhj3NYDR.wN71YR2ORRqbzm0/tsZ3wnENtUuID2mdPxsGN3q',NULL,'2025-11-23 00:30:52','2025-11-26 06:01:47',0),(16,'andres baptista','andres@gmail.com',NULL,NULL,NULL,'$2y$12$JcOhPApQoI2KxGLpy5PPQuKa3MdVA1NhJOFg0wD5KVGud3kbA.3HK',NULL,'2025-11-24 05:12:46','2025-11-24 05:12:46',0),(17,'andress baptista','andress@gmail.com',NULL,NULL,NULL,'$2y$12$h7e3Lt6WlWagt7GKU75eVunBqn6hvifZ7EMoIMwf38dECN4yRUt8u',NULL,'2025-11-24 05:15:17','2025-11-24 05:15:17',0),(18,'jose','jose@gmail.com','laraa','04241234567',NULL,'$2y$12$RSGRQT8Bi5uSCtZ/Vo80AOp96nXHIwSwZthkIsc1nlUrg1ZLKvaOK',NULL,'2025-11-25 04:42:04','2025-11-25 04:58:58',0),(19,'hibryd','hibryddwr@gmail.com','sucre','04242226658',NULL,'$2y$12$uEoYAtlDV95la78cUvtFtukf1CshHXdipFyp5XfPaV7cSjqy6Dc3W',NULL,'2025-11-27 22:48:11','2025-11-27 23:15:33',0),(20,'Faviann Velasquez','favb99@gmail.com','venezuela','04161111111',NULL,'$2y$12$MvLEIeFu1Ocas8MaVPuVOOs.jxaro5UGRI38EuSj4kb7r3g8Yo34G',NULL,'2025-12-07 06:12:40','2025-12-07 06:12:40',0),(21,'Gabriel Rivas','gaalex200@gmail.com','llano alto','04245014816',NULL,'$2y$12$HYkznlNUyCFbwBOWv/MuY.FPkSbdZlNphokG4EIMt.2DhGyq8qZOi',NULL,'2025-12-09 16:55:11','2025-12-09 16:55:11',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

--
-- Dumping routines for database 'farmacia_online'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-21 21:03:40
