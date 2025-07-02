-- Active: 1751481246000@@127.0.0.1@3307@mysql
CREATE DATABASE IF NOT EXISTS Examen;
USE Examen;

-- Elimina tablas en orden inverso para evitar conflictos con claves foráneas
DROP TABLE IF EXISTS `detalles_pedidos`;
DROP TABLE IF EXISTS `pedidos`;
DROP TABLE IF EXISTS `empleados`;
DROP TABLE IF EXISTS `producto_suc`;
DROP TABLE IF EXISTS `productos`;
DROP TABLE IF EXISTS `clientes`;
DROP TABLE IF EXISTS `sucursal`;
DROP TABLE IF EXISTS `municipio`;
DROP TABLE IF EXISTS `departamento`;
DROP TABLE IF EXISTS `pais`;
DROP TABLE IF EXISTS `empresa`;


CREATE TABLE `pais` (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` varchar(80) NOT NULL,
    UNIQUE KEY `pais_unique` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `departamento` (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` varchar(80) NOT NULL,
    `pais_id` INT DEFAULT NULL,
    KEY `departamento_pais_id` (`pais_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `departamento`
ADD CONSTRAINT `departamento_pais_id` FOREIGN KEY (`pais_id`) REFERENCES `pais`(`id`);


CREATE TABLE `municipio` (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` varchar(80) DEFAULT NULL,
    `depid` INT DEFAULT NULL,
    KEY `municipio_departamento_FK` (`depid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `municipio`
ADD CONSTRAINT `municipio_departamento_FK` FOREIGN KEY (`depid`) REFERENCES `departamento`(`id`);


CREATE TABLE `empresa` (
    `id` varchar(20) NOT NULL,
    `nombre` varchar(80) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `empresa_unique` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `sucursal` (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` varchar(80) NOT NULL,
    `direccion` varchar(80) DEFAULT NULL,
    `empresaid` varchar(20) DEFAULT NULL,
    `municipioid` INT DEFAULT NULL,
    KEY `sucursal_empresa_FK` (`empresaid`),
    KEY `sucursal_municipio_FK` (`municipioid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `sucursal`
ADD CONSTRAINT `sucursal_empresa_FK` FOREIGN KEY (`empresaid`) REFERENCES `empresa`(`id`),
ADD CONSTRAINT `sucursal_municipio_FK` FOREIGN KEY (`municipioid`) REFERENCES `municipio`(`id`);


CREATE TABLE `clientes` (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` varchar(80) DEFAULT NULL,
    `email` varchar(50) DEFAULT NULL,
    `telefono` varchar(15) DEFAULT NULL,
    `direccion` varchar(50) DEFAULT NULL,
    `fecha_registro` date DEFAULT NULL,
    `municipio_id` INT DEFAULT NULL,
    KEY `cliente_municipio_id` (`municipio_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `clientes`
ADD CONSTRAINT `cliente_municipio_id` FOREIGN KEY (`municipio_id`) REFERENCES `municipio`(`id`);


CREATE TABLE `productos` (
    `producto_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` varchar(80) DEFAULT NULL,
    `categoria` varchar(80) DEFAULT NULL,
    `precio` decimal(10,2) DEFAULT NULL,
    `stock` INT DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `producto_suc` (
    `productoid` INT NOT NULL,
    `sucursalid` INT NOT NULL,
    PRIMARY KEY (`productoid`,`sucursalid`),
    KEY `producto_suc_sucursal_FK` (`sucursalid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `producto_suc`
ADD CONSTRAINT `producto_suc_producto_FK` FOREIGN KEY (`productoid`) REFERENCES `productos`(`producto_id`),
ADD CONSTRAINT `producto_suc_sucursal_FK` FOREIGN KEY (`sucursalid`) REFERENCES `sucursal`(`id`);


CREATE TABLE `empleados` (
    `empleado_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` varchar(80) DEFAULT NULL,
    `puesto` varchar(50) DEFAULT NULL,
    `fecha_contratacion` date DEFAULT NULL,
    `salario` decimal(10,2) DEFAULT NULL,
    `sucursalid` INT DEFAULT NULL,
    KEY `empleados_sucursal_FK` (`sucursalid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `empleados`
ADD CONSTRAINT `empleados_sucursal_FK` FOREIGN KEY (`sucursalid`) REFERENCES `sucursal`(`id`);


CREATE TABLE `pedidos` (
    `pedido_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `cliente_id` INT DEFAULT NULL,
    `empleado_id` INT DEFAULT NULL,
    `fecha_pedido` date DEFAULT NULL,
    `estado` varchar(20) DEFAULT NULL,
    KEY `cliente_id` (`cliente_id`),
    KEY `empleado_id` (`empleado_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `pedidos`
ADD CONSTRAINT `pedidos_cliente_FK` FOREIGN KEY (`cliente_id`) REFERENCES `clientes`(`id`),
ADD CONSTRAINT `pedidos_empleado_FK` FOREIGN KEY (`empleado_id`) REFERENCES `empleados`(`empleado_id`);


CREATE TABLE `detalles_pedidos` (
    `detalle_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `pedido_id` INT DEFAULT NULL,
    `producto_id` INT DEFAULT NULL,
    `cantidad` INT DEFAULT NULL,
    `precio_unitario` decimal(10,2) DEFAULT NULL,
    `sucid` INT DEFAULT NULL,
    KEY `pedido_id` (`pedido_id`),
    KEY `detalles_pedidos_producto_suc_FK` (`producto_id`,`sucid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `detalles_pedidos`
ADD CONSTRAINT `detalles_pedidos_pedido_FK` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos`(`pedido_id`),
ADD CONSTRAINT `detalles_pedidos_producto_suc_FK` FOREIGN KEY (`producto_id`, `sucid`) REFERENCES `producto_suc`(`productoid`, `sucursalid`);
