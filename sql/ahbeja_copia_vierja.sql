-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-09-2015 a las 19:38:37
-- Versión del servidor: 5.6.24
-- Versión de PHP: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `ahbeja`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `accessLog`(IN `EmployedCode` VARCHAR(4), IN `IPADdress` VARCHAR(20), IN `Reason` VARCHAR(50))
    NO SQL
INSERT INTO `accesos_de_usuario`(
	`employedCode`, `dateOfAdmission`, 
	`IPAddress`, `reason`
) 
VALUES 
	(
		EmployedCode, CURRENT_TIME, IPADdress, 
		Reason
	)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `allCharges`()
    NO SQL
SELECT * FROM cargos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `allNevel`()
    READS SQL DATA
SELECT * from tblnevel$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `allRegisters`()
    READS SQL DATA
    SQL SECURITY INVOKER
SELECT 
	COUNT(accesos_de_usuario.employedCode) AS totalAccess,
    accesos_de_usuario.employedCode,
	empleados.P_Nombre, 
	empleados.P_Apellido
FROM 
	accesos_de_usuario 
	INNER JOIN empleados ON accesos_de_usuario.employedCode = empleados.CodEmpleado
    GROUP BY accesos_de_usuario.employedCode$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `employeesWithoutUser`()
    NO SQL
SELECT 
	CONCAT(
		empleados.P_Nombre, ' ', empleados.P_Apellido
	) AS name,
    empleados.CodEmpleado AS codeE
    FROM

    empleados
    WHERE empleados.CodEmpleado NOT IN
    (SELECT usuarios.codEmpleado
     FROM usuarios
     )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEmployed`()
    READS SQL DATA
SELECT * from usuarios$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertUser`(IN `users` VARCHAR(30), IN `pass` VARCHAR(256), IN `emplo` VARCHAR(4))
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'this procedure insert into usuarios a new user'
INSERT INTO usuarios(usuarios.userName, usuarios.password, usuarios.creationdate, usuarios.datemodified, usuarios.status, usuarios.codEmpleado, usuarios.log) VALUES
(users, pass, now(), now(), 1, emplo, 0)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostRelevantUsers`()
    READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'this procedure return 4 users relevants'
SELECT 
	CONCAT(
		empleados.P_Nombre, ' ', empleados.P_Apellido
	) AS name, 
	empleados.CodEmpleado as codeE, 
	(
		SELECT 
			cargos.nombreCargo 
		FROM 
			cargos 
		WHERE 
			cargos.cargoID = empleados.Cargo
	) AS office, 
	(
		SELECT 

			usuarios.log 
		FROM 
			usuarios 
		WHERE 
			usuarios.codEmpleado = codeE
	) AS log, 
	(
		SELECT 
			COUNT(*) 
		FROM 
			accesos_de_usuario 
		WHERE 
			accesos_de_usuario.employedCode = empleados.CodEmpleado
	) as total 
FROM 
	empleados 
WHERE 
	empleados.CodEmpleado = (
		SELECT 
			usuarios.codEmpleado 
		FROM 
			usuarios 
		WHERE 
			usuarios.codEmpleado = empleados.CodEmpleado
	) 
ORDER BY 
	total DESC 
LIMIT 
	5$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectAllEmployed`()
    READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'This procedure return all employed in the system'
SELECT 
	CONCAT(
		empleados.P_Nombre, ' ', empleados.P_Apellido
	) AS name, 
	CONCAT(
		empleados.P_Nombre, ' ', empleados.S_Nombre, 
		' ', empleados.P_Apellido, ' ', empleados.S_Apellido
	) AS nameC, 
	empleados.Sexo AS sex, 
	empleados.CodEmpleado AS codeE, 
	empleados.CorreoElectronico AS email, 
	empleados.Direccion AS direction, 
	empleados.NumIdentidad AS idCard, 
	empleados.Telefono AS phoneNumber, 
	empleados.FechaNacimiento AS birthDay, 
	(
		SELECT 
			cargos.nombreCargo 
		FROM 
			cargos 
		WHERE 
			cargos.cargoID = empleados.Cargo
	) AS office, 
	(
		SELECT 
			usuarios.log 
		FROM 
			usuarios 
		WHERE 
			usuarios.codEmpleado = codeE
	) AS log 
FROM 
	empleados$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectAllUser`(IN `user` VARCHAR(30), IN `pass` VARCHAR(8))
    READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'This procedure view all information about the user log'
SELECT 
	usuarios.status, 
	usuarios.log, 
	usuarios.codEmpleado, 
	usuarios.userName, 
	(
		SELECT 
			empleados.Cargo 
		FROM 
			empleados 
		where 
			empleados.CodEmpleado = usuarios.codEmpleado
	) AS codRole 
FROM 
	usuarios 
WHERE 
	usuarios.userName = user 
	AND usuarios.password = pass$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectAllUsers`()
    READS SQL DATA
    SQL SECURITY INVOKER
SELECT 
	CONCAT(
		empleados.P_Nombre, ' ', empleados.P_Apellido
	) AS name, 
	empleados.CodEmpleado as codeE, 
	(
		SELECT 
			cargos.nombreCargo 
		FROM 
			cargos 
		WHERE 
			cargos.cargoID = empleados.Cargo
	) AS office, 
	(
		SELECT 
			usuarios.log 
		FROM 
			usuarios 
		WHERE 
			usuarios.codEmpleado = codeE
	) AS log
FROM 
	empleados 
WHERE 
	empleados.CodEmpleado = (
		SELECT 
			usuarios.codEmpleado 
		FROM 
			usuarios 

		WHERE 
			usuarios.codEmpleado = empleados.CodEmpleado
	)
ORDER BY log DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectDataRecipe`(IN `codReceta` INT(11))
    NO SQL
SELECT receta_medica.CodReceta, 						consultas.codconsulta, consultas.fecha, medicos.firma 	  FROM receta_medica inner join (consultas inner join 	  medicos on consultas.codmedico = medicos.codmedico)       on receta_medica.codconsulta = consultas.codconsulta       WHERE receta_medica.CodReceta = codReceta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEmployed`(IN `users` VARCHAR(4))
    READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'This procedure return all referent the viewEmployed'
SELECT 
	CONCAT(
		empleados.P_Nombre, ' ', empleados.P_Apellido
	) AS name, 
	CONCAT(
		empleados.P_Nombre, ' ', empleados.S_Nombre, 
		' ', empleados.P_Apellido, ' ', empleados.S_Apellido
	) AS nameC, 
	empleados.Sexo AS sex, 
	empleados.CodEmpleado AS codeE, 
	empleados.CorreoElectronico AS email, 
	empleados.Direccion AS direction, 
	empleados.NumIdentidad AS idCard, 
	empleados.Telefono AS phoneNumber, 
	empleados.FechaNacimiento AS birthDay, 
	(
		SELECT 
			cargos.nombreCargo 
		FROM 
			cargos 
		WHERE 
			cargos.cargoID = empleados.Cargo
	) AS office 
FROM 
	empleados 
WHERE 
	empleados.CodEmpleado = users$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectUser`(IN `user1` VARCHAR(30))
    READS SQL DATA
SELECT usuarios.status,usuarios.log,usuarios.codEmpleado,usuarios.password,usuarios.userName,
(SELECT empleados.Cargo from empleados where empleados.CodEmpleado= usuarios.codEmpleado) As codRole
from 
usuarios
where 
usuarios.userName = user1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateLog`(IN `logs` INT(1), IN `cod` VARCHAR(4))
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'This procedure update the status in the table users'
UPDATE `usuarios`
    SET 
   `log`= logs
WHERE  
`usuarios`.`codEmpleado` = cod$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateStatus`(IN `codE` VARCHAR(30), IN `statu` INT(1))
    NO SQL
UPDATE 
	usuarios 
SET 
	usuarios.status = statu, usuarios.disablingdate = now()
WHERE 
	usuarios.codEmpleado = codE$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewUser`(IN `codeE` VARCHAR(4))
    READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'This procedure return all information about a user'
SELECT 
	usuarios.userName, 
	DATE(usuarios.creationdate) AS creationdate, 
	DATE(usuarios.datemodified) AS datemodified, 
	DATE(usuarios.disablingdate) AS disablingdate, 
	usuarios.status, 
	usuarios.log, 
	(
		SELECT 
			CONCAT(
				empleados.P_Nombre, ' ', empleados.S_Nombre, 
				' ', empleados.P_Apellido, ' ', empleados.S_Apellido
			) 
		FROM 
			empleados 
		WHERE 
			empleados.CodEmpleado = codeE
	) AS nameC 
FROM 
	usuarios 
WHERE 
	usuarios.codEmpleado = codeE$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `accesos_de_usuario`
--

