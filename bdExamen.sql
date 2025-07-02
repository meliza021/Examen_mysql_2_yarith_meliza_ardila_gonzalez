
CREATE DATABASE IF NOT EXISTS Examen

USE Examen

SHOW TABLES

DROP TABLE IF EXISTS `clientes`;

DROP TABLE IF EXISTS `departamento`;

DROP TABLE IF EXISTS `detalles_pedidos`;

DROP TABLE IF EXISTS `empleados`;

DROP TABLE IF EXISTS `empresa`;

DROP TABLE IF EXISTS `municipio`;

DROP TABLE IF EXISTS `pais`;

DROP TABLE IF EXISTS `productos`;

DROP TABLE IF EXISTS `producto_suc`;

DROP TABLE IF EXISTS `pedidos`;

DROP TABLE IF EXISTS `sucursal`;

DROP TABLE IF EXISTS `producto_suc`;

DROP TABLE IF EXISTS `sucursal`;

DROP TABLE IF EXISTS `sucursal`;


CREATE TABLE `clientes` (
  `cliente_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `municipioid` INT DEFAULT NULL,
  PRIMARY KEY (`cliente_id`),
  UNIQUE KEY `email` (`email`),
  KEY `clientes_municipio_FK` (`municipioid`)
);ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `departamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `paisid` INT DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `departamento_pais_FK` (`paisid`)
);
CREATE TABLE `detalles_pedidos` (
  `detalle_id` INT NOT NULL AUTO_INCREMENT,
  `pedido_id` INT DEFAULT NULL,
  `producto_id` INT DEFAULT NULL,
  `cantidad` INT DEFAULT NULL,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  `sucid` INT DEFAULT NULL,
  PRIMARY KEY (`detalle_id`),
  KEY `pedido_id` (`pedido_id`),
  KEY `detalles_pedidos_producto_suc_FK` (`producto_id`,`sucid`)
);
CREATE TABLE `empleados` (
  `empleado_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) DEFAULT NULL,
  `puesto` varchar(50) DEFAULT NULL,
  `fecha_contratacion` date DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `sucursalid` INT DEFAULT NULL,
  PRIMARY KEY (`empleado_id`),
  KEY `empleados_sucursal_FK` (`sucursalid`)
);

CREATE TABLE `empresa` (
  `id` varchar(20) NOT NULL,
  `nombre` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `empresa_unique` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `municipio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) DEFAULT NULL,
  `depid` INT DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `municipio_departamento_FK` (`depid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pais_unique` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pedidos` (
  `pedido_id` INT NOT NULL AUTO_INCREMENT,
  `cliente_id` INT DEFAULT NULL,
  `empleado_id` INT DEFAULT NULL,
  `fecha_pedido` date DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`pedido_id`),
  KEY `cliente_id` (`cliente_id`),
  KEY `empleado_id` (`empleado_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `productos` (
  `producto_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) DEFAULT NULL,
  `categoria` varchar(80) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `stock` INT DEFAULT NULL,
  PRIMARY KEY (`producto_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE `producto_suc` (
  `productoid` INT NOT NULL,
  `sucursalid` INT NOT NULL,
  PRIMARY KEY (`productoid`,`sucursalid`),
  KEY `producto_suc_sucursal_FK` (`sucursalid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE `sucursal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `direccion` varchar(80) DEFAULT NULL,
  `empresaid` varchar(20) DEFAULT NULL,
  `municipioid` INT DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sucursal_empresa_FK` (`empresaid`),
  KEY `sucursal_municipio_FK` (`municipioid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;