CREATE TABLE IF NOT EXISTS `accesos_de_usuario` (
  `employedCode` varchar(4) NOT NULL,
  `dateOfAdmission` datetime NOT NULL,
  `IPAddress` varchar(20) NOT NULL,
  `departureTime` datetime NOT NULL,
  `reason` varchar(50) NOT NULL,
  `iden` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `accesos_de_usuario`
--

INSERT INTO `accesos_de_usuario` (`employedCode`, `dateOfAdmission`, `IPAddress`, `departureTime`, `reason`, `iden`) VALUES
('1', '2015-09-12 11:15:39', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 1),
('1', '2015-09-12 09:35:58', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 2),
('1', '2015-09-12 09:38:11', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 3),
('3', '2015-09-12 09:40:12', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 4),
('2', '2015-09-12 09:49:54', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 5),
('1', '2015-09-12 09:50:07', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 6),
('2', '2015-09-12 09:50:45', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 7),
('2', '2015-09-12 09:51:35', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 8),
('2', '2015-09-12 09:58:29', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 9),
('1', '2015-09-12 09:58:39', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 10),
('3', '2015-09-12 09:58:46', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 11),
('3', '2015-09-12 09:59:06', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 12),
('2', '2015-09-12 18:33:28', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 13),
('2', '2015-09-12 18:55:04', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 14),
('1', '2015-09-12 18:55:11', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 15),
('3', '2015-09-12 18:55:23', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 16),
('2', '2015-09-12 18:56:47', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 17),
('2', '2015-09-12 19:02:37', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 18),
('1', '2015-09-12 19:02:42', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 19),
('3', '2015-09-12 19:02:59', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 20),
('2', '2015-09-12 20:31:33', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 21),
('2', '2015-09-12 21:31:42', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 22),
('3', '2015-09-12 21:32:00', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 23),
('2', '2015-09-12 22:32:53', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 24),
('3', '2015-09-12 22:33:03', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 25),
('2', '2015-09-13 00:28:31', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 26),
('1', '2015-09-13 00:30:03', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 27),
('1', '2015-09-13 00:30:20', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 28),
('2', '2015-09-14 07:12:39', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 29),
('2', '2015-09-14 07:17:56', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 30),
('3', '2015-09-14 07:58:15', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 31),
('3', '2015-09-14 08:00:53', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 32),
('2', '2015-09-18 02:24:44', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 33),
('3', '2015-09-18 02:25:22', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 34),
('2', '2015-09-18 02:51:57', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 35),
('3', '2015-09-18 02:52:10', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 36),
('2', '2015-09-18 02:53:16', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 37),
('2', '2015-09-18 02:53:41', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 38),
('2', '2015-09-18 02:54:14', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 39),
('1', '2015-09-18 02:55:24', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 40),
('2', '2015-09-18 02:59:39', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 41),
('3', '2015-09-21 18:02:22', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 42),
('3', '2015-09-21 18:25:45', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 43),
('3', '2015-09-21 18:27:44', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 44);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `binnacle`
--

CREATE TABLE IF NOT EXISTS `binnacle` (
  `codBinnacle` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `codEmpleado` varchar(4) NOT NULL,
  `dateAction` datetime NOT NULL,
  `ipMachine` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargos`
--

CREATE TABLE IF NOT EXISTS `cargos` (
  `cargoID` int(11) NOT NULL,
  `nombreCargo` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cargos`
--

INSERT INTO `cargos` (`cargoID`, `nombreCargo`) VALUES
(1, 'Administrador'),
(2, 'Estudiante'),
(3, 'Maestro'),
(5, 'Recursos Humanos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE IF NOT EXISTS `empleados` (
  `CodEmpleado` int(4) NOT NULL,
  `NumIdentidad` varchar(13) NOT NULL,
  `P_Nombre` varchar(30) NOT NULL,
  `S_Nombre` varchar(30) DEFAULT NULL,
  `P_Apellido` varchar(30) NOT NULL,
  `S_Apellido` varchar(30) DEFAULT NULL,
  `Telefono` int(8) DEFAULT NULL,
  `movil` varchar(16) NOT NULL,
  `CorreoElectronico` varchar(100) DEFAULT NULL,
  `FechaNacimiento` datetime NOT NULL,
  `Sexo` varchar(1) NOT NULL,
  `Direccion` varchar(100) NOT NULL,
  `Cargo` int(11) NOT NULL,
  `codNivel` int(50) NOT NULL,
  `FotoPerfil` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=383 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`CodEmpleado`, `NumIdentidad`, `P_Nombre`, `S_Nombre`, `P_Apellido`, `S_Apellido`, `Telefono`, `movil`, `CorreoElectronico`, `FechaNacimiento`, `Sexo`, `Direccion`, `Cargo`, `codNivel`, `FotoPerfil`) VALUES
(1, '', 'Antoni', 'marc', 'Reyes', NULL, NULL, '', NULL, '1985-09-15 00:00:00', 'M', 'barcelona', 2, 0, ''),
(2, '', 'Irma', 'batoli', 'Gonzales', NULL, NULL, '', NULL, '1992-09-23 00:00:00', 'F', 'moreila', 3, 0, ''),
(3, '', 'Jonie', 'Miralda', 'Esteban', NULL, 232, '', NULL, '2015-09-15 00:00:00', 'M', '', 1, 0, ''),
(4, '', 'Melvin ', 'Ricardo', 'Nuñez', NULL, 223, '', 'mrmr@gmail.com', '1992-09-08 00:00:00', 'M', 'zorzales', 5, 0, ''),
(46, '', 'Fabio', '', 'Vasquez', '', 0, '9895-1625', 'fcvasco2003@yahoo.com', '2015-09-01 00:00:00', '0', '', 2, 6, ''),
(48, '', 'marta Elena', '', 'Mendoza Diaz', '', 0, '33349627', 'marta.e.mendoza@gmail.com', '2015-09-01 00:00:00', '0', '', 2, 1, ''),
(49, '', 'Maria', '', 'Perez Lopez', '', 800000, '220000', 'Perez', '2015-09-01 00:00:00', '0', '', 2, 1, ''),
(50, '', 'Angel Daniel', '', 'Garcia Sierra', '', 22555943, '88290429', 'adgs1999@gmail.com', '0000-00-00 00:00:00', '0', '', 2, 2, ''),
(51, '', 'Stephanie Elizabeth', '', 'Reyes Rodriguez', '', 2227, '3337-5003', 'histephy@hotmail.com', '2015-09-01 00:00:00', '0', '', 2, 13, ''),
(52, '', 'Kendy alexandra', '', 'Sanchez lozano', '', 22454275, '', 'sanchezkendy@hotmail.com', '1986-01-25 00:00:00', '0', '', 2, 3, ''),
(53, '', 'Francisco Jos&Atilde;&copy;', '', 'Mendoza', '', 22461229, '32460153', 'josebendavid77@gmail.com', '2015-09-02 00:00:00', '0', '', 2, 12, ''),
(54, '', 'Melissa Alejandra', '', 'Menjivar Cerrato', '', 22348100, '89377061', 'melissamenjivarc@gmail.com', '1995-08-21 00:00:00', '0', '', 2, 12, ''),
(55, '', 'Daniel Ernesto', '', 'Sierra Argueta', '', 22271153, '89553286', 'dsierraplantae@yahoo.com', '1990-09-23 00:00:00', '0', '', 2, 12, ''),
(56, '', 'Leonardo', '', 'Henriquez Alvares', '', 22387775, '99224710', 'leonardoandroid404@gmail.com', '1997-11-25 00:00:00', '0', '', 2, 14, ''),
(57, '', 'Alannis Itxel', '', 'Maradiaga Irias ', '', 22310743, '96840270', 'xbeyonddreams@hotmail.com', '1996-09-24 00:00:00', '0', '', 2, 2, ''),
(59, '', 'PAOLA MARIA ', '', 'MARTINEZ ALVARENGA', '', 22369497, '32034491', 'paomariam@gmail.com', '1988-09-21 00:00:00', '0', '', 2, 2, ''),
(60, '', 'Suyen ', '', 'Figueroa L&Atilde;&sup3;pez ', '', 0, '88393411', 'Lunnalopez@yahoo.com ', '1993-10-11 00:00:00', '0', '', 2, 1, ''),
(61, '', 'Gerlla ', '', 'Aragon Torres ', '', 22552567, '504-32765906', 'gerllaaragon@gmail.com', '2015-09-02 00:00:00', '0', '', 2, 5, ''),
(62, '', 'Nicolle Nilannethe', '', 'Guill&Atilde;&copy;n Alvarenga', '', 0, '32381951 y 99688', 'niconisasuke@hotmail.com', '1989-10-18 00:00:00', '0', '', 2, 12, ''),
(64, '', 'samira', '', 'lupiac', '', 32553998, '', 'salupiac@gmail.com', '1989-07-26 00:00:00', '0', '', 2, 6, ''),
(65, '', 'Flor Idalma', '', 'Escalon', '', 2225, '96020337', 'flories91@hotmail.com', '1991-10-30 00:00:00', '0', '', 2, 14, ''),
(67, '', 'Jazziel ElKanah&Atilde;&iexcl;', '', 'Baca Rodriguez', '', 22552359, '95194934', 'elkanahan@gmail.com', '2015-10-05 00:00:00', '0', '', 2, 2, ''),
(68, '', 'CLAUDIA PAOLA', '', 'GODOY AVILA', '', 22573205, '89746428', 'paolaavila2000@yahoo.com', '1979-12-12 00:00:00', '0', '', 2, 3, ''),
(69, '', 'Eduardo', '', 'Caffoll Lagos', '', 22306644, '95135621', 'caffoll_12@hotmail.com', '1997-11-11 00:00:00', '0', '', 2, 12, ''),
(70, '', 'Wenceslao', '', 'Bejarano Torres', '', 22332727, '99763825', 'bejarano_wen@hotmail.com', '1998-10-15 00:00:00', '0', '', 2, 4, ''),
(71, '', 'Ana ', '', 'Thompson', '', 22832588, '88008894', 'Anacthompsong@yahoo.com', '1998-09-29 00:00:00', '0', '', 2, 1, ''),
(74, '', 'Luis', '', 'Osorto', '', 0, '97851848', 'Kichigo53@hotmail.com', '1998-03-29 00:00:00', '0', '', 2, 1, ''),
(76, '', 'Dayan Mishell', '', 'Pichardo Lopez', '', 22454071, '95714846', 'mishell_pichardo@yahoo.com', '1986-07-07 00:00:00', '0', '', 2, 13, ''),
(77, '', 'Alvaro Felipe', '', 'Albornoz Perez', '', 22369848, '98858877', 'dr.alvaroalbornoz@gmail.com', '1973-11-19 00:00:00', '0', '', 2, 2, ''),
(79, '', 'Karim Naydalis', '', 'L&Atilde;&sup3;pez', '', 22344679, '95799968', 'naydalislopez@gmail.com', '1999-10-22 00:00:00', '0', '', 2, 5, ''),
(80, '', 'Jose Manuel ', '', 'Alvarado Gomez', '', 0, '98394648', 'ing.civil.alvarado@gmqil.com', '1984-09-05 00:00:00', '0', '', 2, 12, ''),
(81, '', 'Nadia Melissa', '', 'Cruz Elvir', '', 0, '94880510', 'ing.civil.nadiacruz@gmail.com', '1984-08-30 00:00:00', '0', '', 2, 12, ''),
(82, '', 'Karim Naydalis ', '', 'L&Atilde;&sup3;pez', '', 22344679, '95799968', 'naydalislopez@gmail.com', '1999-10-22 00:00:00', '0', '', 2, 2, ''),
(85, '', 'Carlos Jos&Atilde;&copy; ', '', 'Canales Almendares', '', 2228, '99181785', 'carlos_canales89@hotmail.com', '1989-03-25 00:00:00', '0', '', 2, 2, ''),
(86, '', 'Josselyn Mayt&Atilde;&copy;', '', 'Mej&Atilde;&shy;a Fern&Atilde;', '', 2255, '9576-3548', 'carlos_canales89@hotmail.com', '1992-04-03 00:00:00', '0', '', 2, 2, ''),
(87, '', 'Alberto Josu&Atilde;&copy;', '', 'Ponce Barrientos', '', 0, '9976 2931', 'apcreativo86@gmail.com', '1986-11-03 00:00:00', '0', '', 2, 4, ''),
(88, '', 'Melania ', '', 'Discua', '', 0, '95288700', 'mdiscua@gmail.com', '1990-09-01 00:00:00', '0', '', 2, 14, ''),
(89, '', 'katerin Sarai', '', 'Lagos Maradiaga', '', 22308430, '88852269', 'katita_lagos@hotmail.com', '1993-04-01 00:00:00', '0', '', 2, 1, ''),
(90, '', 'Angelica ', '', 'Echeverria', '', 22292024, '96995424', 'angiclau12@yahoo.com', '1998-05-15 00:00:00', '0', '', 2, 4, ''),
(92, '', 'Ana', '', 'Thompson G&Atilde;&iexcl;lvez', '', 22832588, '88008894', 'Anacthompsong@yahoo.com', '1998-07-29 00:00:00', '0', '', 2, 2, ''),
(94, '', 'Jorge', '', 'Guerrero', '', 0, '98839025', 'Jorgeguerrerof@yahoo.com', '1998-02-17 00:00:00', '0', '', 2, 1, ''),
(95, '', 'Yesica Dioxana ', '', 'Lanza Rodriguez', '', 0, '', 'dioxa305@yahoo.com', '1986-05-30 00:00:00', '0', '', 2, 1, ''),
(96, '', 'Ana Carolina', '', 'Vindel Rojas', '', 0, '32753181', 'av_anine@hotmail.es', '2015-09-06 00:00:00', '0', '', 2, 5, ''),
(97, '', 'Katherine Steffyn', '', 'Hernandez Nu&Atilde;&plusmn;ez', '', 22136397, '31707815', 'kshernandez90@gmail.com', '1990-07-25 00:00:00', '0', '', 2, 4, ''),
(99, '', 'Katherine Nicolle', '', 'Aguilar Lopez', '', 22570541, '88839086', 'nicolle.aguilar@hotmail.com', '1997-03-09 00:00:00', '0', '', 2, 5, ''),
(100, '', 'Ana Marcela ', '', 'Lanza Sandres', '', 27790417, '31909930', 'ana.march08@gmail.com', '1991-01-08 00:00:00', '0', '', 2, 4, ''),
(101, '', 'Luis', '', 'Turcios L&Atilde;&sup3;pez', '', 0, '96252654', 'luis_td_tpp@hotmail.com', '1993-08-01 00:00:00', '0', '', 2, 2, ''),
(102, '', 'Nicholle', '', 'Maradiaga Sikaffy', '', 22556569, '33330191', 'nature_freako@hotmail.com', '1991-08-28 00:00:00', '0', '', 2, 7, ''),
(103, '', 'Yesica Dioxana', '', 'Lanza Rodriguez', '', 0, '95270254', 'dioxa305@yahoo.com', '0000-00-00 00:00:00', '0', '', 2, 4, ''),
(104, '', 'Aaron Josue', '', 'Mej&Atilde;&shy;a Salinas', '', 22358670, '31915380', 'Slifer.inc@gmail.com', '1988-02-26 00:00:00', '0', '', 2, 4, ''),
(105, '', 'Alexandra ', '', 'Tabora Chavarria', '', 22265754, '89152454', 'amtabora@gmail.com', '1989-04-20 00:00:00', '0', '', 2, 4, ''),
(106, '', 'Alejandra Noemi', '', 'L&Atilde;&sup3;pez Bulnes', '', 22293275, '32471852', 'alelobu@yahoo.com', '1986-09-14 00:00:00', '0', '', 2, 3, ''),
(107, '', 'Elmer Misael', '', 'Aguilar Perdomo', '', 22293026, '33415629', 'misa_aguilar@yahoo.es', '1986-01-25 00:00:00', '0', '', 2, 3, ''),
(108, '', 'Jessyca Prady', '', 'Velasquez Paguada', '', 22216269, '32750954', 'jessyprady@gmail.com', '1986-09-13 00:00:00', '0', '', 2, 2, ''),
(109, '', 'Rina Damaris', '', 'Zuniga Castillo', '', 0, '33738376', 'rinzuncas@gmail.com', '1989-09-19 00:00:00', '0', '', 2, 4, ''),
(112, '', 'Emily Andrea', '', 'Meza Trejo', '', 22462734, '97898846', 'emilyan96@hotmail.com', '1996-05-16 00:00:00', '0', '', 2, 2, ''),
(113, '', 'Fabio Lenin', '', 'Tabora  Castillo ', '', 22289364, '97810303', 'fltc9933@gmail.com ', '1999-11-05 00:00:00', '0', '', 2, 12, ''),
(115, '', 'Jefry Ariel', '', 'Avila Ardon', '', 0, '97976668', 'jefry.avila@unah.hn', '1996-04-23 00:00:00', '0', '', 2, 5, ''),
(117, '', 'Allan Mauricio Alvarado Duarte', '', 'Alvarado Duarte', '', 22442470, '99161670', 'allan.alvarado@gmail.com', '1977-08-24 00:00:00', '0', '', 2, 2, ''),
(118, '', 'Marcelo Fabricio', '', 'Lopez Cubas', '', 22308287, '89678704', 'marcelolpz15@gmail.com', '1996-07-30 00:00:00', '0', '', 2, 14, ''),
(119, '', 'Mauricio Enrique', '', 'Alvarenga Espinal', '', 22344940, '96260119', 'neopwngaming@gmail.com', '1996-12-14 00:00:00', '0', '', 2, 5, ''),
(120, '', 'Ernesto', '', 'Gonzalez Torres', '', 2255, '9747-7945', 'ernesto_gonzalez_torres@hotmail.com', '1995-11-07 00:00:00', '0', '', 2, 7, ''),
(121, '', 'Nilsee Alejandra', '', 'Cardona D&Atilde;&shy;az', '', 22708205, '32208093', 'nilsee1994@yahoo.com', '1994-09-09 00:00:00', '0', '', 2, 4, ''),
(122, '', 'Francisco', '', 'Maradiaga Martinez', '', 0, '33038950', 'fjmaradiaga@icloud.com', '1980-10-02 00:00:00', '0', '', 2, 6, ''),
(123, '', 'Gerlla', '', 'Aragon Torres ', '', 22552567, '32765906', 'gerllaaragon@gmail.com', '2015-09-05 00:00:00', '0', '', 2, 5, ''),
(125, '', 'Olga Maripaz', '', 'Acosta Hernandez', '', 22332591, '96630627', 'ninapalmas@hotmail.com', '1994-12-04 00:00:00', '0', '', 2, 6, ''),
(126, '', 'Dennis Alejandro', '', 'Aguilar Romero', '', 0, '99852467', 'dennisaguilariv@gmail.com', '1991-02-07 00:00:00', '0', '', 2, 12, ''),
(127, '', 'Yury Rodolfo', '', 'Reyes Cruz', '', 22368594, '33079768', 'yuryreyes@agrolibano.com', '1981-12-17 00:00:00', '0', '', 2, 2, ''),
(128, '', 'Diana Maricel', '', 'Reyes Cruz', '', 22368594, '32311620', 'mariceldiana@yahoo.com', '2015-09-06 00:00:00', '0', '', 2, 2, ''),
(129, '', 'Marcela Alejandra', '', 'Mac&Atilde;&shy;as moncada', '', 0, '32369540', 'pink_052013@hotmail.com', '1991-01-05 00:00:00', '0', '', 2, 2, ''),
(130, '', 'Jenny Claudeth', '', 'Barahona Andino', '', 0, '3365-6334', 'jclaudeth@gmail.com', '1988-04-13 00:00:00', '0', '', 2, 7, ''),
(133, '', 'Amy Carolina', '', 'Mejia Alvarado', '', 22305995, '89833769', 'amy2008cm@yahoo.com', '1998-08-09 00:00:00', '0', '', 2, 5, ''),
(134, '', 'Carlos', '', 'Bustillo Hernandez', '', 0, '31883059', 'shin_getsu@outlook.com', '1993-01-01 00:00:00', '0', '', 2, 13, ''),
(135, '', 'axell', '', 'Figueroa Cerrato', '', 22553256, '33292172', 'axficerrato95@gmail.com', '1995-08-30 00:00:00', '0', '', 2, 1, ''),
(136, '', 'Carmen Beatriz', '', 'Zuniga ', '', 2212186, '31642270', 'cvz_beatriz@yahoo.com', '1991-02-09 00:00:00', '0', '', 2, 3, ''),
(137, '', 'karen lineth ', '', 'hernandez ciliezar ', '', 22236454, '96327033', 'karen_ciliezar@hotmail.com', '0000-00-00 00:00:00', '0', '', 2, 4, ''),
(138, '', 'Ambar Dessire', '', 'Cortes Ordo&Atilde;&plusmn;ez', '', 0, '31796669', 'adessire.c@gmail.com', '1994-04-08 00:00:00', '0', '', 2, 4, ''),
(139, '', 'renan antonio', '', 'hernandez ciliezar', '', 22236454, '97357470', 'renan_antonio2011@hotmail.com', '0000-00-00 00:00:00', '0', '', 2, 4, ''),
(140, '', 'Patricia ', '', 'Barahona Cortes', '', 0, '87792824', 'patbarahonacortes@gmail.com', '1995-02-23 00:00:00', '0', '', 2, 4, ''),
(141, '', 'Irania Sujey', '', 'Hernandez Zepeda', '', 2227, '95186295 / 31726', 'iraniasujey95@hotmail.com', '1995-06-14 00:00:00', '0', '', 2, 1, ''),
(142, '', 'Laura Luc&Atilde;&shy;a', '', 'Valladares Canales', '', 22304455, '33008772', 'lauralvcanales725@gmail.com', '1996-04-17 00:00:00', '0', '', 2, 3, ''),
(143, '', 'Ariel Fernando', '', 'Villatoro Solorzano', '', 2230, '8751-3264', 'arielitovs@yahoo.com', '1997-04-19 00:00:00', '0', '', 2, 1, ''),
(144, '', 'Carlos Eduardo ', '', 'Barahona Talavera ', '', 0, '3225-0242 ', 'KrlosOblivion@hotmail.com ', '1986-01-07 00:00:00', '0', '', 2, 5, ''),
(145, '', 'Jocs&Atilde;&iexcl;n Ariel', '', 'Hern&Atilde;&iexcl;ndez Baraho', '', 22277433, '97870884', 'jocsan.hernndez@yahoo.com', '1993-10-22 00:00:00', '0', '', 2, 14, ''),
(146, '', 'JASMIN SAHABI', '', 'GIRON AGUILAR', '', 0, '88878304', '', '2000-07-30 00:00:00', '0', '', 2, 1, ''),
(148, '', 'Kevin Daniel', '', 'Silva Qui&Atilde;&plusmn;onez', '', 99305218, '99305218', 'kvnds1989@gmail.com', '1989-08-31 00:00:00', '0', '', 2, 4, ''),
(149, '', 'Kevin Josue', '', 'Arriaza Amador', '', 22252829, '96159976', 'josue79a@hotmail.com', '1993-05-02 00:00:00', '0', '', 2, 5, ''),
(150, '', 'In&Atilde;&copy;s Mariela', '', 'Rodas Lagos', '', 2230, '3384 8166', 'rodaslagos@gmail.com', '1990-07-18 00:00:00', '0', '', 2, 6, ''),
(152, '', 'NORLAN MODESTO', '', 'RAMIREZ MATAMOROS', '', 2233, '95789063', 'norlanramirez12@gmail.com', '2015-09-07 00:00:00', '0', '', 2, 7, ''),
(153, '', 'Samaria ', '', 'C&Atilde;&iexcl;rcamo', '', 22243417, '97904894', 'samariacarcamo@hotmail.com', '1991-06-22 00:00:00', '0', '', 2, 2, ''),
(154, '', 'Keren Ester', '', 'Yanes Casco', '', 0, '32781726', 'ke_yanes@hotmail', '1993-08-17 00:00:00', '0', '', 2, 14, ''),
(155, '', 'Christian Geovanny', '', 'L&Atilde;&sup3;pez Flores', '', 2228, '9665-7407', 'christianlopez6@hotmail.com', '1993-05-17 00:00:00', '0', '', 2, 14, ''),
(157, '', 'Fermin Ernesto', '', 'Quant Miranda', '', 0, '94781140', 'ferminquant@hotmail.com', '1987-12-29 00:00:00', '0', '', 2, 5, ''),
(158, '', 'Gabriela Elizabeth', '', 'Menocal Cover', '', 0, '98279181', 'gabrielamenocal@yahoo.com', '1989-11-02 00:00:00', '0', '', 2, 5, ''),
(159, '', 'Mari Luz Salazar &Atilde;lvar', '', 'Salazar &Atilde;lvarez', '', 22213209, '33064543', 'mluz.salazar@yahoo.com', '1979-12-26 00:00:00', '0', '', 2, 6, ''),
(160, '', 'Eber David Salazar &Atilde;lv', '', 'Salazar &Atilde;lvarez', '', 22213209, '95128534', 'salazared89@gmail.com', '1989-03-28 00:00:00', '0', '', 2, 6, ''),
(161, '', 'Heidy Elizabeth', '', 'N&Atilde;&ordm;&Atilde;&plusmn', '', 22462608, '33168660', 'hely20151003280@gmail.com', '1997-03-15 00:00:00', '0', '', 2, 5, ''),
(162, '', 'Nahum Caleb', '', 'Garc&Atilde;&shy;a Urbina', '', 22307931, '96168280', 'ngcu17@gmail.com', '1997-07-25 00:00:00', '0', '', 2, 2, ''),
(164, '', 'Nadia Melissa', '', 'Cruz Elvir', '', 0, '94880510', 'ing.civil.nadiacruz@gmail.com', '1984-08-30 00:00:00', '0', '', 2, 12, ''),
(165, '', 'Michelle Alessandra', '', 'Valladares Duarte', '', 22712077, '94700471', 'mialevalladares_97@hotmail.com', '1997-04-21 00:00:00', '0', '', 2, 5, ''),
(166, '', 'Andrea Celeste', '', 'Reyes Rivas', '', 22342797, '32470916', 'nya2ne7@yahoo.es', '1998-10-27 00:00:00', '0', '', 2, 4, ''),
(167, '', 'Ricardo ', '', 'Pineda Mejia', '', 22330871, '87340311', 'ricardopin@hotmail.com', '1991-09-23 00:00:00', '0', '', 2, 11, ''),
(168, '', 'Karen Waldina', '', 'Lagos B&Atilde;&ordm;', '', 2255, '9841-4933', 'kwlb84@gmail.com', '2015-09-07 00:00:00', '0', '', 2, 14, ''),
(169, '', 'Leonardo Alonso', '', 'Silva Vasquez', '', 22381479, '99158516', 'lasv.235@gmail.com', '2015-09-07 00:00:00', '0', '', 2, 3, ''),
(170, '', 'Bianca', '', 'Canales', '', 22255609, '98387559', 'bianca. canales@hotmail.com', '1988-09-02 00:00:00', '0', '', 2, 14, ''),
(172, '', 'Oscar Alexander', '', 'Melgar Ortiz', '', 2257, '3288-8838', 'kkandram@yahoo.es', '1995-11-21 00:00:00', '0', '', 2, 14, ''),
(173, '', 'Miguel Angel', '', 'Godoy Gomez', '', 22307050, '33952010', 'mikey89angel@gmail.com', '1989-02-27 00:00:00', '0', '', 2, 3, ''),
(174, '', 'Juan', '', 'Medina Merlo', '', 0, '95980117', 'jmed1290@hotmail.com', '1990-09-07 00:00:00', '0', '', 2, 1, ''),
(176, '', 'Scarleth Julissa', '', 'Rodriguez Perez', '', 2201, '9516-4914', 'rodriguez.rocks53@yahoo.es', '0000-00-00 00:00:00', '0', '', 2, 2, ''),
(177, '', 'Luis Andres', '', 'Ramirez Cruz', '', 22301887, '97800018', 'lram08@yahoo.es', '1991-08-22 00:00:00', '0', '', 2, 12, ''),
(178, '', 'Alejandra noemi', '', 'L&Atilde;&sup3;pez bulnes', '', 0, '32471852', 'alelobu@yahoo.com', '1986-09-14 00:00:00', '0', '', 2, 3, ''),
(179, '', 'Ixchel Atenea', '', 'Portillo David', '', 22275911, '97602609', 'ixatenea@yahoo.com', '1998-10-14 00:00:00', '0', '', 2, 7, ''),
(180, '', 'Claudia Isela', '', 'Padilla Cerrato', '', 22466942, '89682213', 'iselapadilla88@gmail.com', '1985-04-11 00:00:00', '0', '', 2, 4, ''),
(181, '', 'Sergio Tulio', '', 'D&Atilde;&shy;az Orellana', '', 2231, '9982 9549', 'diazing_4985@yahoo.es', '2015-09-07 00:00:00', '0', '', 2, 5, ''),
(182, '', 'Rosario Antonia', '', 'Valladares Rodr&Atilde;&shy;gu', '', 2231, '9985 0949', 'rosario.valladares@hotmail.com', '2015-09-07 00:00:00', '0', '', 2, 5, ''),
(183, '', 'Sergio Tulio', '', 'D&Atilde;&shy;az Orellana', '', 2231, '9982 9549', 'diazing_4985@yahoo.es', '2015-09-07 00:00:00', '0', '', 2, 5, ''),
(184, '', 'Rosario Antonia', '', 'Valladares Rodriguez', '', 2231, '9982 9549', 'rosario.valladares@hotmail.com', '2015-09-07 00:00:00', '0', '', 2, 7, ''),
(185, '', 'Cinthia Mabela', '', 'Mejia Torres', '', 22392632, '96199234', 'cynthiamabelak@gmail.com', '1988-11-01 00:00:00', '0', '', 2, 2, ''),
(187, '', 'Roberto Andres', '', 'Alvarez Veroy', '', 22118766, '96920582', 'roberandres.alvarez@gmail.com', '1988-04-11 00:00:00', '0', '', 2, 6, ''),
(188, '', 'Katerin Mariela', '', 'Aguilar Veroy', '', 22266207, '32672424', 'mariela209414@hotmail.com', '1994-09-20 00:00:00', '0', '', 2, 5, ''),
(189, '', 'Ernesto', '', 'Gonzalez Torres', '', 2255, '9747-7945', 'ernesto_gonzalez_torres@hotmail.com', '1995-11-07 00:00:00', '0', '', 2, 7, ''),
(190, '', 'Randall Giovany', '', 'Aguilar Veroy', '', 22266207, '87391401', 'randallaguilar55@yahoo.es', '1999-11-17 00:00:00', '0', '', 2, 5, ''),
(191, '', 'Jose Erick', '', 'Barahona Garcia', '', 0, '33553961', 'Erick22_barahona@unitec.edu', '2015-09-07 00:00:00', '0', '', 2, 5, ''),
(192, '', 'No&Atilde;&copy; Alejandro', '', 'Alvarez Rodriguez', '', 22293423, '', 'noealejandro_alvarez@hotmail.com', '1998-03-26 00:00:00', '0', '', 2, 12, ''),
(193, '', 'Erly Mauricio ', '', 'Hern&Atilde;&iexcl;ndez Ramos', '', 0, '89041558', 'erlyhaz@gmail.com', '1994-05-18 00:00:00', '0', '', 2, 4, ''),
(195, '', 'Oscar Sebastian', '', 'Rivera Lagos', '', 0, '98602113', 'oskr88746@gmail.com', '1999-04-07 00:00:00', '0', '', 2, 7, ''),
(196, '', 'Amy Jannelore', '', 'Rodriguez Montalvan', '', 22283188, '88825313', 'amyjro16@gmail.com', '1996-09-14 00:00:00', '0', '', 2, 4, ''),
(197, '', 'Roger Misael', '', 'Barrientos Navas', '', 22462977, '99453037', 'elzx92@gmail.com', '1992-06-05 00:00:00', '0', '', 2, 1, ''),
(198, '', 'Jenny Rosibel', '', 'Moreno Morales', '', 22206731, '31758985', 'jennymore0510@gmail.com', '1987-05-10 00:00:00', '0', '', 2, 6, ''),
(199, '', 'Jos&Atilde;&copy; Eduardo', '', 'Maradiaga Bonilla', '', 22570043, '98460172', 'jose_maradiaga23@hotmail.com', '1997-05-23 00:00:00', '0', '', 2, 4, ''),
(200, '', 'Erly Mauricio', '', 'Hernandez Ramos', '', 0, '89041558', 'erlyhaz@gmail.com', '1995-05-18 00:00:00', '0', '', 2, 4, ''),
(201, '', 'Amy Jannelore ', '', 'Rodriguez Montalvan', '', 22283188, '88825313', 'amyjro16@gmail.com', '1996-09-14 00:00:00', '0', '', 2, 4, ''),
(202, '', 'Ariana Melissa', '', 'Alvarado Rivera', '', 2245, '9952-5840', 'arianaalvrado@gmail.com', '2000-02-17 00:00:00', '0', '', 2, 12, ''),
(203, '', 'Mauricio Noe', '', 'Alvarado Rivera', '', 2245, '9697-1684', 'mauricioalvaradorivera@gmail.com', '1997-02-28 00:00:00', '0', '', 2, 12, ''),
(206, '', 'Omar', '', 'Cacho', '', 22454605, '87914300', 'oscaromarcacho@yahoo.es', '0000-00-00 00:00:00', '0', '', 2, 1, ''),
(207, '', 'Flor Idalma', '', 'Escalon', '', 2225, '96020337', 'flories91@hotmail.com', '1991-10-30 00:00:00', '0', '', 2, 14, ''),
(208, '', 'Victor Manuel', '', 'Recarte Garcia', '', 22381569, '33922284', 'victor@unah.edu.hn', '1980-08-14 00:00:00', '0', '', 2, 3, ''),
(209, '', 'Alfonso jose', '', 'Cotarelo Archaga', '', 22708109, '32439471', 'cota6si@gmail.com', '2015-09-07 00:00:00', '0', '', 2, 6, ''),
(210, '', 'Adela maria ', '', 'cotarelo archaga', '', 22708109, '33771560', 'cotarelokirigiri@gmail.com', '1998-08-20 00:00:00', '0', '', 2, 6, ''),
(212, '', 'Jonie', '', 'Miralda', '', 95069826, '22233944', 'jonie.miralda@unah.edu', '1991-09-30 00:00:00', '0', '', 2, 1, ''),
(213, '', 'Freddy Enrique', '', 'Flores Garcia', '', 22299089, '89549966', 'fredflores1993@gmail.com', '1993-04-30 00:00:00', '0', '', 2, 5, ''),
(214, '', 'Oscar Eduardo', '', 'Gonez Rivera', '', 22348149, '97355146', 'oscare.gomezr@unitec.edu', '1995-02-01 00:00:00', '0', '', 2, 3, ''),
(216, '', 'Fausto Fernando', '', 'Hernandez Rivera', '', 22260259, '95527122', 'faustoanime123@gmail.com', '1999-01-08 00:00:00', '0', '', 2, 7, ''),
(217, '', 'Ariana Paola', '', 'Fuentes Martinez', '', 22298375, '95004635', 'paola0845@gmail.com', '1996-08-04 00:00:00', '0', '', 2, 5, ''),
(218, '', 'Eduardo Josue', '', 'Yanez Gonzales', '', 0, '89883803', 'eduardo.yanez350@gmail.com', '1998-02-26 00:00:00', '0', '', 2, 18, ''),
(219, '', 'Ellis', '', 'Reyes', '', 26433222, '32859995', 'kuuroko04@gmail.com', '1994-03-31 00:00:00', '0', '', 2, 5, ''),
(220, '', 'Marianela', '', 'Cantarero Zavala', '', 22339444, '99822525', 'mnela94@gmail.com', '1994-02-16 00:00:00', '0', '', 2, 5, ''),
(221, '', 'Nancy Nahomi', '', 'Tercero Morales', '', 22090025, '95346224', 'Nonijoan1221@gmail.com', '2000-06-12 00:00:00', '0', '', 2, 5, ''),
(222, '', 'Dilcia', '', 'Reyes', '', 26433222, '32859995', 'mikuwabakadesu@gmail.com', '1996-08-23 00:00:00', '0', '', 2, 2, ''),
(223, '', 'Fausto Fernando', '', 'Hernandez Rivera', '', 22260259, '95527122', 'faustoanime321@hotmail.com', '1999-01-08 00:00:00', '0', '', 2, 7, ''),
(224, '', 'Lourdes Fabiola', '', 'Rivera T&Atilde;&iexcl;bora', '', 0, '96969813', 'fabyrivera98@gmail.com', '1993-12-18 00:00:00', '0', '', 2, 13, ''),
(225, '', 'Kewin', '', 'Izaguirre Medina', '', 0, '98716129', 'kewinantonioizaguirre@yahoo.es', '2015-09-07 00:00:00', '0', '', 2, 12, ''),
(226, '', 'Maria Helena', '', 'Berenguer', '', 0, '31754884', 'mhberenguer@gmail.com', '1955-08-24 00:00:00', '0', '', 2, 3, ''),
(227, '', 'kimberly sheryl ', '', 'rodas rodas', '', 22237141, '88457139', 'sherylrodas@gmail.com', '1994-02-11 00:00:00', '0', '', 2, 7, ''),
(228, '', 'Hanyi Walquiria', '', 'Acosta  Lainez', '', 33282420, '99507025', 'hanyiwalquiria@gmail.com', '1990-08-16 00:00:00', '0', '', 2, 4, ''),
(229, '', 'Jorge Luis', '', 'Mejia Fuentes', '', 0, '99850455', 'jorgeluismejia99@gmail.com', '1999-10-25 00:00:00', '0', '', 2, 15, ''),
(230, '', 'Marllury Julissa ', '', 'Sandoval Munguia ', '', 22708255, '97033604', 'marlluryjulissas@yahoo.com ', '1993-04-12 00:00:00', '0', '', 2, 2, ''),
(231, '', 'Arleth Yanileisy', '', 'G&Atilde;&iexcl;mez Hern&Atild', '', 0, '97334421', 'arlethgamez@yahoo.es', '1994-10-24 00:00:00', '0', '', 2, 2, ''),
(232, '', 'Estefan&Atilde;&shy;a Beatriz', '', 'Benda&Atilde;&plusmn;a Castro', '', 22374436, '99033322', 'estefaniabendana@hotmail.com', '1989-12-02 00:00:00', '0', '', 2, 14, ''),
(233, '', 'Elvin', '', 'Rodriguez Mendez', '', 22236775, '89105839', 'elvin9412@yahoo.com', '1994-10-21 00:00:00', '0', '', 2, 2, ''),
(234, '', 'Jos&Atilde;&copy; Ricardo', '', 'Urqu&Atilde;&shy;a Zavala', '', 2772, '96740757', 'jenova-12@hotmail.com', '1990-04-19 00:00:00', '0', '', 2, 7, ''),
(235, '', 'Sergio Kevin', '', 'Acosta Lainez', '', 0, '96206800', 'sergio21skal@hotmail.com', '1996-11-21 00:00:00', '0', '', 2, 4, ''),
(236, '', 'Jessie Pamela', '', 'Moncada Cruz', '', 22222329, '33306563', 'jessie23pamela@hotmail.es', '1992-04-23 00:00:00', '0', '', 2, 4, ''),
(237, '', 'Stefany Patricia ', '', 'Cruz Velasquez', '', 22205541, '99056840', 'ppatricia1726@hotmail.com', '1994-10-17 00:00:00', '0', '', 2, 14, ''),
(238, '', 'Yolani', '', 'Ponce', '', 22011325, '32273282', 'yolaniponce_alpha@yahoo.com', '1988-08-17 00:00:00', '0', '', 2, 1, ''),
(239, '', 'Jason Samael', '', 'Maldonado Gudiel', '', 22364520, '95832095', 'jsmgudiel@gmail.com', '1994-03-16 00:00:00', '0', '', 2, 4, ''),
(240, '', 'Dayanara', '', 'Valladares Dubon', '', 22304816, '88494342', 'daydubon26@gmail.com', '2015-09-07 00:00:00', '0', '', 2, 2, ''),
(241, '', 'Elvin', '', 'Rodriguez Mendez', '', 22236775, '89105839', 'elvin1615@gmail.com', '2015-09-07 00:00:00', '0', '', 2, 2, ''),
(242, '', 'Ra&Atilde;&ordm;l Alejandro', '', 'Gonz&Atilde;&iexcl;lez Gallo', '', 22285336, '95456077', 'raulalejandro90@yahoo.com', '1999-04-13 00:00:00', '0', '', 2, 3, ''),
(243, '', 'Joel Alberto', '', 'Lagos Linck', '', 3201, '8904-5799', 'joellinck@gmail.com', '1984-12-14 00:00:00', '0', '', 2, 11, ''),
(244, '', 'Alvaro Lisandro', '', 'Tavel Molina', '', 2232, '9975-7823', 'alvaro.tavel@hotmail.com', '1998-04-01 00:00:00', '0', '', 2, 14, ''),
(245, '', 'Soraya Rosangel', '', 'Aceituno Vidaur ', '', 22451033, '96134303', 'rosangelaceituno@hotmail.es', '1997-02-20 00:00:00', '0', '', 2, 13, ''),
(246, '', 'giannina solange ', '', 'reyes reyes', '', 0, '33150298', 'gianninasolanger188@gmail.com ', '1990-08-18 00:00:00', '0', '', 2, 1, ''),
(247, '', 'Manuel Adalid', '', 'Gamero Valladares', '', 2147483647, '+50432730353', 'manuelgamero92@gmail.com', '1992-02-04 00:00:00', '0', '', 2, 12, ''),
(248, '', 'Lurvin Marisol', '', 'Villalta Espinal', '', 2235, '9623-6228', 'marisol.villalta@hotmail.com', '0000-00-00 00:00:00', '0', '', 2, 18, ''),
(249, '', 'Luis Fernando', '', 'G&Atilde;&sup3;mez Barahona', '', 2235, '9936-1198', 'luisfernh@hotmail.com', '0000-00-00 00:00:00', '0', '', 2, 18, ''),
(250, '', 'Jesuard Sahid', '', 'Zuniga Paz', '', 22712386, '95584444', 'jesuahid@gmail.com', '1996-04-18 00:00:00', '0', '', 2, 2, ''),
(251, '', 'Jorge Leonardo', '', 'Castellanos Ir&Atilde;&shy;as', '', 99885428, '99885428', 'jorgeleonardo@castellanosirias.com', '2015-09-08 00:00:00', '0', '', 2, 3, ''),
(252, '', 'Anibal Alexander', '', 'Salgado Guerrero', '', 2243, '3351-1305', 'anibal.salgadoguerrero@gmail.com', '1990-09-08 00:00:00', '0', '', 2, 12, ''),
(253, '', 'Carlos Raul', '', 'Munguia Suazo', '', 22833405, '97336615', 'antonia.suazom@gmail.com', '2000-01-31 00:00:00', '0', '', 2, 6, ''),
(254, '', 'Alicia Gabriela', '', 'Medina Cruz', '', 22320952, '99701965', 'alosia.san@gmail.com', '1987-02-01 00:00:00', '0', '', 2, 7, ''),
(255, '', 'valeria sofia', '', 'alvarado mejia', '', 22352055, '87334905', 'kvmalvarado@yahoo.com.mx', '2015-09-08 00:00:00', '0', '', 2, 5, ''),
(256, '', 'Sue Ana', '', 'Aparicio Godoy', '', 22343162, '98138081', 'suki_ag@hotmail.com', '2015-09-08 00:00:00', '0', '', 2, 15, ''),
(257, '', 'jose raul', '', 'pinto irias', '', 22331491, '33644801', 'pintojose074@gmail.com', '1996-08-09 00:00:00', '0', '', 2, 4, ''),
(258, '', 'Ana Gabriela ', '', 'Herrera Herrera', '', 2270, '32412491', 'gabiherrera92@gmail.com', '1992-04-19 00:00:00', '0', '', 2, 4, ''),
(259, '', 'Luis', '', 'Alvarado', '', 22305823, '94886871', 'lsalvarado.hn@gmail.com', '1986-08-12 00:00:00', '0', '', 2, 2, ''),
(260, '', 'Jose', '', 'Ruiz', '', 22253754, '94723110', 'jhruiz.1996@gmail.com', '2015-09-08 00:00:00', '0', '', 2, 4, ''),
(261, '', 'magbis salvador adonai ', '', 'medina raudales ', '', 22331491, '97334567', 'magbis98medina@gmail.com', '1998-05-15 00:00:00', '0', '', 2, 1, ''),
(262, '', 'Jose ', '', 'Silva Sierra', '', 22365141, '97266100', 'sierrajose24@yahoo.es', '1997-11-09 00:00:00', '0', '', 2, 5, ''),
(263, '', 'Karen Ninochka', '', 'Barahona Aguilar', '', 0, '94788099', 'kanibaag@gmail.com', '2015-09-08 00:00:00', '0', '', 2, 4, ''),
(264, '', 'Julio Aticus ', '', 'Romero Flores', '', 22916413, '98705215', 'jatics24@gmail.com', '1997-04-08 00:00:00', '0', '', 2, 15, ''),
(265, '', 'karina nicole', '', 'vasquez yanes', '', 0, '87641495', 'yanes_2009@hotmail.es', '1992-12-19 00:00:00', '0', '', 2, 18, ''),
(266, '', 'Harold Isaac', '', 'Venegas', '', 0, '99101503', 'harold_kbt@yahoo.com', '2015-09-08 00:00:00', '0', '', 2, 18, ''),
(268, '', 'David Alexander', '', 'Mejia', '', 22254472, '95357270', 'mejiadavid62@gmail.com', '1997-01-25 00:00:00', '0', '', 2, 2, ''),
(269, '', 'Donald Rolando', '', 'Canales salinas', '', 22255609, '95780516', 'Donald.canales@novem.hn', '1980-12-13 00:00:00', '0', '', 2, 3, ''),
(270, '', 'Johana', '', 'Zelaya', '', 0, '33064078', 'zelayajimenez3008@gmail.com', '2015-09-08 00:00:00', '0', '', 2, 1, ''),
(271, '', 'Jose Luis', '', 'Espinal', '', 22236062, '33757755', 'deathspinal@aol.com', '1987-04-11 00:00:00', '0', '', 2, 18, ''),
(273, '', 'Sobeida Nazaret', '', 'Nu&Atilde;&plusmn;ez Rosa', '', 31602838, '98428026', 'nasasobe@wwindowslive.com', '1996-01-03 00:00:00', '0', '', 2, 6, ''),
(274, '', 'Yelena Margarita', '', 'Rivas Robles', '', 22278136, '31785853', 'yeri118@gmail.com', '1987-09-11 00:00:00', '0', '', 2, 18, ''),
(275, '', 'Juan Pablo', '', 'Rivas Robles', '', 22278136, '89918804', 'riro118@hotmail.com', '1988-08-18 00:00:00', '0', '', 2, 18, ''),
(276, '', 'Katherine', '', 'Cerrato Arana', '', 2246, '3223-1883', 'katiarana25@gmail.com', '1995-11-25 00:00:00', '0', '', 2, 2, ''),
(277, '', 'Daniel Edgardo', '', 'Brice&Atilde;&plusmn;o Molina', '', 0, '97416916', 'bdanieledgardo@hotmail.com', '0000-00-00 00:00:00', '0', '', 2, 12, ''),
(278, '', 'Daniela Idania', '', 'Ordo&Atilde;&plusmn;ez Godoy', '', 22273169, '96953065', 'diog18@hotmail.com', '1997-09-18 00:00:00', '0', '', 2, 13, ''),
(279, '', 'Cesar ', '', 'Padilla Rodriguez', '', 0, '99721417', 'cesarpadilla2010@live.com', '2000-06-01 00:00:00', '0', '', 2, 5, ''),
(280, '', 'Luis', '', 'Pacheco', '', 22252834, '89758706', 'willi_walli_1@yahoo.es', '1988-12-08 00:00:00', '0', '', 2, 7, ''),
(281, '', 'Cristian Josu&Atilde;&copy;', '', 'Montiel P&Atilde;&copy;rez', '', 22455372, '97982066', 'cristian.montiel@unah.hn', '1993-12-08 00:00:00', '0', '', 2, 3, ''),
(282, '', 'Arnaldo', '', 'Rodas', '', 0, '32947587', 'arod016@outlook.com', '1982-10-16 00:00:00', '0', '', 2, 2, ''),
(283, '', 'Pamela', '', 'Almendares Giron', '', 33599446, '33599446', 'pamelocho@gmail.com', '1989-08-20 00:00:00', '0', '', 2, 7, ''),
(284, '', 'Norma Sagrario', '', 'Rivera Ferrera', '', 0, '33330138', 'norma.srivera.f@gmail.com', '0000-00-00 00:00:00', '0', '', 2, 2, ''),
(285, '', 'Andre', '', 'Hernandez Velasquez', '', 22332726, '33050737', 'andretux2495@gmail.com', '2015-09-08 00:00:00', '0', '', 2, 3, ''),
(286, '', 'Normanda Dannesse', '', 'Lopez', '', 22516564, '32669262', 'danesy3@gmail.com', '1990-03-16 00:00:00', '0', '', 2, 7, ''),
(287, '', 'juan manuel', '', 'coello aparicio', '', 22334969, '98499782', 'melizabethgato@hotmail.com', '2000-05-14 00:00:00', '0', '', 2, 12, ''),
(288, '', 'Gerardo Henrique', '', 'Romero Vargas', '', 0, '31729042', 'gromero258@gmail.com', '1999-05-03 00:00:00', '0', '', 2, 11, ''),
(289, '', 'Erika Margarita', '', 'Navarro Zepeda', '', 0, '97307342', 'navarro.erika.m@gmail.com', '1992-10-22 00:00:00', '0', '', 2, 12, ''),
(290, '', 'Allan Esau ', '', 'Aguilar Perdomo', '', 27812291, '32558051', 'esauperdomo@yahoo.es', '1988-06-19 00:00:00', '0', '', 2, 7, ''),
(291, '', 'joselyn victoria ', '', 'sorto rivera', '', 0, '', 'j_vick0693@hotmail.com', '1993-07-04 00:00:00', '0', '', 2, 13, ''),
(292, '', 'Junielle', '', 'Fernandez', '', 0, '32435348', 'junielle_fer@yahoo.es', '1993-11-22 00:00:00', '0', '', 2, 7, ''),
(293, '', 'Tatiana', '', 'Fernandez', '', 0, '95927059', 'tatiurbina22@gmail.com', '1995-05-22 00:00:00', '0', '', 2, 7, ''),
(294, '', 'Xoce Ottoman', '', 'Fernandez', '', 0, '89710755', 'samael_urbina@yahoo.com', '1989-07-16 00:00:00', '0', '', 2, 4, ''),
(295, '', 'devaki ', '', 'mejia rivera', '', 0, '89006401', 'kivamr@hotmail.com', '1985-03-19 00:00:00', '0', '', 2, 3, ''),
(296, '', 'Elsy Alejandra', '', 'madrid rivera', '', 0, '96765349', 'melsyalejandra92@gmail.com', '1998-09-01 00:00:00', '0', '', 2, 1, ''),
(297, '', 'Claudia Melissa', '', 'Escoto Caballero', '', 0, '96902826', 'carlosmel_1324@hotmail.com', '1996-05-25 00:00:00', '0', '', 2, 18, ''),
(298, '', 'Marcelo', '', 'Garcia Mendoza', '', 0, '95537121', 'marcelogmendoza@hotmail.com', '1997-02-10 00:00:00', '0', '', 2, 2, ''),
(299, '', 'Carlos Alfredo', '', 'Flores Ponce', '', 0, '89841724', 'Ellobo1324@gmail.com', '1990-08-24 00:00:00', '0', '', 2, 18, ''),
(300, '', 'Rocio Gabriela', '', 'Martinez Aguilera', '', 22573458, '95349294', 'rociomartinez_14@hotmail.es', '1992-08-14 00:00:00', '0', '', 2, 6, ''),
(301, '', 'Claudia ', '', 'Melgar', '', 22430523, '31980306', 'cimrcloclo@gmail.com', '2015-09-09 00:00:00', '0', '', 2, 12, ''),
(302, '', 'Sara', '', 'Melgar', '', 22430523, '89798904', 'saramelgar03@gmail.com', '1997-05-09 00:00:00', '0', '', 2, 12, ''),
(303, '', 'Alicia', '', 'Melgar', '', 2243052, '88245358', 'ali17_mr@hotmail.com', '1991-08-17 00:00:00', '0', '', 2, 12, ''),
(304, '', 'KELLYN JEANETH', '', 'AGUILAR PORTILLO', '', 0, '33860114', 'kellyn.aguilar@bch.hn', '1981-10-25 00:00:00', '0', '', 2, 6, ''),
(305, '', 'Karla Johana Padilla Contreras', '', 'Padilla Contreras ', '', 22388305, '32115881', 'karlahon@yahoo.com', '1975-10-13 00:00:00', '0', '', 2, 3, ''),
(306, '', 'Susann', '', 'Canizales Bocanegra', '', 2232, '96247483', 'sjcabon@gmail.com', '1978-08-06 00:00:00', '0', '', 2, 18, ''),
(307, '', 'Manuel Alexander ', '', 'Valladares Contreras', '', 504, '+50489902862', 'manuel.a.valladares@hotmail.com', '1984-07-08 00:00:00', '0', '', 2, 3, ''),
(308, '', 'Luis Fernando ', '', 'Ponce Chac&Atilde;&sup3;n', '', 0, '32201175', 'lynxfer_5@hotmail.com', '1983-12-03 00:00:00', '0', '', 2, 3, ''),
(309, '', 'Jose Luis', '', 'Silva Amador', '', 2147483647, '+50497617886', 'jlusilva.8710@gmail.com', '1987-10-25 00:00:00', '0', '', 2, 3, ''),
(310, '', 'Luis', '', 'Alvarado Molina', '', 22305823, '94886871', 'lsalvarado.hn', '1986-12-08 00:00:00', '0', '', 2, 2, ''),
(311, '', 'Jose David', '', 'Jiron Gonzales', '', 22573623, '9635-0428', 'josedavid31@gmail.com', '1981-10-31 00:00:00', '0', '', 2, 18, ''),
(312, '', 'Steven', '', 'Espinal', '', 22392144, '94704143', 'thundersteve77@gmail.com', '1994-07-27 00:00:00', '0', '', 2, 1, ''),
(313, '', 'Egla Rosmery', '', 'Gattorno Gutierrez', '', 0, '95775587', 'japanrocks@hotmail.com', '1985-06-22 00:00:00', '0', '', 2, 15, ''),
(314, '', 'Sebastian ', '', 'Kafie', '', 22322860, '94575091', 'sebaskafie7@gmail.com', '0000-00-00 00:00:00', '0', '', 2, 18, ''),
(315, '', 'Anthony Wylberth', '', 'Rodriguez Thompson', '', 87345567, '87345562', 'nw_rs@hotmail.com', '1999-09-07 00:00:00', '0', '', 2, 7, ''),
(316, '', 'Nicholle', '', 'Maradiaga Sikaffy', '', 0, '33330191', 'ieattheworld@yahoo.com', '1991-08-28 00:00:00', '0', '', 2, 7, ''),
(317, '', 'Suanny', '', 'Salinas', '', 22456077, '32409208', 'suanny20092009@hotmail.com', '1997-01-26 00:00:00', '0', '', 2, 4, ''),
(318, '', 'Kerlim Escarleth', '', 'Varela Palma', '', 0, '88024486', 'kerlim.varela@unah.hn', '1993-09-28 00:00:00', '0', '', 2, 14, ''),
(319, '', 'Norma Lastenia ', '', 'Zuniga Trejo', '', 22367552, '97725443', 'lastetrejo@gmail.com', '1989-05-19 00:00:00', '0', '', 2, 3, ''),
(320, '', 'Luis Fernando ', '', 'Ord&Atilde;&sup3;&Atilde;&plus', '', 2225, '99319577', 'luisferro2000@yahoo.com', '1965-05-21 00:00:00', '0', '', 2, 3, ''),
(321, '', 'Adrian Andrei', '', 'Guerra Triminio', '', 22712490, '99183002', 'ritrim2@yahoo.com', '1999-11-03 00:00:00', '0', '', 2, 3, ''),
(322, '', 'Adrian Adolfo ', '', 'Guerra Padilla', '', 22712490, '97331129', 'adrianguerra@yahoo.com', '1977-06-30 00:00:00', '0', '', 2, 3, ''),
(323, '', 'Mariam Alejandra', '', 'Hernandez Lopez', '', 22266917, '33908398', 'maleja26@yahoo.com', '1985-06-26 00:00:00', '0', '', 2, 3, ''),
(324, '', 'Yanshan ', '', 'Chen', '', 0, '31918294', 'yanshans.chen@gmail.com', '1992-03-29 00:00:00', '0', '', 2, 2, ''),
(325, '', 'Silvia Yasmin ', '', 'Morel Bu', '', 22275122, '33531111', 'Siyamobu@yahoo.es', '1991-06-11 00:00:00', '0', '', 2, 5, ''),
(326, '', 'Carlos Eduardo ', '', 'Medrano Montes', '', 22463275, '94653406', 'medranoe09@gmail.com', '1982-01-09 00:00:00', '0', '', 2, 18, ''),
(327, '', 'Moises Alejandro', '', 'Canales Lainez', '', 22242657, '94800392', 'mdisco90@gmail.com', '2015-09-09 00:00:00', '0', '', 2, 12, ''),
(328, '', 'Jefrry', '', 'Rodriguez Portillo', '', 0, '', 'jeff-mauri_2012@hotmail.com', '1992-11-20 00:00:00', '0', '', 2, 3, ''),
(329, '', 'Jose Fabricio', '', 'Banegas Ruiz', '', 0, '+50494803718', 'fabriciobanegas@hotmail.com', '1987-11-03 00:00:00', '0', '', 2, 13, ''),
(330, '', 'Edwyn Moises', '', 'Rivera', '', 96804132, '31583496 ', 'edwynhn2002@yahoo.es', '1986-01-15 00:00:00', '0', '', 2, 18, ''),
(331, '', 'Beverly Hazel ', '', 'Alegria Molina', '', 0, '3224341389350873', 'hazelitaalegria@gmail.com', '1996-02-21 00:00:00', '0', '', 2, 4, ''),
(332, '', 'alejandra amador', '', 'amador matamoros', '', 222252233, '99044414', 'alematamoros@hotmail.com', '1997-07-01 00:00:00', '0', '', 2, 12, ''),
(333, '', 'Angel David', '', 'Gir&Atilde;&sup3;n Aguilera', '', 22236177, '87979180', 'angel09david@yahoo.com', '1999-12-02 00:00:00', '0', '', 2, 2, ''),
(334, '', 'Elisa Mar&Atilde;&shy;a', '', 'Rodr&Atilde;&shy;guez Palacios', '', 22573069, '33896869', 'rodriguez.elisa@hotmail.com', '2015-09-09 00:00:00', '0', '', 2, 18, ''),
(335, '', 'Rodgers', '', 'Romero Pinto ', '', 0, '32432817', 'ColossusRV@hotmail.com', '2015-09-09 00:00:00', '0', '', 2, 4, ''),
(336, '', 'Carlos Eduardo', '', 'Hernandez Lopez', '', 22266917, '33894661', 'beis855@gmail.com', '2015-09-09 00:00:00', '0', '', 2, 3, ''),
(337, '', 'Doris Vannesa', '', 'Cruz Solano', '', 22550214, '99882753', 'vannesa882004@hotmail.com', '2015-09-09 00:00:00', '0', '', 2, 18, ''),
(338, '', 'Eric Enrique', '', 'Raudales San Martin', '', 0, '32963614', 'eric.raudales@gmail.com', '1991-10-24 00:00:00', '0', '', 2, 13, ''),
(339, '', 'DENNIS FRANCISCO', '', 'ZELAYA ZAPATA', '', 22398229, '97913323', 'ingdenniszelayaz@yahoo.com', '1984-12-09 00:00:00', '0', '', 2, 11, ''),
(340, '', 'Alex Savier ', '', 'Ramos Rodriguez', '', 22456077, '32220657', 'alexramosr06@gmail.com', '1996-06-06 00:00:00', '0', '', 2, 4, ''),
(341, '', 'Ambar Lucero', '', 'Hernandez Espinoza', '', 22131545, '87824082', 'ambar.lucero.hernandez@gmail.com', '1993-10-29 00:00:00', '0', '', 2, 3, ''),
(342, '', 'Alex Savier', '', 'Ramos Rodriguez', '', 22456077, '32220657', 'alexramosr06@hotmail.com', '1996-06-06 00:00:00', '0', '', 2, 4, ''),
(343, '', 'Maria del Rosario', '', 'Rodriguez Madrid', '', 22269217, '97418508', 'mrrm_82@hotmail.com', '1982-03-26 00:00:00', '0', '', 2, 1, ''),
(344, '', 'Daniel', '', 'Macpui', '', 22241251, '94866077', 'macpui1290@hotmail.com', '1990-12-12 00:00:00', '0', '', 2, 5, ''),
(345, '', 'Daniel Humberto', '', 'Macpui Benitez', '', 0, '94866077', 'dhbenitez@manconsulting.co.uk', '1990-12-12 00:00:00', '0', '', 2, 2, ''),
(346, '', 'Andrea Nicole', '', 'Rivera Piza&Atilde;&plusmn;a', '', 22573788, '94600652', 'andrearivera0715@gmail.com', '2015-09-09 00:00:00', '0', '', 2, 12, ''),
(347, '', 'Miguel Estuardo', '', 'Flores Robles', '', 22354584, '3233529', 'mfloresgt@gmail.com', '1969-02-22 00:00:00', '0', '', 2, 18, ''),
(348, '', 'Ana Michelle', '', 'Menc&Atilde;&shy;a Baca', '', 7216, '7216-7208', 'ana.michelle.baca@gmail.com', '2000-03-23 00:00:00', '0', '', 2, 7, ''),
(349, '', 'daphner gabriela', '', 'arguijo zavaja', '', 22396822, '95679527', 'daphner.gabriela9@gmail.com', '1997-09-03 00:00:00', '0', '', 2, 14, ''),
(350, '', 'Alejandra Maria', '', 'Carrasco Raudales', '', 2234, '9794-4689', 'maria_san97@hotmail.com', '1997-10-09 00:00:00', '0', '', 2, 14, ''),
(351, '', 'Miguel Estuardo', '', 'Flores Robles', '', 22354584, '32373529', 'mfloresgt@hotmail.com', '1969-02-22 00:00:00', '0', '', 2, 18, ''),
(352, '', 'Kevin Alexander', '', 'Reyes Gomez', '', 22299595, '98220447', 'kerey98@yahoo.com', '1998-05-06 00:00:00', '0', '', 2, 4, ''),
(353, '', 'Miguel Antonio', '', 'Mejia Benavides', '', 22271853, '33786838', 'miguelmejia60@gmail.com', '2015-09-09 00:00:00', '0', '', 2, 6, ''),
(354, '', 'Obdulio', '', 'Oliva Graugnard', '', 22239997, '31488956', 'obdulioolivva94@gmail.com', '0000-00-00 00:00:00', '0', '', 2, 2, ''),
(355, '', 'Daniel', '', 'Suazo', '', 22268306, '99566715', 'suazodaniel99@gmail.com', '1999-07-12 00:00:00', '0', '', 2, 12, ''),
(356, '', 'Jose Diego', '', 'Lagos Martinez', '', 22387195, '', 'gatoazul1821@yahoo.com', '1997-05-18 00:00:00', '0', '', 2, 15, ''),
(357, '', 'Daniela Ver&Atilde;&sup3;nica', '', 'Valladares Mart&Atilde;&shy;ne', '', 22288304, '98707776', 'danivvmtz_56@hotmail.com', '1994-09-07 00:00:00', '0', '', 2, 2, ''),
(358, '', 'Patricia', '', 'Eveline', '', 22397341, '99844584', 'Patricia.Eveline@upi.edu.hn', '1993-05-22 00:00:00', '0', '', 2, 5, ''),
(359, '', 'Noelia', '', 'Rivas Midence', '', 22460956, '96650365', 'noeliamidence@gmail.com', '1992-03-31 00:00:00', '0', '', 2, 1, ''),
(360, '', 'Dayana ', '', 'Rodriguez', '', 0, '33159952', 'dayana.c.r.m@gmail.com', '0000-00-00 00:00:00', '0', '', 2, 18, ''),
(361, '', 'Anielka Sof&Atilde;&shy;a', '', 'Mayes Anduray', '', 0, '95516074', 'anielkamayes@hotmail.com', '1999-05-22 00:00:00', '0', '', 2, 7, ''),
(362, '', 'Andrea Michell ', '', 'Cruz Portales', '', 0, '32883600', 'andreamichellportales@hotmail.es', '1999-08-06 00:00:00', '0', '', 2, 4, ''),
(363, '', 'Jorge Luis ', '', 'Izaguirre Medina', '', 22300296, '97783583', 'jorgeluisiza@gmail.com', '1993-05-25 00:00:00', '0', '', 2, 14, ''),
(364, '', 'Henry', '', 'Cruz', '', 0, '95309999', 'cruzhenry86@gmail.com', '1996-01-07 00:00:00', '0', '', 2, 2, ''),
(365, '', 'Michelle', '', 'Flores', '', 22711137, '96714425', 'bexie97@yahoo.com', '1997-01-27 00:00:00', '0', '', 2, 4, ''),
(366, '', 'Gabriela Maria ', '', 'Rodriguez Moncada', '', 89356845, '89356845', 'gabz_07_941@hotmail.com', '1992-07-06 00:00:00', '0', '', 2, 18, ''),
(367, '', 'Valery Soe', '', 'Gomez Rivera', '', 22348149, '95761457', 'valesoe96@hotmail.com', '1996-09-14 00:00:00', '0', '', 2, 3, ''),
(368, '', 'Ivis Elena', '', 'Hernandez Maldonado', '', 22274901, '98103840', 'ivis2890@yahoo.com', '1990-02-28 00:00:00', '0', '', 2, 1, ''),
(369, '', 'Bertha Cecilia', '', 'Beltran Matute', '', 2227987, '99010788', 'ceciliabeltran@yahoo.es', '1987-06-07 00:00:00', '0', '', 2, 1, ''),
(370, '', 'Roger Misael', '', 'Barrientos Navas', '', 22462977, '99453037', 'elzx92@gmail.co,', '1992-06-04 00:00:00', '0', '', 2, 5, ''),
(371, '', 'Roger', '', 'Barrientos Navas', '', 22450305, '99453037', 'elzx92@hotmail.com', '1992-06-04 00:00:00', '0', '', 2, 5, ''),
(372, '', 'Andrea Xiomara', '', 'Landa Sierra', '', 2289355, '31715896', 'andre.xio237@hotmail.com', '1991-07-23 00:00:00', '0', '', 2, 12, ''),
(373, '', 'Diego Roberto', '', 'May&Atilde;&copy;n Elvir', '', 22366209, '98335158', 'diego_rme@yahoo.com', '1995-12-09 00:00:00', '0', '', 2, 1, ''),
(374, '', 'Alen', '', 'Miranda', '', 0, '96083756', 'alen_miranda@yahoo.com', '1984-08-24 00:00:00', '0', '', 2, 14, ''),
(375, '', 'Angela Vanessa', '', 'Abrego Suares', '', 0, '33385236', 'angela_vanessa2005@yahoo.com', '1990-02-08 00:00:00', '0', '', 2, 4, ''),
(376, '', 'Ysen Dayani ', '', 'Zavala Ventura', '', 22244018, '97833639', 'dazavy07@gmail.com', '1988-09-10 00:00:00', '0', '', 2, 3, ''),
(377, '', 'Allan Josue', '', 'Coello Raudales', '', 2224, '98776881', 'jocoal23@gmail.com', '1984-02-23 00:00:00', '0', '', 2, 3, ''),
(378, '', 'Ysen Dayani', '', 'Zavala Ventura', '', 22244018, '97833639', 'dazavi07@gmail.com', '1988-01-10 00:00:00', '0', '', 2, 3, ''),
(379, '', 'Allan Josue', '', 'Coello', '', 22244018, '98776881', 'jocoal23@gmai.com', '1984-02-23 00:00:00', '0', '', 2, 3, ''),
(380, '', 'Andrea Victoria', '', 'Mahomar Castro', '', 22392377, '32053136', 'avmc98@gmail.com', '1998-11-05 00:00:00', '0', '', 2, 6, ''),
(381, '', 'Jhonny Josue', '', 'Zuniga Sanchez', '', 2257, '9497-8393', 'jhonny.j.zuniga@gmail.com', '1998-12-08 00:00:00', '0', '', 2, 14, ''),
(382, '', 'Osman Rolando Jimenez', '', 'Jimenez Rivera', '', 22347270, '31754069', 'osman.rivera@hotmail.com', '1990-10-13 00:00:00', '0', '', 2, 2, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblnevel`
--

CREATE TABLE IF NOT EXISTS `tblnevel` (
  `CodNevel` int(20) NOT NULL,
  `NameNevel` varchar(30) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblnevel`
--

INSERT INTO `tblnevel` (`CodNevel`, `NameNevel`) VALUES
(1, 'Japones 1 '),
(2, 'Japones 2 '),
(3, 'Japones 3 '),
(4, 'Japones 4 '),
(5, 'Japones 5');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_aula`
--

CREATE TABLE IF NOT EXISTS `tbl_aula` (
  `CODIGO_AULA` int(11) NOT NULL,
  `NOMBRE_AULA` varchar(15) DEFAULT NULL,
  `DESCRIPCION_AULA` varchar(35) DEFAULT NULL,
  `ESTADO` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_clase`
--

CREATE TABLE IF NOT EXISTS `tbl_clase` (
  `CODIGO_CLASE` int(11) NOT NULL,
  `NOMBRE_CLASE` varchar(35) DEFAULT NULL,
  `REQUISITO` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_matricula`
--

CREATE TABLE IF NOT EXISTS `tbl_matricula` (
  `CODIGO_MATRICULA` int(11) NOT NULL,
  `FECHA` date DEFAULT NULL,
  `NOTA` int(11) DEFAULT NULL,
  `PERIODO` int(11) DEFAULT NULL,
  `CODIGO_ESTUDIANTE` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_seccion`
--

CREATE TABLE IF NOT EXISTS `tbl_seccion` (
  `CODIGO_SECCION` int(11) NOT NULL,
  `HORA_INICIO` date DEFAULT NULL,
  `HORA_FIN` date DEFAULT NULL,
  `CUPOS` int(11) DEFAULT NULL,
  `CODIGO_MATRICULA` int(11) NOT NULL,
  `CODIGO_MAESTRO` int(11) NOT NULL,
  `CODIGO_AULA` int(11) NOT NULL,
  `CODIGO_CLASE` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `userName` varchar(30) NOT NULL,
  `password` varchar(256) NOT NULL,
  `creationdate` datetime NOT NULL,
  `datemodified` datetime NOT NULL,
  `disablingdate` datetime DEFAULT NULL,
  `status` int(1) NOT NULL,
  `codEmpleado` varchar(4) NOT NULL,
  `log` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`userName`, `password`, `creationdate`, `datemodified`, `disablingdate`, `status`, `codEmpleado`, `log`) VALUES
('ant', 'QXNkLjEyMzQ=', '2015-09-15 00:00:00', '2015-09-16 00:00:00', '2015-09-22 00:00:00', 1, '1', 0),
('irma', 'QXNkLjEyMzQ=', '2015-09-16 00:00:00', '2015-09-16 00:00:00', '2015-09-18 02:54:08', 1, '2', 0),
('jonie', 'QXNkLjEyMzQ=', '2015-09-08 00:00:00', '2015-09-17 00:00:00', '2015-09-13 00:24:32', 1, '3', 1),
('mrnr', 'QXNkLjEyMzQ=', '2015-09-03 23:16:21', '2015-09-03 23:16:21', NULL, 1, '4', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `accesos_de_usuario`
--
ALTER TABLE `accesos_de_usuario`
  ADD PRIMARY KEY (`iden`), ADD KEY `employedCode_FK` (`employedCode`);

--
-- Indices de la tabla `binnacle`
--
ALTER TABLE `binnacle`
  ADD PRIMARY KEY (`codBinnacle`), ADD KEY `codEmpleado_FK_Binnacle` (`codEmpleado`);

--
-- Indices de la tabla `cargos`
--
ALTER TABLE `cargos`
  ADD PRIMARY KEY (`cargoID`), ADD UNIQUE KEY `nombreCargo` (`nombreCargo`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`CodEmpleado`), ADD UNIQUE KEY `CodEmpleado` (`CodEmpleado`), ADD KEY `CargoE_FK` (`Cargo`);

--
-- Indices de la tabla `tblnevel`
--
ALTER TABLE `tblnevel`
  ADD PRIMARY KEY (`CodNevel`) COMMENT 'Codigo de los niveles';

--
-- Indices de la tabla `tbl_aula`
--
ALTER TABLE `tbl_aula`
  ADD PRIMARY KEY (`CODIGO_AULA`);

--
-- Indices de la tabla `tbl_clase`
--
ALTER TABLE `tbl_clase`
  ADD PRIMARY KEY (`CODIGO_CLASE`);

--
-- Indices de la tabla `tbl_matricula`
--
ALTER TABLE `tbl_matricula`
  ADD PRIMARY KEY (`CODIGO_MATRICULA`);

--
-- Indices de la tabla `tbl_seccion`
--
ALTER TABLE `tbl_seccion`
  ADD PRIMARY KEY (`CODIGO_SECCION`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD UNIQUE KEY `userName` (`userName`), ADD UNIQUE KEY `codEmpleado` (`codEmpleado`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `accesos_de_usuario`
--
ALTER TABLE `accesos_de_usuario`
  MODIFY `iden` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=45;
--
-- AUTO_INCREMENT de la tabla `binnacle`
--
ALTER TABLE `binnacle`
  MODIFY `codBinnacle` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `cargos`
--
ALTER TABLE `cargos`
  MODIFY `cargoID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `CodEmpleado` int(4) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=383;
--
-- AUTO_INCREMENT de la tabla `tblnevel`
--
ALTER TABLE `tblnevel`
  MODIFY `CodNevel` int(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
