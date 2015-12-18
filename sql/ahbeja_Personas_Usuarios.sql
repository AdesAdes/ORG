-- phpMyAdmin SQL Dump
-- version 4.4.14
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 18-12-2015 a las 03:51:35
-- Versión del servidor: 5.6.26
-- Versión de PHP: 5.5.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

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
SELECT * FROM tbl_roles$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `allRegisters`()
    READS SQL DATA
    SQL SECURITY INVOKER
SELECT 
	COUNT(accesos_de_usuario.employedCode) AS totalAccess,
    accesos_de_usuario.employedCode,
	tbl_personas.NOMBRE AS P_Nombre, 
	tbl_personas.APELLIDO AS P_Apellido
FROM 
	accesos_de_usuario 
	INNER JOIN tbl_personas ON accesos_de_usuario.employedCode = tbl_personas.CODIGO_PERSONA
    GROUP BY accesos_de_usuario.employedCode$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `employeesWithoutUser`()
    NO SQL
SELECT 
	CONCAT(
        
		tbl_personas.NOMBRE, ' ', tbl_personas.APELLIDO
	) AS name,
    tbl_personas.CODIGO_PERSONA AS codeE
    FROM

    tbl_personas
    WHERE tbl_personas.CODIGO_PERSONA NOT IN
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
		tbl_personas.NOMBRE, ' ', tbl_personas.APELLIDO
	) AS name, 
	 tbl_personas.CODIGO_PERSONA as codeE, 
	(
		SELECT 
		   tbl_roles.NOMBRE_ROL 
		FROM 
			tbl_roles 
		WHERE 


			tbl_roles.CODIGO_ROL = tbl_personas.CODIGO_ROL
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
			accesos_de_usuario.employedCode = tbl_personas.CODIGO_PERSONA
	) as total 
FROM 
	tbl_personas 
WHERE 
	tbl_personas.CODIGO_PERSONA = (
		SELECT 
			usuarios.codEmpleado 
		FROM 
			usuarios 
		WHERE 
			usuarios.codEmpleado = tbl_personas.CODIGO_PERSONA
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
		tbl_personas.NOMBRE, ' ', tbl_personas.APELLIDO
	) AS name, 
	CONCAT(
	  tbl_personas.NOMBRE, ' ', tbl_personas.APELLIDO
	) AS nameC, 
	tbl_personas.GENERO AS sex, 
	tbl_personas.CODIGO_PERSONA AS codeE, 
	tbl_personas.CORREO_ELECTRONICO AS email, 
	tbl_personas.CODIGO_LOCALIZACION AS direction, 
	tbl_personas.NUMERO_IDENTIDAD AS idCard, 
	tbl_personas.TEL_FIJO AS phoneNumber, 
	tbl_personas.FECHA_NACIMIENTO AS birthDay, 
	(
		SELECT 
			tbl_roles.NOMBRE_ROL 
		FROM 
			tbl_roles
		WHERE 
			tbl_roles.CODIGO_ROL = tbl_personas.CODIGO_ROL
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
	tbl_personas$$

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
		  tbl_personas.CODIGO_ROL 
		FROM 
		   tbl_personas
		where 
			tbl_personas.CODIGO_PERSONA = usuarios.codEmpleado

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
		tbl_personas.NOMBRE, ' ', tbl_personas.APELLIDO
	) AS name, 
	tbl_personas.CODIGO_PERSONA as codeE, 
	(
		SELECT 
			tbl_roles.NOMBRE_ROL 
		FROM 
		   tbl_roles
		WHERE 
			tbl_roles.CODIGO_ROL = tbl_personas.CODIGO_ROL
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
	tbl_personas 
WHERE 
	tbl_personas.CODIGO_PERSONA = (
		SELECT 
			usuarios.codEmpleado 
		FROM 
			usuarios 

		WHERE 
			usuarios.codEmpleado = tbl_personas.CODIGO_PERSONA
	)
ORDER BY log DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEmployed`(IN `users` VARCHAR(4))
    READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'This procedure return all referent the viewEmployed'
SELECT 
	CONCAT(
		tbl_personas.NOMBRE
	) AS name, 
	CONCAT(
		tbl_personas.NOMBRE, ' ', tbl_personas.APELLIDO
	) AS nameC, 
	tbl_personas.GENERO  AS sex, 
	tbl_personas.CODIGO_PERSONA AS codeE, 
	tbl_personas.CORREO_ELECTRONICO AS email, 
	tbl_personas.CODIGO_LOCALIZACION AS direction, 
	tbl_personas.NUMERO_IDENTIDAD AS idCard, 
	tbl_personas.TEL_MOVIL AS phoneNumber, 
	tbl_personas.FECHA_NACIMIENTO AS birthDay, 
	(
		SELECT 
			tbl_roles.NOMBRE_ROL 
		FROM 
			tbl_roles 
		WHERE 
			tbl_roles.CODIGO_ROL = tbl_personas.CODIGO_ROL
	) AS office 
FROM 
	tbl_personas 
WHERE 
	tbl_personas.CODIGO_PERSONA = users$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectUser`(IN `user1` VARCHAR(30))
    READS SQL DATA
SELECT usuarios.status,usuarios.log,usuarios.codEmpleado,usuarios.password,usuarios.userName,
(SELECT tbl_personas.CODIGO_ROL from tbl_personas where tbl_personas.CODIGO_PERSONA = usuarios.codEmpleado) As codRole
from 
usuarios
where 
usuarios.userName = user1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ACTUALIZAR_ESTADO_AULAS`(IN `P_CODIGO_AULA` INT, IN `P_ESTADO` INT)
    MODIFIES SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO ACTUALIZA EL ESTADO DE LAS AULAS '
UPDATE `tbl_aulas` 
SET
	`ESTADO`= P_ESTADO 
WHERE tbl_aulas.CODIGO_AULA = P_CODIGO_AULA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERTAR_ASIGNATURAS`(IN `P_NOMBRE` VARCHAR(35), IN `P_UV` INT, IN `P_REQUISITO` INT)
    NO SQL
INSERT INTO `tbl_clases`
(
    
    `NOMBRE_CLASE`, 
    `REQUISITO`,
    `UV`
)
VALUES (
    
    P_NOMBRE,
    p_REQUISITO,
    P_UV
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERTAR_AULAS`(IN `P_NOMBRE_AULA` VARCHAR(35), IN `P_NUMERO_PISOS` INT, IN `P_CODIGO_EDIFICIO` INT)
    MODIFIES SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO SIRVE PARA INSERTAR AULAS '
INSERT INTO `tbl_aulas`
(
    `NOMBRE_AULA`, 
    `NUMERO_PISO`,
    `CODIGO_EDIFICIO`,
    `ESTADO`) 
VALUES (
    P_NOMBRE_AULA,
    P_NUMERO_PISOS,
    P_CODIGO_EDIFICIO,
    1
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERTAR_CENTROS_REGIONALES`(IN `P_NOMBRE` VARCHAR(35), IN `P_CIUDAD` INT)
    NO SQL
INSERT INTO `tbl_centros_regionales`
(
    `NOMBRE_CENTRO_REGIONAL`, 
    `CODIGO_LOCALIZACION`
)
VALUES 
(
    P_NOMBRE,
    P_CIUDAD
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERTAR_CIUDADES`(IN `P_NOMBRE_CIUDAD` VARCHAR(35), IN `P_ABREVIATURA` VARCHAR(15), IN `P_CODIGO_POSTAL` VARCHAR(15), IN `P_CODIGO_PAIS` INT)
    MODIFIES SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO PERMITE INSERTAR LOCALIZACIONES'
INSERT INTO `tbl_localizaciones`
(
    
    `NOMBRE_CIUDAD`, 
    `ABREVIATURA`, 
    `CODIGO_POSTAL`, 
    `CODIGO_PAIS`
) 
VALUES 
(
   
    P_NOMBRE_CIUDAD,
    P_ABREVIATURA,
    P_CODIGO_POSTAL,
    P_CODIGO_PAIS
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERTAR_EDIFICIOS`(IN `P_NOMBRE_EDIFICIO` VARCHAR(35), IN `P_NUMERO_PISOS` INT, IN `P_CODIGO_CENTRO_REGIONAL` INT, IN `P_AULAS_POR_PISOS` INT)
    MODIFIES SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO INSERTA EDIFICIOS'
INSERT INTO `tbl_edificios`
(
      
    `NOMBRE_EDIFICIO`,
    `NUMERO_PISOS`,
    `CODIGO_CENTRO_REGIONAL`,
    `AULAS_POR_PISO`
) 
VALUES 
(
    P_NOMBRE_EDIFICIO,
    P_NUMERO_PISOS,
    p_CODIGO_CENTRO_REGIONAL,
    P_AULAS_POR_PISOS

)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERTAR_PAISES`(IN `P_NOMBRE_PAIS` VARCHAR(35), IN `P_ABREVIATURA` VARCHAR(15), IN `P_CODIGO_REGION` INT)
    MODIFIES SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO INSERTA EN LA BASE DE DATOS UN PAIS'
INSERT INTO `tbl_paises`
(
     
    `NOMBRE_PAIS`, 
    `ABREVIATURA`, 
    `CODIGO_REGION`
) 
VALUES (
    
    P_NOMBRE_PAIS,
    P_ABREVIATURA,
    P_CODIGO_REGION
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERTAR_REGION`(IN `P_NOMBRE` VARCHAR(35), IN `P_ABREVIATURA` VARCHAR(15))
    MODIFIES SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO INSERTA UN MERCADER'
INSERT INTO tbl_regiones
(
	tbl_regiones.NOMBRE_REGION,
    tbl_regiones.ABREVIATURA
)
VALUES
(
	P_NOMBRE,
    P_ABREVIATURA
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERTAR_SECCIONES`(IN `P_DIAS` VARCHAR(15), IN `P_CODIGO_AULA` INT, IN `P_CODIGO_CLASE` INT, IN `p_CODIGO_HORARIO` INT, IN `P_CODIGO_PERIODO` INT, IN `P_CODIGO_PERSONA` INT)
    MODIFIES SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO SIRVE PARA CREAR SECCIONES'
INSERT INTO `tbl_secciones`
(
    `DIAS`, 
    `CODIGO_AULA`, 
    `CODIGO_CLASE`, 
    `CODIGO_HORARIO`, 
    `CODIGO_PERIODO`, 
    `CODIGO_PERSONA`, 
    `FECHA`) 
VALUES (
    P_DIAS, 
    P_CODIGO_AULA, 
    P_CODIGO_CLASE, 
    P_CODIGO_HORARIO, 
    P_CODIGO_PERIODO, 
    P_CODIGO_PERSONA,
   CURRENT_DATE
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MATRICULA`(IN `P_CODIGO_PERSONA` INT, IN `P_CODIGO_SECCION` INT)
    MODIFIES SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO ALMACENADO SE ENCARGA DE REALIZAR LA MATRICUL'
SELECT * 
FROM tbl_matriculas$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SELECCIONAR_ASIGNATURAS`()
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO SELECCIONA LA INFORMACIÓN DE LAS CLASES'
SELECT tbl_clases.CODIGO_CLASE,
		tbl_clases.NOMBRE_CLASE,
		tbl_clases.REQUISITO,
		tbl_clases.UV
FROM tbl_clases$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SELECCIONAR_CENTROS_REGIONALES`()
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO SE ENCARGA DE MOSTRAR TODOS LOS REGIONALES'
SELECT A.CODIGO_CENTRO_REGIONAL,
		A.NOMBRE_CENTRO_REGIONAL,
		B.ABREVIATURA AS CIUDAD,
		C.ABREVIATURA AS PAIS,
		D.ABREVIATURA AS REGION
FROM tbl_centros_regionales A
LEFT JOIN tbl_localizaciones B 
ON(A.CODIGO_LOCALIZACION=B.CODIGO_LOCALIZACION)
LEFT JOIN tbl_paises C 
ON(B.CODIGO_PAIS=C.CODIGO_PAIS)
LEFT JOIN tbl_regiones D 
ON(C.CODIGO_REGION=D.CODIGO_REGION)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SELECCIONAR_EDIFICIOS`()
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO NOS MUESTRA LOS EDIFICIOS REGISTRADOS'
SELECT tbl_edificios.CODIGO_EDIFICIO,
	   tbl_edificios.NUMERO_PISOS,
	   tbl_edificios.NOMBRE_EDIFICIO,
	   tbl_edificios.CODIGO_CENTRO_REGIONAL
FROM tbl_edificios$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SELECCIONAR_ESTUDIANTES`()
    READS SQL DATA
    COMMENT 'este procedimiento muestra todos los alumnos registrados '
SELECT A.CODIGO_PERSONA,
		A.NOMBRE,
		A.APELLIDO,
		A.TEL_MOVIL,
		A.TEL_FIJO,
		A.CORREO_ELECTRONICO,
		A.NUMERO_IDENTIDAD,
		A.FECHA_NACIMIENTO,
		A.GENERO,
		B.NOMBRE_CIUDAD,
		A.CODIGO_ROL,
		A.estado,
		C.NOMBRE_NIVEL
FROM tbl_personas A
LEFT JOIN tbl_localizaciones B 
ON(A.CODIGO_LOCALIZACION = B.CODIGO_LOCALIZACION)
LEFT JOIN tbl_niveles C
ON(A.CODIGO_NIVEL = C.CODIGO_NIVEL)
WHERE A.CODIGO_ROL = 2$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SELECCIONAR_MAESTROS`()
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO PERMITE VER LOS MAESTROS QUE HAY '
SELECT A.CODIGO_PERSONA,
		A.NOMBRE,
		A.APELLIDO,
		A.TEL_MOVIL,
		A.TEL_FIJO
FROM tbl_personas A
WHERE A.CODIGO_ROL = 3$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SELECCIONAR_PAISES`()
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO ALMACENADO MUESTRA TODOS LOS PAISES  '
SELECT tbl_paises.CODIGO_PAIS,
		tbl_paises.NOMBRE_PAIS,
		tbl_paises.ABREVIATURA,
		tbl_paises.CODIGO_REGION
FROM tbl_paises$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SELECCIONAR_PERIODOS`()
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO MUESTRA LOS PERIODOS '
SELECT tbl_periodos.CODIGO_PERIODO,
		tbl_periodos.PERIODO,
		tbl_periodos.DESCRIPCION_PERIODO
FROM tbl_periodos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SELECCIONAR_REGIONES`()
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO MUESTRA LAS REGIONES '
SELECT tbl_regiones.CODIGO_REGION,
		tbl_regiones.NOMBRE_REGION,
		tbl_regiones.ABREVIATURA
FROM tbl_regiones$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SELECCIONAR_SALONES`()
    READS SQL DATA
    COMMENT 'MUESTRA TODOS LOS SALONES CREADOS HASTA AHORA'
SELECT  tbl_aulas.CODIGO_AULA, 
		tbl_aulas.NOMBRE_AULA,
		tbl_aulas.ESTADO
FROM tbl_aulas$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SELECCIONAR_SECCIONES`()
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO MUESTRA LA INFORMACION DE LAS SECCIONES '
SELECT A.CODIGO_SECCION,
		B.NOMBRE_AULA,
		C.NOMBRE_CLASE,
		F.NOMBRE,
		D.HORA_INICIO,
		D.HORA_FIN,
		E.PERIODO,
		A.DIAS,
		A.FECHA
FROM tbl_secciones A
LEFT JOIN tbl_aulas B
ON(A.CODIGO_AULA = B.CODIGO_AULA)
LEFT JOIN tbl_clases C
ON(A.CODIGO_CLASE = C.CODIGO_CLASE)
LEFT JOIN tbl_horarios D
ON(A.CODIGO_HORARIO = D.CODIGO_HORARIO)
LEFT JOIN tbl_periodos E
ON(A.CODIGO_PERIODO = E.CODIGO_PERIODO)
LEFT JOIN tbl_personas F
ON(A.CODIGO_PERSONA = F.CODIGO_PERSONA)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VER_AULAS`(IN `P_CODIGO_AULA` INT)
    READS SQL DATA
    COMMENT 'CON ESTE PROCEDIMIENTO SELECCIONAMOS UN AULA ESPECIFICA'
SELECT A.NOMBRE_AULA,
		B.NOMBRE_EDIFICIO,
		A.ESTADO
FROM tbl_aulas A 
LEFT JOIN tbl_edificios B
ON(A.CODIGO_EDIFICIO=B.CODIGO_EDIFICIO)
WHERE A.CODIGO_AULA = P_CODIGO_AULA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VER_AULAS_X_EDIFICIO`(IN `P_CODIGO_EDIFICIO` INT)
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO MUESTRA LAS AULAS POR EDIFICIO'
SELECT tbl_aulas.CODIGO_AULA,
		tbl_aulas.NOMBRE_AULA,
		tbl_aulas.NUMERO_PISO,
		tbl_aulas.ESTADO
FROM tbl_aulas 
WHERE tbl_aulas.CODIGO_EDIFICIO = P_CODIGO_EDIFICIO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VER_CENTROS_REGIONALES`()
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO MUESTRA LOS CENTROS REGIONALES REGISTRADOS'
SELECT tbl_centros_regionales.CODIGO_CENTRO_REGIONAL,
		tbl_centros_regionales.NOMBRE_CENTRO_REGIONAL,
		tbl_centros_regionales.CODIGO_LOCALIZACION
FROM tbl_centros_regionales$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VER_DATOS_ASIGNATURAS`(IN `P_CODIGO_ASIGNATURA` INT)
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO MUESTRA LOS DATOS DE LAS CLASES'
SELECT A.CODIGO_CLASE,
		A.NOMBRE_CLASE,
		(SELECT B.NOMBRE_CLASE 
         FROM tbl_clases B
         WHERE B.CODIGO_CLASE = A.REQUISITO) AS REQUISITO,
		A.UV
FROM tbl_clases A
WHERE A.CODIGO_CLASE = P_CODIGO_ASIGNATURA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VER_DATOS_CENTROS_REGIONALES`(IN `P_CODIGO_CENTRO_REGIONAL` INT)
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO SELECCIONA UN CENTRO REGIONAL ESPECIFICO'
SELECT A.CODIGO_CENTRO_REGIONAL,
		A.NOMBRE_CENTRO_REGIONAL AS CENTRO,
		B.ABREVIATURA AS CIUDAD,
		C.ABREVIATURA AS PAIS,
		D.ABREVIATURA AS REGION
FROM tbl_centros_regionales A
LEFT JOIN tbl_localizaciones B 
ON(A.CODIGO_LOCALIZACION=B.CODIGO_LOCALIZACION)
LEFT JOIN tbl_paises C 
ON(B.CODIGO_PAIS=C.CODIGO_PAIS)
LEFT JOIN tbl_regiones D 
ON(C.CODIGO_REGION=D.CODIGO_REGION)
WHERE A.CODIGO_CENTRO_REGIONAL = P_CODIGO_CENTRO_REGIONAL$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VER_DATOS_CIUDADES`(IN `P_CODIGO_LOCALIZACION` INT)
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO MUESTRA UNA LOCALIZACION ESPECIFICA'
SELECT  A.CODIGO_LOCALIZACION,
		A.NOMBRE_CIUDAD,
		A.ABREVIATURA,
		A.CODIGO_POSTAL,
		B.NOMBRE_PAIS
FROM tbl_localizaciones A 
LEFT JOIN tbl_paises B
ON(A.CODIGO_PAIS = B.CODIGO_PAIS)
WHERE A.CODIGO_LOCALIZACION = P_CODIGO_LOCALIZACION$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VER_DATOS_EDIFICIO`(IN `P_CODIGO_EDIFICIO` INT)
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO MUESTRA LA INFORMACION DE LOS EDIFICIOS'
SELECT A.CODIGO_EDIFICIO,
		A.NUMERO_PISOS,
		A.NOMBRE_EDIFICIO,
		B.NOMBRE_CENTRO_REGIONAL AS CODIGO_CENTRO_REGIONAL
FROM tbl_edificios A
LEFT JOIN tbl_centros_regionales B
ON(A.CODIGO_CENTRO_REGIONAL = B.CODIGO_CENTRO_REGIONAL)
WHERE A.CODIGO_EDIFICIO = P_CODIGO_EDIFICIO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VER_DATOS_MAESTRO`(IN `P_CODIGO_MAESTRO` INT)
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO SELECCIONA LOS DATOS DE UN MAESTRO'
SELECT A.CODIGO_PERSONA,
		A.NOMBRE,
		A.APELLIDO,
		A.TEL_MOVIL,
		A.TEL_FIJO
FROM tbl_personas A
WHERE tbl_personas = P_CODIGO_MAESTRO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VER_DATOS_PAIS`(IN `P_CODIGO_PAIS` INT)
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO MUESTRA LOS DATOS DE UN PAIS '
SELECT tbl_paises.CODIGO_PAIS,
		tbl_paises.NOMBRE_PAIS,
		tbl_paises.ABREVIATURA,
		tbl_paises.CODIGO_REGION
FROM tbl_paises
WHERE tbl_paises.CODIGO_PAIS = P_CODIGO_PAIS$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VER_DATOS_REGION`(IN `P_CODIGO_REGION` INT)
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO MUESTRA LOS DATOS DE UNA REGION ESPECIFICA '
SELECT tbl_regiones.CODIGO_REGION,
		tbl_regiones.NOMBRE_REGION,
		tbl_regiones.ABREVIATURA
FROM tbl_regiones
WHERE tbl_regiones.CODIGO_REGION = P_CODIGO_REGION$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VER_DATOS_SECCIONES`(IN `P_CODIGO_SECCION` INT)
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO MUESTRA LA INFORMACION DE UNA SECCION ESPECIF'
SELECT A.CODIGO_SECCION,
		B.NOMBRE_AULA,
		C.NOMBRE_CLASE,
		D.HORA_INICIO,
		D.HORA_FIN,
		E.PERIODO,
		A.DIAS,
		G.NOMBRE,
		YEAR(A.FECHA) AS AñO,
		F.NOMBRE_EDIFICIO
FROM tbl_secciones A
LEFT JOIN tbl_aulas B
ON(A.CODIGO_AULA = B.CODIGO_AULA)
LEFT JOIN tbl_clases C
ON(A.CODIGO_CLASE = C.CODIGO_CLASE)
LEFT JOIN tbl_horarios D
ON(A.CODIGO_HORARIO = D.CODIGO_HORARIO)
LEFT JOIN tbl_periodos E
ON(A.CODIGO_PERIODO = E.CODIGO_PERIODO)
LEFT JOIN tbl_edificios F
ON(B.CODIGO_EDIFICIO = F.CODIGO_EDIFICIO)
LEFT JOIN tbl_personas G
ON(A.CODIGO_PERSONA = G.CODIGO_PERSONA)
WHERE A.CODIGO_SECCION = P_CODIGO_SECCION$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VER_HORARIOS`()
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO MUESTRA LOS HORARIOS'
SELECT tbl_horarios.CODIGO_HORARIO,
		tbl_horarios.HORA_INICIO,
		tbl_horarios.HORA_FIN
FROM tbl_horarios$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VER_LOCALIZACIONES`()
    READS SQL DATA
    COMMENT 'ESTE PROCEDIMIENTO MUESTRA INFORMACION DE LOCALIZACION'
SELECT tbl_localizaciones.CODIGO_LOCALIZACION,
		tbl_localizaciones.NOMBRE_CIUDAD,
		tbl_localizaciones.ABREVIATURA
FROM tbl_localizaciones$$

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
				tbl_personas.NOMBRE, ' ',tbl_personas.APELLIDO
			) 
		FROM 
		 tbl_personas 
		WHERE 
			tbl_personas.CODIGO_PERSONA = codeE
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
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=latin1;

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
('3', '2015-09-21 18:27:44', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 44),
('1', '2015-09-26 08:42:06', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 45),
('3', '2015-09-26 08:43:27', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 46),
('2', '2015-09-26 08:43:54', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 47),
('3', '2015-09-26 20:18:22', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 48),
('2', '2015-09-26 20:22:11', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 49),
('2', '2015-09-30 08:15:53', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 50),
('3', '2015-09-30 08:16:20', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 51),
('1', '2015-09-30 08:16:43', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 52),
('4', '2015-09-30 08:18:03', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 53),
('3', '2015-09-30 08:18:19', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 54),
('1', '2015-09-30 08:18:32', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 55),
('1', '2015-09-30 08:18:56', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 56),
('3', '2015-09-30 08:21:29', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 57),
('2', '2015-10-08 19:51:22', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 58),
('2', '2015-10-08 20:15:05', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 59),
('2', '2015-10-08 20:27:01', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 60),
('2', '2015-10-21 09:42:31', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 61),
('2', '2015-10-21 09:43:16', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 62),
('2', '2015-10-21 09:52:59', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 63),
('3', '2015-11-03 10:06:27', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 64),
('3', '2015-11-03 12:16:32', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 65),
('3', '2015-11-03 13:42:04', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 66),
('2', '2015-11-03 13:59:17', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 67),
('3', '2015-11-03 18:33:49', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 68),
('3', '2015-11-03 22:10:09', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 69),
('3', '2015-11-04 08:49:04', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 70),
('3', '2015-11-04 08:55:42', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 71),
('2', '2015-11-04 08:59:05', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 72),
('1', '2015-11-04 09:01:12', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 73),
('3', '2015-11-04 10:15:08', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 74),
('3', '2015-11-04 10:28:34', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 75),
('3', '2015-11-04 10:46:17', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 76),
('1', '2015-11-04 10:49:29', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 77),
('2', '2015-11-04 10:49:50', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 78),
('3', '2015-11-04 10:51:15', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 79),
('3', '2015-11-04 12:14:35', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 80),
('3', '2015-11-04 18:34:39', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 81),
('3', '2015-11-04 21:57:51', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 82),
('3', '2015-11-05 08:19:50', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 83),
('3', '2015-11-06 14:53:15', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 84),
('1', '2015-11-06 14:55:13', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 85),
('2', '2015-11-06 14:55:33', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 86),
('3', '2015-11-06 16:50:01', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 87),
('2', '2015-11-06 17:18:57', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 88),
('3', '2015-11-10 23:28:01', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 89),
('1', '2015-11-11 08:25:58', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 90),
('3', '2015-11-11 08:26:52', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 91),
('3', '2015-11-11 08:33:05', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 92),
('3', '2015-11-11 14:39:13', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 93),
('1', '2015-11-11 14:39:33', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 94),
('3', '2015-11-11 23:03:09', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 95),
('3', '2015-11-12 23:14:13', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 96),
('3', '2015-11-13 18:32:49', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 97),
('3', '2015-11-13 23:22:59', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 98),
('3', '2015-11-14 09:24:21', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 99),
('3', '2015-11-14 17:32:39', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 100),
('3', '2015-11-14 19:27:48', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 101),
('3', '2015-11-14 19:29:16', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 102),
('3', '2015-11-14 19:38:08', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 103),
('3', '2015-11-14 19:50:39', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 104),
('3', '2015-11-15 01:16:49', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 105),
('3', '2015-11-16 09:19:44', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 106),
('3', '2015-11-16 11:23:31', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 107),
('3', '2015-11-17 21:07:07', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 108),
('3', '2015-11-18 18:27:19', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 109),
('3', '2015-11-19 10:32:27', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 110),
('3', '2015-11-19 11:22:11', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 111),
('3', '2015-11-19 23:04:14', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 112),
('3', '2015-11-19 23:20:54', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 113),
('3', '2015-11-20 10:24:53', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 114),
('3', '2015-11-20 12:04:10', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 115),
('3', '2015-11-20 14:51:35', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 116),
('3', '2015-11-21 08:06:49', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 117),
('3', '2015-11-21 20:58:30', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 118),
('3', '2015-11-22 13:52:11', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 119),
('3', '2015-11-23 21:50:41', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 120),
('3', '2015-11-24 08:30:08', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 121),
('3', '2015-11-24 22:54:02', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 122),
('3', '2015-11-25 18:45:51', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 123),
('3', '2015-11-25 22:43:52', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 124),
('3', '2015-11-26 08:51:45', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 125),
('3', '2015-11-26 10:47:08', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 126),
('3', '2015-12-02 18:52:11', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 127),
('3', '2015-12-08 12:09:34', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 128),
('3', '2015-12-16 18:47:44', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 129),
('1', '2015-12-16 23:52:50', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 130),
('3', '2015-12-16 23:53:32', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 131),
('1657', '2015-12-17 00:35:06', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 132),
('1657', '2015-12-17 00:37:55', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 133),
('1657', '2015-12-17 01:10:43', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 134),
('1657', '2015-12-17 01:15:19', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 135),
('1657', '2015-12-17 20:13:38', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 136),
('1657', '2015-12-17 20:31:40', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 137),
('1657', '2015-12-17 20:36:59', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 138),
('1657', '2015-12-17 20:48:19', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 139),
('1657', '2015-12-17 20:50:37', '::1', '0000-00-00 00:00:00', 'Inicio de sesión', 140);

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
-- Estructura de tabla para la tabla `niveles`
--

CREATE TABLE IF NOT EXISTS `niveles` (
  `CODIGO_NIVEL` int(11) NOT NULL,
  `CODIGO_PERSONA` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `niveles`
--

INSERT INTO `niveles` (`CODIGO_NIVEL`, `CODIGO_PERSONA`) VALUES
(0, 1),
(6, 2),
(1, 3),
(1, 4),
(4, 5),
(13, 6),
(3, 7),
(12, 8),
(12, 9),
(12, 10),
(2, 11),
(2, 12),
(2, 13),
(1, 14),
(5, 15),
(12, 16),
(6, 17),
(14, 18),
(2, 19),
(3, 20),
(12, 21),
(4, 22),
(1, 23),
(2, 24),
(13, 25),
(2, 26),
(5, 27),
(12, 28),
(12, 29),
(2, 30),
(2, 31),
(2, 32),
(4, 33),
(14, 34),
(2, 35),
(4, 36),
(2, 37),
(2, 38),
(1, 39),
(5, 40),
(4, 41),
(5, 42),
(4, 43),
(2, 44),
(7, 45),
(4, 46),
(4, 47),
(4, 48),
(3, 49),
(3, 50),
(2, 51),
(4, 52),
(2, 53),
(12, 54),
(5, 55),
(2, 56),
(14, 57),
(5, 58),
(7, 59),
(4, 60),
(6, 61),
(5, 62),
(6, 63),
(12, 64),
(2, 65),
(2, 66),
(2, 67),
(7, 68),
(5, 69),
(13, 70),
(1, 71),
(3, 72),
(1, 73),
(1, 74),
(1, 75),
(4, 76),
(1, 77),
(3, 78),
(1, 79),
(5, 80),
(14, 81),
(1, 82),
(4, 83),
(5, 84),
(6, 85),
(7, 86),
(2, 87),
(14, 88),
(14, 89),
(5, 90),
(5, 91),
(6, 92),
(6, 93),
(5, 94),
(2, 95),
(12, 96),
(5, 97),
(4, 98),
(11, 99),
(14, 100),
(3, 101),
(14, 102),
(14, 103),
(3, 104),
(6, 105),
(2, 106),
(12, 107),
(3, 108),
(7, 109),
(4, 110),
(6, 111),
(6, 112),
(5, 113),
(7, 114),
(2, 115),
(6, 116),
(5, 117),
(7, 118),
(5, 119),
(5, 120),
(12, 121),
(4, 122),
(7, 123),
(4, 124),
(1, 125),
(6, 126),
(4, 127),
(4, 128),
(4, 129),
(12, 130),
(12, 131),
(1, 132),
(14, 133),
(3, 134),
(6, 135),
(6, 136),
(1, 137),
(5, 138),
(3, 139),
(7, 140),
(5, 141),
(18, 142),
(5, 143),
(5, 144),
(7, 145),
(2, 146),
(7, 147),
(11, 148),
(12, 149),
(3, 150),
(7, 151),
(4, 152),
(15, 153),
(2, 154),
(2, 155),
(14, 156),
(2, 157),
(7, 158),
(4, 159),
(4, 160),
(14, 161),
(1, 162),
(4, 163),
(2, 164),
(2, 165),
(3, 166),
(11, 167),
(14, 168),
(13, 169),
(1, 170),
(12, 171),
(18, 172),
(18, 173),
(2, 174),
(3, 175),
(12, 176),
(6, 177),
(7, 178),
(7, 179),
(15, 180),
(1, 181),
(4, 182),
(2, 183),
(4, 184),
(1, 185),
(5, 186),
(18, 187),
(15, 188),
(18, 189),
(18, 190),
(2, 191),
(3, 192),
(1, 193),
(18, 194),
(6, 195),
(18, 196),
(18, 197),
(2, 198),
(12, 199),
(13, 200),
(5, 201),
(7, 202),
(2, 203),
(2, 204),
(7, 205),
(2, 206),
(1, 207),
(7, 208),
(13, 209),
(11, 210),
(12, 211),
(7, 212),
(13, 213),
(7, 214),
(7, 215),
(4, 216),
(3, 217),
(1, 218),
(18, 219),
(2, 220),
(18, 221),
(6, 222),
(12, 223),
(5, 224),
(12, 225),
(6, 226),
(3, 227),
(18, 228),
(3, 229),
(3, 230),
(3, 231),
(2, 232),
(18, 233),
(3, 234),
(15, 235),
(18, 236),
(7, 237),
(7, 238),
(4, 239),
(14, 240),
(3, 241),
(3, 242),
(3, 243),
(3, 244),
(3, 245),
(2, 246),
(2, 247),
(18, 248),
(12, 249),
(3, 250),
(13, 251),
(18, 252),
(4, 253),
(12, 254),
(2, 255),
(18, 256),
(4, 257),
(3, 258),
(18, 259),
(13, 260),
(11, 261),
(4, 262),
(3, 263),
(4, 264),
(4, 265),
(5, 266),
(2, 267),
(12, 268),
(18, 269),
(7, 270),
(14, 271),
(14, 272),
(18, 273),
(4, 274),
(6, 275),
(2, 276),
(12, 277),
(15, 278),
(2, 279),
(5, 280),
(1, 281),
(18, 282),
(7, 283),
(4, 284),
(14, 285),
(2, 286),
(4, 287),
(18, 288),
(3, 289),
(18, 290),
(18, 291),
(7, 292),
(5, 293),
(14, 294),
(4, 295),
(14, 296),
(4, 297),
(3, 298),
(3, 299),
(3, 300),
(3, 301),
(6, 302),
(14, 303),
(2, 304),
(11, 305),
(3, 306),
(3, 307),
(18, 308),
(14, 309),
(14, 310),
(14, 311),
(5, 312),
(13, 313),
(2, 314),
(2, 315),
(2, 316),
(11, 317),
(12, 318),
(14, 319),
(4, 320),
(2, 321),
(2, 322),
(15, 323),
(13, 324),
(15, 325),
(18, 326),
(15, 327),
(11, 328),
(2, 329),
(1, 330),
(15, 331),
(7, 332);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_aulas`
--

CREATE TABLE IF NOT EXISTS `tbl_aulas` (
  `CODIGO_AULA` int(11) NOT NULL,
  `NOMBRE_AULA` varchar(20) NOT NULL,
  `NUMERO_PISO` int(11) NOT NULL,
  `CODIGO_EDIFICIO` int(11) NOT NULL,
  `ESTADO` int(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_aulas`
--

INSERT INTO `tbl_aulas` (`CODIGO_AULA`, `NOMBRE_AULA`, `NUMERO_PISO`, `CODIGO_EDIFICIO`, `ESTADO`) VALUES
(1, '401', 4, 1, 1),
(2, '406', 4, 1, 1),
(3, '408', 4, 2, 1),
(4, '307', 3, 3, 1),
(5, '306', 3, 4, 1),
(6, '307', 3, 4, 1),
(7, '309', 3, 5, 1),
(8, '301', 3, 1, 1),
(17, '101', 2, 1, 1),
(18, '301', 1, 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_centros_regionales`
--

CREATE TABLE IF NOT EXISTS `tbl_centros_regionales` (
  `CODIGO_CENTRO_REGIONAL` int(11) NOT NULL,
  `NOMBRE_CENTRO_REGIONAL` varchar(35) NOT NULL,
  `CODIGO_LOCALIZACION` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_centros_regionales`
--

INSERT INTO `tbl_centros_regionales` (`CODIGO_CENTRO_REGIONAL`, `NOMBRE_CENTRO_REGIONAL`, `CODIGO_LOCALIZACION`) VALUES
(1, 'UNAH', 1),
(2, 'CEUTEC', 1),
(3, 'UTH', 1),
(4, 'UNITEC', 1),
(6, 'CIUDAD UNIVERSITARIA', 1),
(7, 'UPI', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_clases`
--

CREATE TABLE IF NOT EXISTS `tbl_clases` (
  `CODIGO_CLASE` int(11) NOT NULL,
  `NOMBRE_CLASE` varchar(35) NOT NULL,
  `REQUISITO` int(11) NOT NULL,
  `UV` int(11) NOT NULL,
  `CODIGO` varchar(6) NOT NULL,
  `CODIGO_NIVEL` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_clases`
--

INSERT INTO `tbl_clases` (`CODIGO_CLASE`, `NOMBRE_CLASE`, `REQUISITO`, `UV`, `CODIGO`, `CODIGO_NIVEL`) VALUES
(1, 'Japones 1', 0, 0, '', 0),
(2, 'Japones 2', 1, 0, '', 0),
(3, 'Japones 3', 2, 0, '', 0),
(4, 'Japones 4', 3, 0, '', 0),
(5, 'Japones 5', 4, 0, '', 0),
(6, 'Japones 6', 5, 0, '', 0),
(7, 'Japones 7', 6, 0, '', 0),
(8, 'Japones 8', 7, 0, '', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_edificios`
--

CREATE TABLE IF NOT EXISTS `tbl_edificios` (
  `CODIGO_EDIFICIO` int(11) NOT NULL,
  `NOMBRE_EDIFICIO` varchar(20) NOT NULL,
  `NUMERO_PISOS` int(11) NOT NULL,
  `CODIGO_CENTRO_REGIONAL` int(11) NOT NULL,
  `AULAS_POR_PISO` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_edificios`
--

INSERT INTO `tbl_edificios` (`CODIGO_EDIFICIO`, `NOMBRE_EDIFICIO`, `NUMERO_PISOS`, `CODIGO_CENTRO_REGIONAL`, `AULAS_POR_PISO`) VALUES
(1, 'B1', 4, 1, 0),
(2, 'B2', 4, 1, 0),
(3, 'C1', 4, 1, 0),
(4, 'C2', 4, 1, 0),
(5, 'F1', 4, 1, 0),
(6, 'D1', 4, 1, 0),
(7, 'J1', 4, 1, 12),
(8, 'E1', 4, 1, 12),
(9, 'A1', 4, 1, 12),
(10, 'C3', 4, 1, 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_historiales`
--

CREATE TABLE IF NOT EXISTS `tbl_historiales` (
  `CODIGO_HISTORIAL` int(11) NOT NULL,
  `NOTA` int(11) NOT NULL,
  `OBSERVACION` varchar(10) NOT NULL,
  `CODIGO_MATRICULA` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_horarios`
--

CREATE TABLE IF NOT EXISTS `tbl_horarios` (
  `CODIGO_HORARIO` int(11) NOT NULL,
  `HORA_INICIO` time NOT NULL,
  `HORA_FIN` time NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_horarios`
--

INSERT INTO `tbl_horarios` (`CODIGO_HORARIO`, `HORA_INICIO`, `HORA_FIN`) VALUES
(1, '08:00:00', '10:00:00'),
(2, '10:00:00', '12:00:00'),
(3, '12:30:00', '14:30:00'),
(4, '15:00:00', '17:00:00'),
(5, '16:00:00', '18:00:00'),
(6, '17:00:00', '19:00:00'),
(7, '18:00:00', '20:00:00'),
(8, '18:15:00', '20:15:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_localizaciones`
--

CREATE TABLE IF NOT EXISTS `tbl_localizaciones` (
  `CODIGO_LOCALIZACION` int(11) NOT NULL,
  `NOMBRE_CIUDAD` varchar(35) NOT NULL,
  `ABREVIATURA` varchar(10) NOT NULL,
  `CODIGO_POSTAL` int(11) NOT NULL,
  `CODIGO_PAIS` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_localizaciones`
--

INSERT INTO `tbl_localizaciones` (`CODIGO_LOCALIZACION`, `NOMBRE_CIUDAD`, `ABREVIATURA`, `CODIGO_POSTAL`, `CODIGO_PAIS`) VALUES
(1, 'Tegucigalpa', 'TGU', 10111, 1),
(2, 'Comayaguela ', 'CY', 11012, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_matriculas`
--

CREATE TABLE IF NOT EXISTS `tbl_matriculas` (
  `CODIGO_MATRICULA` int(11) NOT NULL,
  `FECHA` date NOT NULL,
  `CODIGO_SECCION` int(11) NOT NULL,
  `CODIGO_PERSONA` int(11) NOT NULL,
  `CODIGO_PERIODO` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_niveles`
--

CREATE TABLE IF NOT EXISTS `tbl_niveles` (
  `CODIGO_NIVEL` int(11) NOT NULL,
  `NOMBRE_NIVEL` varchar(15) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_niveles`
--

INSERT INTO `tbl_niveles` (`CODIGO_NIVEL`, `NOMBRE_NIVEL`) VALUES
(1, 'JP1'),
(2, 'JP2'),
(3, 'JP3'),
(4, 'JP4'),
(5, 'JP5'),
(6, 'JP6'),
(7, 'JP7'),
(8, 'JP8');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_paises`
--

CREATE TABLE IF NOT EXISTS `tbl_paises` (
  `CODIGO_PAIS` int(11) NOT NULL,
  `NOMBRE_PAIS` varchar(35) NOT NULL,
  `ABREVIATURA` varchar(10) NOT NULL,
  `CODIGO_REGION` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_paises`
--

INSERT INTO `tbl_paises` (`CODIGO_PAIS`, `NOMBRE_PAIS`, `ABREVIATURA`, `CODIGO_REGION`) VALUES
(1, 'Honduras', 'HN', 1),
(2, 'Guatemala', 'GT', 1),
(3, 'España', 'ES', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_periodos`
--

CREATE TABLE IF NOT EXISTS `tbl_periodos` (
  `CODIGO_PERIODO` int(11) NOT NULL,
  `PERIODO` int(11) NOT NULL,
  `DESCRIPCION_PERIODO` varchar(90) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_periodos`
--

INSERT INTO `tbl_periodos` (`CODIGO_PERIODO`, `PERIODO`, `DESCRIPCION_PERIODO`) VALUES
(1, 1, 'Primer periodo'),
(2, 2, 'Segundo periodo'),
(3, 3, 'Tercer periodo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_personas`
--

CREATE TABLE IF NOT EXISTS `tbl_personas` (
  `CODIGO_PERSONA` int(11) NOT NULL,
  `NOMBRE` varchar(35) NOT NULL,
  `APELLIDO` varchar(35) NOT NULL,
  `TEL_MOVIL` int(11) DEFAULT NULL,
  `TEL_FIJO` int(11) DEFAULT NULL,
  `CORREO_ELECTRONICO` varchar(60) NOT NULL,
  `NUMERO_IDENTIDAD` int(11) NOT NULL,
  `FECHA_NACIMIENTO` date NOT NULL,
  `GENERO` varchar(1) NOT NULL,
  `CODIGO_LOCALIZACION` int(11) NOT NULL,
  `CODIGO_ROL` int(11) NOT NULL,
  `estado` varchar(1) NOT NULL,
  `CODIGO_NIVEL` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1658 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_personas`
--

INSERT INTO `tbl_personas` (`CODIGO_PERSONA`, `NOMBRE`, `APELLIDO`, `TEL_MOVIL`, `TEL_FIJO`, `CORREO_ELECTRONICO`, `NUMERO_IDENTIDAD`, `FECHA_NACIMIENTO`, `GENERO`, `CODIGO_LOCALIZACION`, `CODIGO_ROL`, `estado`, `CODIGO_NIVEL`) VALUES
(1326, 'Fabio', 'Vasquez', 9895, 0, 'fcvasco2003@yahoo.com', 0, '2015-09-01', '', 1, 2, 's', 2),
(1327, 'marta Elena', 'Mendoza Diaz', 33349627, 0, 'marta.e.mendoza@gmail.com', 0, '2015-09-01', '', 1, 2, 'n', 1),
(1328, 'Maria', 'Perez Lopez', 220000, 800000, 'Perez', 0, '2015-09-01', '', 1, 2, 'n', 1),
(1329, 'Angel Daniel', 'Garcia Sierra', 88290429, 22555943, 'adgs1999@gmail.com', 0, '1999-04-10', '', 1, 2, 's', 1),
(1330, 'Stephanie Elizabeth', 'Reyes Rodriguez', 3337, 2227, 'histephy@hotmail.com', 0, '2015-09-01', '', 1, 2, 's', 3),
(1331, 'Kendy alexandra', 'Sanchez lozano', 0, 22454275, 'sanchezkendy@hotmail.com', 0, '1986-01-25', '', 1, 2, 'n', 1),
(1332, 'Francisco Jos&Atilde;&copy;', 'Mendoza', 32460153, 22461229, 'josebendavid77@gmail.com', 0, '2015-09-02', '', 1, 2, 's', 3),
(1333, 'Melissa Alejandra', 'Menjivar Cerrato', 89377061, 22348100, 'melissamenjivarc@gmail.com', 0, '1995-08-21', '', 1, 2, 's', 3),
(1334, 'Daniel Ernesto', 'Sierra Argueta', 89553286, 22271153, 'dsierraplantae@yahoo.com', 0, '1990-09-23', '', 1, 2, 's', 3),
(1335, 'Leonardo', 'Henriquez Alvares', 99224710, 22387775, 'leonardoandroid404@gmail.com', 0, '1997-11-25', '', 1, 2, 's', 1),
(1336, 'Alannis Itxel', 'Maradiaga Irias ', 96840270, 22310743, 'xbeyonddreams@hotmail.com', 0, '1996-09-24', '', 1, 2, 's', 1),
(1337, 'PAOLA MARIA ', 'MARTINEZ ALVARENGA', 32034491, 22369497, 'paomariam@gmail.com', 0, '1988-09-21', '', 1, 2, 's', 1),
(1338, 'Suyen ', 'Figueroa L&Atilde;&sup3;pez ', 88393411, 0, 'Lunnalopez@yahoo.com ', 0, '1993-10-11', '', 1, 2, 'n', 1),
(1339, 'Gerlla ', 'Aragon Torres ', 504, 22552567, 'gerllaaragon@gmail.com', 0, '2015-09-02', '', 1, 2, 's', 2),
(1340, 'Nicolle Nilannethe', 'Guill&Atilde;&copy;n Alvarenga', 32381951, 0, 'niconisasuke@hotmail.com', 0, '1989-10-18', '', 1, 2, 's', 3),
(1341, 'samira', 'lupiac', 0, 32553998, 'salupiac@gmail.com', 0, '1989-07-26', '', 1, 2, 's', 2),
(1342, 'Flor Idalma', 'Escalon', 96020337, 2225, 'flories91@hotmail.com', 0, '1991-10-30', '', 1, 2, 's', 4),
(1343, 'Jazziel ElKanah&Atilde;&iexcl;n ', 'Baca Rodriguez', 95194934, 22552359, 'elkanahan@gmail.com', 0, '2015-10-05', '', 1, 2, 's', 1),
(1344, 'CLAUDIA PAOLA', 'GODOY AVILA', 89746428, 22573205, 'paolaavila2000@yahoo.com', 0, '1979-12-12', '', 1, 2, 's', 1),
(1345, 'Eduardo', 'Caffoll Lagos', 95135621, 22306644, 'caffoll_12@hotmail.com', 0, '1997-11-11', '', 1, 2, 's', 3),
(1346, 'Wenceslao', 'Bejarano Torres', 99763825, 22332727, 'bejarano_wen@hotmail.com', 0, '1998-10-15', '', 1, 2, 's', 1),
(1347, 'Ana ', 'Thompson', 88008894, 22832588, 'Anacthompsong@yahoo.com', 0, '1998-09-29', '', 1, 2, 'n', 1),
(1348, 'Luis', 'Osorto', 97851848, 0, 'Kichigo53@hotmail.com', 0, '1998-03-29', '', 1, 2, 's', 1),
(1349, 'Dayan Mishell', 'Pichardo Lopez', 95714846, 22454071, 'mishell_pichardo@yahoo.com', 0, '1986-07-07', '', 1, 2, 's', 3),
(1350, 'Alvaro Felipe', 'Albornoz Perez', 98858877, 22369848, 'dr.alvaroalbornoz@gmail.com', 0, '1973-11-19', '', 1, 2, 's', 1),
(1351, 'Karim Naydalis', 'L&Atilde;&sup3;pez', 95799968, 22344679, 'naydalislopez@gmail.com', 0, '1999-10-22', '', 1, 2, 's', 2),
(1352, 'Jose Manuel ', 'Alvarado Gomez', 98394648, 0, 'ing.civil.alvarado@gmqil.com', 0, '1984-09-05', '', 1, 2, 's', 3),
(1353, 'Nadia Melissa', 'Cruz Elvir', 94880510, 0, 'ing.civil.nadiacruz@gmail.com', 0, '1984-08-30', '', 1, 2, 's', 3),
(1354, 'Karim ', 'L&Atilde;ƒ&Acirc;&sup3;pez Bahr', 95799968, 22344679, 'naydalislopez@gmail.com', 0, '1999-10-22', '', 1, 2, 's', 1),
(1355, 'Carlos Jos&Atilde;&copy; ', 'Canales Almendares', 99181785, 2228, 'carlos_canales89@hotmail.com', 0, '1989-03-25', '', 1, 2, 's', 1),
(1356, 'Josselyn Mayt&Atilde;&copy;', 'Mej&Atilde;&shy;a Fern&Atilde;&iexc', 9576, 2255, 'carlos_canales89@hotmail.com', 0, '1992-04-03', '', 1, 2, 's', 1),
(1357, 'Alberto Josu&Atilde;&copy;', 'Ponce Barrientos', 9976, 0, 'apcreativo86@gmail.com', 0, '1986-11-03', '', 1, 2, 's', 1),
(1358, 'Melania ', 'Discua', 95288700, 0, 'mdiscua@gmail.com', 0, '1990-09-01', '', 1, 2, 's', 4),
(1359, 'katerin Sarai', 'Lagos Maradiaga', 88852269, 22308430, 'katita_lagos@hotmail.com', 0, '1993-04-01', '', 1, 2, 's', 1),
(1360, 'Angelica ', 'Echeverria', 96995424, 22292024, 'angiclau12@yahoo.com', 0, '1998-05-15', '', 1, 2, 's', 1),
(1361, 'Ana', 'Thompson G&Atilde;&iexcl;lvez', 88008894, 22832588, 'Anacthompsong@yahoo.com', 0, '1998-07-29', '', 1, 2, 's', 1),
(1362, 'Jorge', 'Guerrero', 98839025, 0, 'Jorgeguerrerof@yahoo.com', 0, '1998-02-17', '', 1, 2, 's', 1),
(1363, 'Yesica Dioxana ', 'Lanza Rodriguez', 0, 0, 'dioxa305@yahoo.com', 0, '1986-05-30', '', 1, 2, 'n', 1),
(1364, 'Ana Carolina', 'Vindel Rojas', 32753181, 0, 'av_anine@hotmail.es', 0, '2015-09-06', '', 1, 2, 's', 2),
(1365, 'Katherine Steffyn', 'Hernandez Nu&Atilde;&plusmn;ez', 31707815, 22136397, 'kshernandez90@gmail.com', 0, '1990-07-25', '', 1, 2, 's', 1),
(1366, 'Katherine Nicolle', 'Aguilar Lopez', 88839086, 22570541, 'nicolle.aguilar@hotmail.com', 0, '1997-03-09', '', 1, 2, 's', 2),
(1367, 'Ana Marcela ', 'Lanza Sandres', 31909930, 27790417, 'ana.march08@gmail.com', 0, '1991-01-08', '', 1, 2, 's', 1),
(1368, 'Luis', 'Turcios L&Atilde;&sup3;pez', 96252654, 0, 'luis_td_tpp@hotmail.com', 0, '1993-08-01', '', 1, 2, 's', 1),
(1369, 'Nicholle', 'Maradiaga Sikaffy', 33330191, 22556569, 'nature_freako@hotmail.com', 0, '1991-08-28', '', 1, 2, 's', 2),
(1370, 'Yesica Dioxana', 'Lanza Rodriguez', 95270254, 0, 'dioxa305@yahoo.com', 0, '0000-00-00', '', 1, 2, 's', 1),
(1371, 'Aaron Josue', 'Mej&Atilde;&shy;a Salinas', 31915380, 22358670, 'Slifer.inc@gmail.com', 0, '1988-02-26', '', 1, 2, 's', 1),
(1372, 'Alexandra ', 'Tabora Chavarria', 89152454, 22265754, 'amtabora@gmail.com', 0, '1989-04-20', '', 1, 2, 'n', 1),
(1373, 'Alejandra Noemi', 'L&Atilde;&sup3;pez Bulnes', 32471852, 22293275, 'alelobu@yahoo.com', 0, '1986-09-14', '', 1, 2, 's', 1),
(1374, 'Elmer Misael', 'Aguilar Perdomo', 33415629, 22293026, 'misa_aguilar@yahoo.es', 0, '1986-01-25', '', 1, 2, 's', 1),
(1375, 'Jessyca Prady', 'Velasquez Paguada', 32750954, 22216269, 'jessyprady@gmail.com', 0, '1986-09-13', '', 1, 2, 's', 1),
(1376, 'Rina Damaris', 'Zuniga Castillo', 33738376, 0, 'rinzuncas@gmail.com', 0, '1989-09-19', '', 1, 2, 's', 1),
(1377, 'Emily Andrea', 'Meza Trejo', 97898846, 22462734, 'emilyan96@hotmail.com', 0, '1996-05-16', '', 1, 2, 's', 1),
(1378, 'Fabio Lenin', 'Tabora  Castillo ', 97810303, 22289364, 'fltc9933@gmail.com ', 0, '1999-11-05', '', 1, 2, 's', 3),
(1379, 'Jefry Ariel', 'Avila Ardon', 97976668, 0, 'jefry.avila@unah.hn', 0, '1996-04-23', '', 1, 2, 's', 2),
(1380, 'Allan Mauricio ', 'Alvarado Duarte', 99161670, 22442470, 'allan.alvarado@gmail.com', 0, '1977-08-24', '', 1, 2, 's', 1),
(1381, 'Marcelo Fabricio', 'Lopez Cubas', 89678704, 22308287, 'marcelolpz15@gmail.com', 0, '1996-07-30', '', 1, 2, 's', 4),
(1382, 'Mauricio Enrique', 'Alvarenga Espinal', 96260119, 22344940, 'neopwngaming@gmail.com', 0, '1996-12-14', '', 1, 2, 's', 2),
(1383, 'Ernesto', 'Gonzalez Torres', 9747, 2255, 'ernesto_gonzalez_torres@hotmail.com', 0, '1995-11-07', '', 1, 2, 's', 2),
(1384, 'Nilsee Alejandra', 'Cardona D&Atilde;&shy;az', 32208093, 22708205, 'nilsee1994@yahoo.com', 0, '1994-09-09', '', 1, 2, 's', 1),
(1385, 'Francisco', 'Maradiaga Martinez', 33038950, 0, 'fjmaradiaga@icloud.com', 0, '1980-10-02', '', 1, 2, 's', 2),
(1386, 'Gerlla', 'Aragon Torres ', 32765906, 22552567, 'gerllaaragon@gmail.com', 0, '2015-09-05', '', 1, 2, 'n', 2),
(1387, 'Olga Maripaz', 'Acosta Hernandez', 96630627, 22332591, 'ninapalmas@hotmail.com', 0, '1994-12-04', '', 1, 2, 's', 2),
(1388, 'Dennis Alejandro', 'Aguilar Romero', 99852467, 0, 'dennisaguilariv@gmail.com', 0, '1991-02-07', '', 1, 2, 's', 3),
(1389, 'Yury Rodolfo', 'Reyes Cruz', 33079768, 22368594, 'yuryreyes@agrolibano.com', 0, '1981-12-17', '', 1, 2, 's', 1),
(1390, 'Diana Maricel', 'Reyes Cruz', 32311620, 22368594, 'mariceldiana@yahoo.com', 0, '2015-09-06', '', 1, 2, 's', 1),
(1391, 'Marcela Alejandra', 'Mac&Atilde;&shy;as moncada', 32369540, 0, 'pink_052013@hotmail.com', 0, '1991-01-05', '', 1, 2, 's', 1),
(1392, 'Jenny Claudeth', 'Barahona Andino', 3365, 0, 'jclaudeth@gmail.com', 0, '1988-04-13', '', 1, 2, 's', 2),
(1393, 'Amy Carolina', 'Mejia Alvarado', 89833769, 22305995, 'amy2008cm@yahoo.com', 0, '1998-08-09', '', 1, 2, 's', 2),
(1394, 'Carlos', 'Bustillo Hernandez', 31883059, 0, 'shin_getsu@outlook.com', 0, '1993-01-01', '', 1, 2, 's', 3),
(1395, 'axell', 'Figueroa Cerrato', 33292172, 22553256, 'axficerrato95@gmail.com', 0, '1995-08-30', '', 1, 2, 's', 1),
(1396, 'Carmen Beatriz', 'Zuniga ', 31642270, 2212186, 'cvz_beatriz@yahoo.com', 0, '1991-02-09', '', 1, 2, 'n', 1),
(1397, 'karen lineth ', 'hernandez ciliezar ', 96327033, 22236454, 'karen_ciliezar@hotmail.com', 0, '0000-00-00', '', 1, 2, 's', 1),
(1398, 'Ambar Dessire', 'Cortes Ordo&Atilde;ƒ&Acirc;&plusmn;', 31796669, 0, 'adessire.c@gmail.com', 0, '1994-04-08', '', 1, 2, 's', 1),
(1399, 'renan antonio', 'hernandez ciliezar', 97357470, 22236454, 'renan_antonio2011@hotmail.com', 0, '0000-00-00', '', 1, 2, 's', 1),
(1400, 'Patricia ', 'Barahona Cortes', 87792824, 0, 'patbarahonacortes@gmail.com', 0, '1995-02-23', '', 1, 2, 's', 1),
(1401, 'Irania Sujey', 'Hernandez Zepeda', 95186295, 2227, 'iraniasujey95@hotmail.com', 0, '1995-06-14', '', 1, 2, 's', 1),
(1402, 'Laura Luc&Atilde;&shy;a', 'Valladares Canales', 33008772, 22304455, 'lauralvcanales725@gmail.com', 0, '1996-04-17', '', 1, 2, 's', 1),
(1403, 'Ariel Fernando', 'Villatoro Solorzano', 8751, 2230, 'arielitovs@yahoo.com', 0, '1997-04-19', '', 1, 2, 's', 1),
(1404, 'Carlos Eduardo ', 'Barahona Talavera ', 3225, 0, 'KrlosOblivion@hotmail.com ', 0, '1986-01-07', '', 1, 2, 's', 2),
(1405, 'Jocs&Atilde;&iexcl;n Ariel', 'Hern&Atilde;&iexcl;ndez Barahona', 97870884, 22277433, 'jocsan.hernndez@yahoo.com', 0, '1993-10-22', '', 1, 2, 's', 4),
(1406, 'JASMIN SAHABI', 'GIRON AGUILAR', 88878304, 0, '', 0, '2000-07-30', '', 1, 2, 's', 1),
(1407, 'Kevin Daniel', 'Silva Qui&Atilde;&plusmn;onez', 99305218, 99305218, 'kvnds1989@gmail.com', 0, '1989-08-31', '', 1, 2, 's', 1),
(1408, 'Kevin Josue', 'Arriaza Amador', 96159976, 22252829, 'josue79a@hotmail.com', 0, '1993-05-02', '', 1, 2, 's', 2),
(1409, 'In&Atilde;&copy;s Mariela', 'Rodas Lagos', 3384, 2230, 'rodaslagos@gmail.com', 0, '1990-07-18', '', 1, 2, 's', 2),
(1410, 'NORLAN MODESTO', 'RAMIREZ MATAMOROS', 95789063, 2233, 'norlanramirez12@gmail.com', 0, '2015-09-07', '', 1, 2, 's', 2),
(1411, 'Samaria ', 'C&Atilde;&iexcl;rcamo', 97904894, 22243417, 'samariacarcamo@hotmail.com', 0, '1991-06-22', '', 1, 2, 's', 1),
(1412, 'Keren Ester', 'Yanes Casco', 32781726, 0, 'ke_yanes@hotmail', 0, '1993-08-17', '', 1, 2, 's', 4),
(1413, 'Christian Geovanny', 'L&Atilde;&sup3;pez Flores', 9665, 2228, 'christianlopez6@hotmail.com', 0, '1993-05-17', '', 1, 2, 's', 4),
(1414, 'Fermin Ernesto', 'Quant Miranda', 94781140, 0, 'ferminquant@hotmail.com', 0, '1987-12-29', '', 1, 2, 's', 2),
(1415, 'Gabriela Elizabeth', 'Menocal Cover', 98279181, 0, 'gabrielamenocal@yahoo.com', 0, '1989-11-02', '', 1, 2, 's', 2),
(1416, 'Mari Luz Salazar &Atilde;lvarez', 'Salazar &Atilde;lvarez', 33064543, 22213209, 'mluz.salazar@yahoo.com', 0, '1979-12-26', '', 1, 2, 's', 2),
(1417, 'Eber David Salazar &Atilde;lvarez', 'Salazar &Atilde;lvarez', 95128534, 22213209, 'salazared89@gmail.com', 0, '1989-03-28', '', 1, 2, 's', 2),
(1418, 'Heidy Elizabeth', 'N&Atilde;&ordm;&Atilde;&plusmn;ez C', 33168660, 22462608, 'hely20151003280@gmail.com', 0, '1997-03-15', '', 1, 2, 's', 2),
(1419, 'Nahum Caleb', 'Garc&Atilde;&shy;a Urbina', 96168280, 22307931, 'ngcu17@gmail.com', 0, '1997-07-25', '', 1, 2, 's', 1),
(1420, 'Nadia Melissa', 'Cruz Elvir', 94880510, 0, 'ing.civil.nadiacruz@gmail.com', 0, '1984-08-30', '', 1, 2, 's', 3),
(1421, 'Michelle Alessandra', 'Valladares Duarte', 94700471, 22712077, 'mialevalladares_97@hotmail.com', 0, '1997-04-21', '', 1, 2, 's', 2),
(1422, 'Andrea Celeste', 'Reyes Rivas', 32470916, 22342797, 'nya2ne7@yahoo.es', 0, '1998-10-27', '', 1, 2, 's', 1),
(1423, 'Ricardo ', 'Pineda Mejia', 87340311, 22330871, 'ricardopin@hotmail.com', 0, '1991-09-23', '', 1, 2, 's', 3),
(1424, 'Karen Waldina', 'Lagos B&Atilde;&ordm;', 9841, 2255, 'kwlb84@gmail.com', 0, '2015-09-07', '', 1, 2, 's', 4),
(1425, 'Leonardo Alonso', 'Silva Vasquez', 99158516, 22381479, 'lasv.235@gmail.com', 0, '2015-09-07', '', 1, 2, 's', 1),
(1426, 'Bianca', 'Canales', 98387559, 22255609, 'bianca. canales@hotmail.com', 0, '1988-09-02', '', 1, 2, 's', 4),
(1427, 'Oscar Alexander', 'Melgar Ortiz', 3288, 2257, 'kkandram@yahoo.es', 0, '1995-11-21', '', 1, 2, 's', 4),
(1428, 'Miguel Angel', 'Godoy Gomez', 33952010, 22307050, 'mikey89angel@gmail.com', 0, '1989-02-27', '', 1, 2, 's', 1),
(1429, 'Juan', 'Medina Merlo', 95980117, 0, 'jmed1290@hotmail.com', 0, '1990-09-07', '', 1, 2, 's', 2),
(1430, 'Scarleth Julissa', 'Rodriguez Perez', 9516, 2201, 'rodriguez.rocks53@yahoo.es', 0, '0000-00-00', '', 1, 2, 's', 1),
(1431, 'Luis Andres', 'Ramirez Cruz', 97800018, 22301887, 'lram08@yahoo.es', 0, '1991-08-22', '', 1, 2, 's', 3),
(1432, 'Alejandra noemi', 'L&Atilde;&sup3;pez bulnes', 32471852, 0, 'alelobu@yahoo.com', 0, '1986-09-14', '', 1, 2, 'n', 1),
(1433, 'Ixchel Atenea', 'Portillo David', 97602609, 22275911, 'ixatenea@yahoo.com', 0, '1998-10-14', '', 1, 2, 's', 2),
(1434, 'Claudia Isela', 'Padilla Cerrato', 89682213, 22466942, 'iselapadilla88@gmail.com', 0, '1985-04-11', '', 1, 2, 's', 1),
(1435, 'Sergio Tulio', 'D&Atilde;ƒ&Acirc;&shy;az Orellana', 9982, 2231, 'diazing_4985@yahoo.es', 0, '2015-09-07', '', 1, 2, 's', 2),
(1436, 'Rosario Antonia', 'Valladares Rodr&Atilde;ƒ&Acirc;&shy', 9985, 2231, 'rosario.valladares@hotmail.com', 0, '2015-09-07', '', 1, 2, 's', 2),
(1437, 'Sergio Tulio', 'D&Atilde;&shy;az Orellana', 9982, 2231, 'diazing_4985@yahoo.es', 0, '2015-09-07', '', 1, 2, 'n', 2),
(1438, 'Rosario Antonia', 'Valladares Rodriguez', 9982, 2231, 'rosario.valladares@hotmail.com', 0, '2015-09-07', '', 1, 2, 'n', 2),
(1439, 'Cinthia Mabela', 'Mejia Torres', 96199234, 22392632, 'cynthiamabelak@gmail.com', 0, '1988-11-01', '', 1, 2, 's', 1),
(1440, 'Roberto Andres', 'Alvarez Veroy', 96920582, 22118766, 'roberandres.alvarez@gmail.com', 0, '1988-04-11', '', 1, 2, 's', 2),
(1441, 'Katerin Mariela', 'Aguilar Veroy', 32672424, 22266207, 'mariela209414@hotmail.com', 0, '1994-09-20', '', 1, 2, 's', 2),
(1442, 'Ernesto', 'Gonzalez Torres', 9747, 2255, 'ernesto_gonzalez_torres@hotmail.com', 0, '1995-11-07', '', 1, 2, 's', 2),
(1443, 'Randall Giovany', 'Aguilar Veroy', 87391401, 22266207, 'randallaguilar55@yahoo.es', 0, '1999-11-17', '', 1, 2, 's', 2),
(1444, 'Jose Erick', 'Barahona Garcia', 33553961, 0, 'Erick22_barahona@unitec.edu', 0, '2015-09-07', '', 1, 2, 's', 2),
(1445, 'No&Atilde;&copy; Alejandro', 'Alvarez Rodriguez', 0, 22293423, 'noealejandro_alvarez@hotmail.com', 0, '1998-03-26', '', 1, 2, 's', 3),
(1446, 'Erly Mauricio ', 'Hern&Atilde;&iexcl;ndez Ramos', 89041558, 0, 'erlyhaz@gmail.com', 0, '1994-05-18', '', 1, 2, 'n', 1),
(1447, 'Oscar Sebastian', 'Rivera Lagos', 98602113, 0, 'oskr88746@gmail.com', 0, '1999-04-07', '', 1, 2, 's', 2),
(1448, 'Amy Jannelore', 'Rodriguez Montalvan', 88825313, 22283188, 'amyjro16@gmail.com', 0, '1996-09-14', '', 1, 2, 'n', 1),
(1449, 'Roger Misael', 'Barrientos Navas', 99453037, 22462977, 'elzx92@gmail.com', 0, '1992-06-05', '', 1, 2, 'n', 1),
(1450, 'Jenny Rosibel', 'Moreno Morales', 31758985, 22206731, 'jennymore0510@gmail.com', 0, '1987-05-10', '', 1, 2, 's', 2),
(1451, 'Jos&Atilde;&copy; Eduardo', 'Maradiaga Bonilla', 98460172, 22570043, 'jose_maradiaga23@hotmail.com', 0, '1997-05-23', '', 1, 2, 's', 1),
(1452, 'Erly Mauricio', 'Hernandez Ramos', 89041558, 0, 'erlyhaz@gmail.com', 0, '1995-05-18', '', 1, 2, 's', 1),
(1453, 'Amy Jannelore ', 'Rodriguez Montalvan', 88825313, 22283188, 'amyjro16@gmail.com', 0, '1996-09-14', '', 1, 2, 's', 1),
(1454, 'Ariana Melissa', 'Alvarado Rivera', 9952, 2245, 'arianaalvrado@gmail.com', 0, '2000-02-17', '', 1, 2, 's', 3),
(1455, 'Mauricio Noe', 'Alvarado Rivera', 9697, 2245, 'mauricioalvaradorivera@gmail.com', 0, '1997-02-28', '', 1, 2, 's', 3),
(1456, 'Omar', 'Cacho', 87914300, 22454605, 'oscaromarcacho@yahoo.es', 0, '0000-00-00', '', 1, 2, 's', 1),
(1457, 'Flor Idalma', 'Escalon', 96020337, 2225, 'flories91@hotmail.com', 0, '1991-10-30', '', 1, 2, 'n', 4),
(1458, 'Victor Manuel', 'Recarte Garcia', 33922284, 22381569, 'victor@unah.edu.hn', 0, '1980-08-14', '', 1, 2, 'n', 1),
(1459, 'Alfonso jose', 'Cotarelo Archaga', 32439471, 22708109, 'cota6si@gmail.com', 0, '2015-09-07', '', 1, 2, 's', 2),
(1460, 'Adela maria ', 'cotarelo archaga', 33771560, 22708109, 'cotarelokirigiri@gmail.com', 0, '1998-08-20', '', 1, 2, 's', 2),
(1461, 'Jonie', 'Miralda', 22233944, 95069826, 'jonie.miralda@unah.hn', 0, '1991-09-30', '', 1, 2, 'n', 1),
(1462, 'Freddy Enrique', 'Flores Garcia', 89549966, 22299089, 'fredflores1993@gmail.com', 0, '1993-04-30', '', 1, 2, 's', 2),
(1463, 'Oscar Eduardo', 'Gonez Rivera', 97355146, 22348149, 'oscare.gomezr@unitec.edu', 0, '1995-02-01', '', 1, 2, 's', 1),
(1464, 'Fausto Fernando', 'Hernandez Rivera', 95527122, 22260259, 'faustoanime123@gmail.com', 0, '1999-01-08', '', 1, 2, 's', 2),
(1465, 'Ariana Paola', 'Fuentes Martinez', 95004635, 22298375, 'paola0845@gmail.com', 0, '1996-08-04', '', 1, 2, 's', 2),
(1466, 'Eduardo Josue', 'Yanez Gonzales', 89883803, 0, 'eduardo.yanez350@gmail.com', 0, '1998-02-26', '', 1, 2, 's', 1),
(1467, 'Ellis', 'Reyes', 32859995, 26433222, 'kuuroko04@gmail.com', 0, '1994-03-31', '', 1, 2, 's', 2),
(1468, 'Marianela', 'Cantarero Zavala', 99822525, 22339444, 'mnela94@gmail.com', 0, '1994-02-16', '', 1, 2, 's', 2),
(1469, 'Nancy Nahomi', 'Tercero Morales', 95346224, 22090025, 'Nonijoan1221@gmail.com', 0, '2000-06-12', '', 1, 2, 's', 2),
(1470, 'Dilcia', 'Reyes', 32859995, 26433222, 'mikuwabakadesu@gmail.com', 0, '1996-08-23', '', 1, 2, 's', 1),
(1471, 'Fausto Fernando', 'Hernandez Rivera', 95527122, 22260259, 'faustoanime321@hotmail.com', 0, '1999-01-08', '', 1, 2, 'n', 2),
(1472, 'Lourdes Fabiola', 'Rivera T&Atilde;ƒ&iuml;&iquest;&fra', 96969813, 0, 'fabyrivera98@gmail.com', 0, '1993-12-18', '', 1, 2, 's', 3),
(1473, 'Kewin', 'Izaguirre Medina', 98716129, 0, 'kewinantonioizaguirre@yahoo.es', 0, '2015-09-07', '', 1, 2, 's', 3),
(1474, 'Maria Helena', 'Berenguer', 31754884, 0, 'mhberenguer@gmail.com', 0, '1955-08-24', '', 1, 2, 's', 1),
(1475, 'kimberly sheryl ', 'rodas rodas', 88457139, 22237141, 'sherylrodas@gmail.com', 0, '1994-02-11', '', 1, 2, 's', 2),
(1476, 'Hanyi Walquiria', 'Acosta  Lainez', 99507025, 33282420, 'hanyiwalquiria@gmail.com', 0, '1990-08-16', '', 1, 2, 'n', 1),
(1477, 'Jorge Luis', 'Mejia Fuentes', 99850455, 0, 'jorgeluismejia99@gmail.com', 0, '1999-10-25', '', 1, 2, 's', 5),
(1478, 'Marllury Julissa ', 'Sandoval Munguia ', 97033604, 22708255, 'marlluryjulissas@yahoo.com ', 0, '1993-04-12', '', 1, 2, 's', 1),
(1479, 'Arleth Yanileisy', 'G&Atilde;&iexcl;mez Hern&Atilde;&ie', 97334421, 0, 'arlethgamez@yahoo.es', 0, '1994-10-24', '', 1, 2, 's', 1),
(1480, 'Estefan&Atilde;&shy;a Beatriz', 'Benda&Atilde;&plusmn;a Castro', 99033322, 22374436, 'estefaniabendana@hotmail.com', 0, '1989-12-02', '', 1, 2, 's', 4),
(1481, 'Elvin', 'Rodriguez Mendez', 89105839, 22236775, 'elvin9412@yahoo.com', 0, '1994-10-21', '', 1, 2, 'n', 1),
(1482, 'Jos&Atilde;&copy; Ricardo', 'Urqu&Atilde;&shy;a Zavala', 96740757, 2772, 'jenova-12@hotmail.com', 0, '1990-04-19', '', 1, 2, 's', 2),
(1483, 'Sergio Kevin', 'Acosta Lainez', 96206800, 0, 'sergio21skal@hotmail.com', 0, '1996-11-21', '', 1, 2, 'n', 1),
(1484, 'Jessie Pamela', 'Moncada Cruz', 33306563, 22222329, 'jessie23pamela@hotmail.es', 0, '1992-04-23', '', 1, 2, 's', 1),
(1485, 'Stefany Patricia ', 'Cruz Velasquez', 99056840, 22205541, 'ppatricia1726@hotmail.com', 0, '1994-10-17', '', 1, 2, 's', 4),
(1486, 'Yolani', 'Ponce', 32273282, 22011325, 'yolaniponce_alpha@yahoo.com', 0, '1988-08-17', '', 1, 2, 'n', 1),
(1487, 'Jason Samael', 'Maldonado Gudiel', 95832095, 22364520, 'jsmgudiel@gmail.com', 0, '1994-03-16', '', 1, 2, 's', 1),
(1488, 'Dayanara', 'Valladares Dubon', 88494342, 22304816, 'daydubon26@gmail.com', 0, '2015-09-07', '', 1, 2, 's', 1),
(1489, 'Elvin', 'Rodriguez Mendez', 89105839, 22236775, 'elvin1615@gmail.com', 0, '2015-09-07', '', 1, 2, 'n', 1),
(1490, 'Ra&Atilde;&ordm;l Alejandro', 'Gonz&Atilde;&iexcl;lez Gallo', 95456077, 22285336, 'raulalejandro90@yahoo.com', 0, '1999-04-13', '', 1, 2, 's', 1),
(1491, 'Joel Alberto', 'Lagos Linck', 8904, 3201, 'joellinck@gmail.com', 0, '1984-12-14', '', 1, 2, 's', 3),
(1492, 'Alvaro Lisandro', 'Tavel Molina', 9975, 2232, 'alvaro.tavel@hotmail.com', 0, '1998-04-01', '', 1, 2, 's', 4),
(1493, 'Soraya Rosangel', 'Aceituno Vidaur ', 96134303, 22451033, 'rosangelaceituno@hotmail.es', 0, '1997-02-20', '', 1, 2, 's', 3),
(1494, 'giannina solange ', 'reyes reyes', 33150298, 0, 'gianninasolanger188@gmail.com ', 0, '1990-08-18', '', 1, 2, 's', 1),
(1495, 'Manuel Adalid', 'Gamero Valladares', 2147483647, 2147483647, 'manuelgamero92@gmail.com', 0, '1992-02-04', '', 1, 2, 's', 3),
(1496, 'Lurvin Marisol', 'Villalta Espinal', 9623, 2235, 'marisol.villalta@hotmail.com', 0, '0000-00-00', '', 1, 2, 's', 1),
(1497, 'Luis Fernando', 'G&Atilde;&sup3;mez Barahona', 9936, 2235, 'luisfernh@hotmail.com', 0, '0000-00-00', '', 1, 2, 's', 1),
(1498, 'Jesuard Sahid', 'Zuniga Paz', 95584444, 22712386, 'jesuahid@gmail.com', 0, '1996-04-18', '', 1, 2, 's', 1),
(1499, 'Jorge Leonardo', 'Castellanos Ir&Atilde;&shy;as', 99885428, 99885428, 'jorgeleonardo@castellanosirias.com', 0, '2015-09-08', '', 1, 2, 'n', 1),
(1500, 'Anibal Alexander', 'Salgado Guerrero', 3351, 2243, 'anibal.salgadoguerrero@gmail.com', 0, '1990-09-08', '', 1, 2, 's', 3),
(1501, 'Carlos Raul', 'Munguia Suazo', 97336615, 22833405, 'antonia.suazom@gmail.com', 0, '2000-01-31', '', 1, 2, 's', 2),
(1502, 'Alicia Gabriela', 'Medina Cruz', 99701965, 22320952, 'alosia.san@gmail.com', 0, '1987-02-01', '', 1, 2, 's', 2),
(1503, 'valeria sofia', 'alvarado mejia', 87334905, 22352055, 'kvmalvarado@yahoo.com.mx', 0, '2015-09-08', '', 1, 2, 's', 2),
(1504, 'Sue Ana', 'Aparicio Godoy', 98138081, 22343162, 'suki_ag@hotmail.com', 0, '2015-09-08', '', 1, 2, 's', 5),
(1505, 'jose raul', 'pinto irias', 33644801, 22331491, 'pintojose074@gmail.com', 0, '1996-08-09', '', 1, 2, 's', 1),
(1506, 'Ana Gabriela ', 'Herrera Herrera', 32412491, 2270, 'gabiherrera92@gmail.com', 0, '1992-04-19', '', 1, 2, 's', 1),
(1507, 'Luis', 'Alvarado', 94886871, 22305823, 'lsalvarado.hn@gmail.com', 0, '1986-08-12', '', 1, 2, 's', 1),
(1508, 'Jose', 'Ruiz', 94723110, 22253754, 'jhruiz.1996@gmail.com', 0, '2015-09-08', '', 1, 2, 'n', 1),
(1509, 'magbis salvador adonai ', 'medina raudales ', 97334567, 22331491, 'magbis98medina@gmail.com', 0, '1998-05-15', '', 1, 2, 's', 1),
(1510, 'Jose ', 'Silva Sierra', 97266100, 22365141, 'sierrajose24@yahoo.es', 0, '1997-11-09', '', 1, 2, 's', 2),
(1511, 'Karen Ninochka', 'Barahona Aguilar', 94788099, 0, 'kanibaag@gmail.com', 0, '2015-09-08', '', 1, 2, 's', 1),
(1512, 'Julio Aticus ', 'Romero Flores', 98705215, 22916413, 'jatics24@gmail.com', 0, '1997-04-08', '', 1, 2, 's', 5),
(1513, 'karina nicole', 'vasquez yanes', 87641495, 0, 'yanes_2009@hotmail.es', 0, '1992-12-19', '', 1, 2, 's', 1),
(1514, 'Harold Isaac', 'Venegas', 99101503, 0, 'harold_kbt@yahoo.com', 0, '2015-09-08', '', 1, 2, 's', 1),
(1515, 'David Alexander', 'Mejia', 95357270, 22254472, 'mejiadavid62@gmail.com', 0, '1997-01-25', '', 1, 2, 's', 1),
(1516, 'Donald Rolando', 'Canales salinas', 95780516, 22255609, 'Donald.canales@novem.hn', 0, '1980-12-13', '', 1, 2, 'n', 1),
(1517, 'Johana', 'Zelaya', 33064078, 0, 'zelayajimenez3008@gmail.com', 0, '2015-09-08', '', 1, 2, 's', 1),
(1518, 'Jose Luis', 'Espinal', 33757755, 22236062, 'deathspinal@aol.com', 0, '1987-04-11', '', 1, 2, 's', 1),
(1519, 'Sobeida Nazaret', 'Nu&Atilde;&plusmn;ez Rosa', 98428026, 31602838, 'nasasobe@wwindowslive.com', 0, '1996-01-03', '', 1, 2, 's', 2),
(1520, 'Yelena Margarita', 'Rivas Robles', 31785853, 22278136, 'yeri118@gmail.com', 0, '1987-09-11', '', 1, 2, 's', 1),
(1521, 'Juan Pablo', 'Rivas Robles', 89918804, 22278136, 'riro118@hotmail.com', 0, '1988-08-18', '', 1, 2, 's', 1),
(1522, 'Katherine', 'Cerrato Arana', 3223, 2246, 'katiarana25@gmail.com', 0, '1995-11-25', '', 1, 2, 's', 1),
(1523, 'Daniel Edgardo', 'Brice&Atilde;&plusmn;o Molina', 97416916, 0, 'bdanieledgardo@hotmail.com', 0, '0000-00-00', '', 1, 2, 's', 3),
(1524, 'Daniela Idania', 'Ordo&Atilde;&plusmn;ez Godoy', 96953065, 22273169, 'diog18@hotmail.com', 0, '1997-09-18', '', 1, 2, 's', 3),
(1525, 'Cesar ', 'Padilla Rodriguez', 99721417, 0, 'cesarpadilla2010@live.com', 0, '2000-06-01', '', 1, 2, 's', 2),
(1526, 'Luis', 'Pacheco', 89758706, 22252834, 'willi_walli_1@yahoo.es', 0, '1988-12-08', '', 1, 2, 's', 2),
(1527, 'Cristian Josu&Atilde;ƒ&Acirc;&copy;', 'Montiel P&Atilde;ƒ&Acirc;&copy;rez', 97982066, 22455372, 'cristian.montiel@unah.hn', 0, '1993-12-08', '', 1, 2, 's', 1),
(1528, 'Arnaldo', 'Rodas', 32947587, 0, 'arod016@outlook.com', 0, '1982-10-16', '', 1, 2, 's', 1),
(1529, 'Pamela', 'Almendares Giron', 33599446, 33599446, 'pamelocho@gmail.com', 0, '1989-08-20', '', 1, 2, 's', 2),
(1530, 'Norma Sagrario', 'Rivera Ferrera', 33330138, 0, 'norma.srivera.f@gmail.com', 0, '0000-00-00', '', 1, 2, 's', 1),
(1531, 'Andre', 'Hernandez Velasquez', 33050737, 22332726, 'andretux2495@gmail.com', 0, '2015-09-08', '', 1, 2, 's', 1),
(1532, 'Normanda Dannesse', 'Lopez', 32669262, 22516564, 'danesy3@gmail.com', 0, '1990-03-16', '', 1, 2, 's', 2),
(1533, 'juan manuel', 'coello aparicio', 98499782, 22334969, 'melizabethgato@hotmail.com', 0, '2000-05-14', '', 1, 2, 's', 3),
(1534, 'Gerardo Henrique', 'Romero Vargas', 31729042, 0, 'gromero258@gmail.com', 0, '1999-05-03', '', 1, 2, 's', 3),
(1535, 'Erika Margarita', 'Navarro Zepeda', 97307342, 0, 'navarro.erika.m@gmail.com', 0, '1992-10-22', '', 1, 2, 's', 3),
(1536, 'Allan Esau ', 'Aguilar Perdomo', 32558051, 27812291, 'esauperdomo@yahoo.es', 0, '1988-06-19', '', 1, 2, 's', 2),
(1537, 'joselyn victoria ', 'sorto rivera', 0, 0, 'j_vick0693@hotmail.com', 0, '1993-07-04', '', 1, 2, 's', 3),
(1538, 'Junielle', 'Fernandez', 32435348, 0, 'junielle_fer@yahoo.es', 0, '1993-11-22', '', 1, 2, 'n', 2),
(1539, 'Tatiana', 'Fernandez', 95927059, 0, 'tatiurbina22@gmail.com', 0, '1995-05-22', '', 1, 2, 'n', 2),
(1540, 'Xoce Ottoman', 'Fernandez', 89710755, 0, 'samael_urbina@yahoo.com', 0, '1989-07-16', '', 1, 2, 's', 1),
(1541, 'devaki ', 'mejia rivera', 89006401, 0, 'kivamr@hotmail.com', 0, '1985-03-19', '', 1, 2, 'n', 1),
(1542, 'Elsy Alejandra', 'madrid rivera', 96765349, 0, 'melsyalejandra92@gmail.com', 0, '1998-09-01', '', 1, 2, 'n', 1),
(1543, 'Claudia Melissa', 'Escoto Caballero', 96902826, 0, 'carlosmel_1324@hotmail.com', 0, '1996-05-25', '', 1, 2, 's', 1),
(1544, 'Marcelo', 'Garcia Mendoza', 95537121, 0, 'marcelogmendoza@hotmail.com', 0, '1997-02-10', '', 1, 2, 's', 1),
(1545, 'Carlos Alfredo', 'Flores Ponce', 89841724, 0, 'Ellobo1324@gmail.com', 0, '1990-08-24', '', 1, 2, 's', 1),
(1546, 'Rocio Gabriela', 'Martinez Aguilera', 95349294, 22573458, 'rociomartinez_14@hotmail.es', 0, '1992-08-14', '', 1, 2, 's', 2),
(1547, 'Claudia ', 'Melgar', 31980306, 22430523, 'cimrcloclo@gmail.com', 0, '2015-09-09', '', 1, 2, 's', 3),
(1548, 'Sara', 'Melgar', 89798904, 22430523, 'saramelgar03@gmail.com', 0, '1997-05-09', '', 1, 2, 's', 2),
(1549, 'Alicia', 'Melgar', 88245358, 2243052, 'ali17_mr@hotmail.com', 0, '1991-08-17', '', 1, 2, 's', 3),
(1550, 'KELLYN JEANETH', 'AGUILAR PORTILLO', 33860114, 0, 'kellyn.aguilar@bch.hn', 0, '1981-10-25', '', 1, 2, 's', 2),
(1551, 'Karla Johana Padilla Contreras ', 'Padilla Contreras ', 32115881, 22388305, 'karlahon@yahoo.com', 0, '1975-10-13', '', 1, 2, 'n', 1),
(1552, 'Susann', 'Canizales Bocanegra', 96247483, 2232, 'sjcabon@gmail.com', 0, '1978-08-06', '', 1, 2, 's', 1),
(1553, 'Manuel Alexander ', 'Valladares Contreras', 2147483647, 504, 'manuel.a.valladares@hotmail.com', 0, '1984-07-08', '', 1, 2, 's', 1),
(1554, 'Luis Fernando ', 'Ponce Chac&Atilde;&sup3;n', 32201175, 0, 'lynxfer_5@hotmail.com', 0, '1983-12-03', '', 1, 2, 's', 1),
(1555, 'Jose Luis', 'Silva Amador', 2147483647, 2147483647, 'jlusilva.8710@gmail.com', 0, '1987-10-25', '', 1, 2, 's', 1),
(1556, 'Luis', 'Alvarado Molina', 94886871, 22305823, 'lsalvarado.hn', 0, '1986-12-08', '', 1, 2, 's', 1),
(1557, 'Jose David', 'Jiron Gonzales', 9635, 22573623, 'josedavid31@gmail.com', 0, '1981-10-31', '', 1, 2, 'n', 1),
(1558, 'Steven', 'Espinal', 94704143, 22392144, 'thundersteve77@gmail.com', 0, '1994-07-27', '', 1, 2, 's', 1),
(1559, 'Egla Rosmery', 'Gattorno Gutierrez', 95775587, 0, 'japanrocks@hotmail.com', 0, '1985-06-22', '', 1, 2, 's', 5),
(1560, 'Sebastian ', 'Kafie', 94575091, 22322860, 'sebaskafie7@gmail.com', 0, '0000-00-00', '', 1, 2, 's', 1),
(1561, 'Anthony Wylberth', 'Rodriguez Thompson', 87345562, 87345567, 'nw_rs@hotmail.com', 0, '1999-09-07', '', 1, 2, 's', 2),
(1562, 'Nicholle', 'Maradiaga Sikaffy', 33330191, 0, 'ieattheworld@yahoo.com', 0, '1991-08-28', '', 1, 2, 's', 2),
(1563, 'Suanny', 'Salinas', 32409208, 22456077, 'suanny20092009@hotmail.com', 0, '1997-01-26', '', 1, 2, 's', 1),
(1564, 'Kerlim Escarleth', 'Varela Palma', 88024486, 0, 'kerlim.varela@unah.hn', 0, '1993-09-28', '', 1, 2, 's', 4),
(1565, 'Norma Lastenia ', 'Zuniga Trejo', 97725443, 22367552, 'lastetrejo@gmail.com', 0, '1989-05-19', '', 1, 2, 'n', 1),
(1566, 'Luis Fernando ', 'Ord&Atilde;&sup3;&Atilde;&plusmn;ez', 99319577, 2225, 'luisferro2000@yahoo.com', 0, '1965-05-21', '', 1, 2, 's', 1),
(1567, 'Adrian Andrei', 'Guerra Triminio', 99183002, 22712490, 'ritrim2@yahoo.com', 0, '1999-11-03', '', 1, 2, 's', 1),
(1568, 'Adrian Adolfo ', 'Guerra Padilla', 97331129, 22712490, 'adrianguerra@yahoo.com', 0, '1977-06-30', '', 1, 2, 's', 1),
(1569, 'Mariam Alejandra', 'Hernandez Lopez', 33908398, 22266917, 'maleja26@yahoo.com', 0, '1985-06-26', '', 1, 2, 'n', 1),
(1570, 'Yanshan ', 'Chen', 31918294, 0, 'yanshans.chen@gmail.com', 0, '1992-03-29', '', 1, 2, 's', 1),
(1571, 'Silvia Yasmin ', 'Morel Bu', 33531111, 22275122, 'Siyamobu@yahoo.es', 0, '1991-06-11', '', 1, 2, 's', 1),
(1572, 'Carlos Eduardo ', 'Medrano Montes', 94653406, 22463275, 'medranoe09@gmail.com', 0, '1982-01-09', '', 1, 2, 's', 1),
(1573, 'Moises Alejandro', 'Canales Lainez', 94800392, 22242657, 'mdisco90@gmail.com', 0, '2015-09-09', '', 1, 2, 's', 3),
(1574, 'Jefrry', 'Rodriguez Portillo', 0, 0, 'jeff-mauri_2012@hotmail.com', 0, '1992-11-20', '', 1, 2, 's', 1),
(1575, 'Jose Fabricio', 'Banegas Ruiz', 2147483647, 0, 'fabriciobanegas@hotmail.com', 0, '1987-11-03', '', 1, 2, 's', 3),
(1576, 'Edwyn Moises', 'Rivera', 31583496, 96804132, 'edwynhn2002@yahoo.es', 0, '1986-01-15', '', 1, 2, 's', 1),
(1577, 'Beverly Hazel ', 'Alegria Molina', 2147483647, 0, 'hazelitaalegria@gmail.com', 0, '1996-02-21', '', 1, 2, 's', 1),
(1578, 'alejandra amador', 'amador matamoros', 99044414, 222252233, 'alematamoros@hotmail.com', 0, '1997-07-01', '', 1, 2, 's', 3),
(1579, 'Angel David', 'Gir&Atilde;ƒ&Acirc;&sup3;n Aguilera', 87979180, 22236177, 'angel11giron@gmail.com', 0, '1999-12-02', '', 1, 2, 's', 1),
(1580, 'Elisa Mar&Atilde;ƒ&Acirc;&shy;a', 'Rodr&Atilde;ƒ&Acirc;&shy;guez Palac', 33896869, 22573069, 'rodriguez.elisa@hotmail.com', 0, '1989-03-07', '', 1, 2, 's', 1),
(1581, 'Rodgers', 'Romero Pinto ', 32432817, 0, 'ColossusRV@hotmail.com', 0, '2015-09-09', '', 1, 2, 's', 1),
(1582, 'Carlos Eduardo', 'Hernandez Lopez', 33894661, 22266917, 'beis855@gmail.com', 0, '2015-09-09', '', 1, 2, 'n', 1),
(1583, 'Doris Vannesa', 'Solano Cruz', 99882753, 22550214, 'vannesa882004@hotmail.com', 0, '1985-12-22', '', 1, 2, 's', 1),
(1584, 'Eric Enrique', 'Raudales San Martin', 32963614, 0, 'eric.raudales@gmail.com', 0, '1991-10-24', '', 1, 2, 's', 3),
(1585, 'DENNIS FRANCISCO', 'ZELAYA ZAPATA', 97913323, 22398229, 'ingdenniszelayaz@yahoo.com', 0, '1984-12-09', '', 1, 2, 's', 3),
(1586, 'Alex Savier ', 'Ramos Rodriguez', 32220657, 22456077, 'alexramosr06@gmail.com', 0, '1996-06-06', '', 1, 2, 's', 1),
(1587, 'Ambar Lucero', 'Hernandez Espinoza', 87824082, 22131545, 'ambar.lucero.hernandez@gmail.com', 0, '1993-10-29', '', 1, 2, 's', 1),
(1588, 'Alex Savier', 'Ramos Rodriguez', 32220657, 22456077, 'alexramosr06@hotmail.com', 0, '1996-06-06', '', 1, 2, 'n', 1),
(1589, 'Maria del Rosario', 'Rodriguez Madrid', 97418508, 22269217, 'mrrm_82@hotmail.com', 0, '1982-03-26', '', 1, 2, 's', 1),
(1590, 'Daniel', 'Macpui', 94866077, 22241251, 'macpui1290@hotmail.com', 0, '1990-12-12', '', 1, 2, 's', 2),
(1591, 'Daniel Humberto', 'Macpui Benitez', 94866077, 0, 'dhbenitez@manconsulting.co.uk', 0, '1990-12-12', '', 1, 2, 's', 1),
(1592, 'Andrea Nicole', 'Rivera Piza&Atilde;&plusmn;a', 94600652, 22573788, 'andrearivera0715@gmail.com', 0, '2015-09-09', '', 1, 2, 's', 3),
(1593, 'Miguel Estuardo', 'Flores Robles', 3233529, 22354584, 'mfloresgt@gmail.com', 0, '1969-02-22', '', 1, 2, 's', 1),
(1594, 'Ana Michelle', 'Menc&Atilde;&shy;a Baca', 7216, 7216, 'ana.michelle.baca@gmail.com', 0, '2000-03-23', '', 1, 2, 's', 2),
(1595, 'daphner gabriela', 'arguijo zavaja', 95679527, 22396822, 'daphner.gabriela9@gmail.com', 0, '1997-09-03', '', 1, 2, 's', 4),
(1596, 'Alejandra Maria', 'Carrasco Raudales', 9794, 2234, 'maria_san97@hotmail.com', 0, '1997-10-09', '', 1, 2, 's', 4),
(1597, 'Miguel Estuardo', 'Flores Robles', 32373529, 22354584, 'mfloresgt@hotmail.com', 0, '1969-02-22', '', 1, 2, 'n', 1),
(1598, 'Kevin Alexander', 'Reyes Gomez', 98220447, 22299595, 'kerey98@yahoo.com', 0, '1998-05-06', '', 1, 2, 's', 1),
(1599, 'Miguel Antonio', 'Mejia Benavides', 33786838, 22271853, 'miguelmejia60@gmail.com', 0, '2015-09-09', '', 1, 2, 's', 2),
(1600, 'Obdulio', 'Oliva Graugnard', 31488956, 22239997, 'obdulioolivva94@gmail.com', 0, '0000-00-00', '', 1, 2, 's', 1),
(1601, 'Daniel', 'Suazo', 99566715, 22268306, 'suazodaniel99@gmail.com', 0, '1999-07-12', '', 1, 2, 's', 3),
(1602, 'Jose Diego', 'Lagos Martinez', 0, 22387195, 'gatoazul1821@yahoo.com', 0, '1997-05-18', '', 1, 2, 's', 5),
(1603, 'Daniela Ver&Atilde;&sup3;nica', 'Valladares Mart&Atilde;&shy;nez', 98707776, 22288304, 'danivvmtz_56@hotmail.com', 0, '1994-09-07', '', 1, 2, 's', 1),
(1604, 'Patricia', 'Eveline', 99844584, 22397341, 'Patricia.Eveline@upi.edu.hn', 0, '1993-05-22', '', 1, 2, 's', 2),
(1605, 'Noelia', 'Rivas Midence', 96650365, 22460956, 'noeliamidence@gmail.com', 0, '1992-03-31', '', 1, 2, 's', 1),
(1606, 'Dayana ', 'Rodriguez', 33159952, 0, 'dayana.c.r.m@gmail.com', 0, '0000-00-00', '', 1, 2, 's', 1),
(1607, 'Anielka Sof&Atilde;&shy;a', 'Mayes Anduray', 95516074, 0, 'anielkamayes@hotmail.com', 0, '1999-05-22', '', 1, 2, 'n', 2),
(1608, 'Andrea Michell ', 'Cruz Portales', 32883600, 0, 'andreamichellportales@hotmail.es', 0, '1999-08-06', '', 1, 2, 's', 1),
(1609, 'Jorge Luis ', 'Izaguirre Medina', 97783583, 22300296, 'jorgeluisiza@gmail.com', 0, '1993-05-25', '', 1, 2, 's', 4),
(1610, 'Henry', 'Cruz', 95309999, 0, 'cruzhenry86@gmail.com', 0, '1996-01-07', '', 1, 2, 's', 1),
(1611, 'Michelle', 'Flores', 96714425, 22711137, 'bexie97@yahoo.com', 0, '1997-01-27', '', 1, 2, 's', 1),
(1612, 'Gabriela Maria ', 'Rodriguez Moncada', 89356845, 89356845, 'gabz_07_941@hotmail.com', 0, '1992-07-06', '', 1, 2, 's', 1),
(1613, 'Valery Soe', 'Gomez Rivera', 95761457, 22348149, 'valesoe96@hotmail.com', 0, '1996-09-14', '', 1, 2, 's', 1),
(1614, 'Ivis Elena', 'Hernandez Maldonado', 98103840, 22274901, 'ivis2890@yahoo.com', 0, '1990-02-28', '', 1, 2, 's', 1),
(1615, 'Bertha Cecilia', 'Beltran Matute', 99010788, 2227987, 'ceciliabeltran@yahoo.es', 0, '1987-06-07', '', 1, 2, 's', 1),
(1616, 'Roger Misael', 'Barrientos Navas', 99453037, 22462977, 'elzx92@gmail.com', 0, '1992-06-04', '', 1, 2, 'n', 2),
(1617, 'Roger', 'Barrientos Navas', 99453037, 22450305, 'elzx92@hotmail.com', 0, '1992-06-04', '', 1, 2, 's', 2),
(1618, 'Andrea Xiomara', 'Landa Sierra', 31715896, 2289355, 'andre.xio237@hotmail.com', 0, '1991-07-23', '', 1, 2, 's', 4),
(1619, 'Diego Roberto', 'May&Atilde;ƒ&Acirc;&copy;n Elvir', 98335158, 22366209, 'diego_rme@yahoo.com', 0, '1995-12-09', '', 1, 2, 's', 1),
(1620, 'Alen', 'Miranda', 96083756, 0, 'alen_miranda@yahoo.com', 0, '1984-08-24', '', 1, 2, 's', 4),
(1621, 'Angela Vanessa', 'Abrego Suares', 33385236, 0, 'angela_vanessa2005@yahoo.com', 0, '1990-02-08', '', 1, 2, 's', 1),
(1622, 'Ysen Dayani ', 'Zavala Ventura', 97833639, 22244018, 'dazavy07@gmail.com', 0, '1988-09-10', '', 1, 2, 's', 1),
(1623, 'Allan Josue', 'Coello Raudales', 98776881, 2224, 'jocoal23@gmail.com', 0, '1984-02-23', '', 1, 2, 's', 1),
(1624, 'Ysen Dayani', 'Zavala Ventura', 97833639, 22244018, 'dazavi07@gmail.com', 0, '1988-01-10', '', 1, 2, 'n', 1),
(1625, 'Allan Josue', 'Coello', 98776881, 22244018, 'jocoal23@gmai.com', 0, '1984-02-23', '', 1, 2, 'n', 1),
(1626, 'Andrea Victoria', 'Mahomar Castro', 32053136, 22392377, 'avmc98@gmail.com', 0, '1998-11-05', '', 1, 2, 's', 2),
(1627, 'Jhonny Josue', 'Zuniga Sanchez', 9497, 2257, 'jhonny.j.zuniga@gmail.com', 0, '1998-12-08', '', 1, 2, 's', 4),
(1628, 'Osman Rolando Jimenez', 'Jimenez Rivera', 31754069, 22347270, 'osman.rivera@hotmail.com', 0, '1990-10-13', '', 1, 2, 's', 1),
(1629, 'Jorge David', 'Andino Rivera', 0, 0, 'jorge@', 0, '2015-09-11', '', 1, 2, 's', 3),
(1630, 'Nancy Cristina', 'Salinas Triminio', 99220940, 0, 'salinas.nc2015@gmail.com', 0, '1972-10-10', '', 1, 2, 's', 1),
(1631, 'Andrea Sofia', 'Castro Salinas', 96249228, 0, 'andreasofis@gmail.com', 0, '1996-09-18', '', 1, 2, 's', 1),
(1632, 'Luis Fernando', 'Garcia', 31715917, 0, 'luiscead@hotmail.com', 0, '2015-09-11', '', 1, 2, 's', 1),
(1633, 'Edwin Javier', 'Nunez Martinez', 98140519, 0, 'edwin@', 0, '2015-09-11', '', 1, 2, 's', 4),
(1634, 'Kevin Ariel', 'Nunez Martinez', 96910557, 0, 'kevin@', 0, '2015-09-11', '', 1, 2, 's', 4),
(1635, 'Andrea Nicolle', 'Del Cid Nunez', 31739231, 22279958, 'andreanicki@hotmail.com', 0, '1996-06-17', '', 1, 2, 's', 4),
(1636, 'Estela de los Angeles', 'Torres Rojas', 96291370, 27662576, 'es.torres.rojas@gmail.com', 0, '1999-06-14', '', 1, 2, 's', 2),
(1637, 'Abdell', 'Membreno', 97005774, 0, 'abdell.znl@gmail.com', 0, '1993-04-17', '', 1, 2, 's', 3),
(1638, 'Emily Solangie', 'Rivera Rubi', 97915846, 0, 'emily@', 0, '2015-09-11', '', 1, 2, 's', 1),
(1639, 'Gisela Yadira', 'Rubi', 0, 0, 'gisela@', 0, '2015-09-11', '', 1, 2, 's', 1),
(1640, 'Pedro Juan', 'Rivera Rubi', 97915846, 0, 'pedro@', 0, '2015-09-11', '', 1, 2, 's', 1),
(1641, 'Maury', 'Funez', 0, 0, 'maury@', 0, '2015-09-12', '', 1, 2, 's', 3),
(1642, 'Nora Esmeralda', 'Avila', 33901142, 0, 'noraavila2009@hotmail.com', 0, '2015-09-12', '', 1, 2, 's', 3),
(1643, 'Diana Elisa', 'Morales Coello', 99935252, 0, 'dmoralescoello@yahoo.com', 0, '2015-09-12', '', 1, 2, 's', 4),
(1644, 'Javier Eduardo', 'Reyes Gomez', 99933964, 22299595, 'reyesjavier1293@yahoo.com', 0, '2015-09-12', '', 1, 2, 's', 1),
(1645, 'Argeany Nohemy', 'Giron Espinal', 32014712, 22236177, 'argeany@', 0, '2000-09-04', '', 1, 2, 's', 1),
(1646, 'Angel Emanuel', 'Briceno Morgan', 33863212, 22236177, 'vangelemanuel@yahoo.es', 0, '2000-08-24', '', 1, 2, 's', 1),
(1647, 'Larissa Giselle', 'Rivera Lopez', 97779510, 0, 'larissa@', 0, '1997-03-07', '', 1, 2, 's', 5),
(1648, 'Osman Daniel', 'Rivera Lopez', 31436070, 0, 'osman@', 0, '1987-01-29', '', 1, 2, 's', 3),
(1649, 'Alexandra ', 'Galindo Giron', 98991715, 22552741, 'alexandra@', 0, '1998-06-08', '', 1, 2, 's', 5),
(1650, 'Jose Benjamin', 'Solano Cruz', 96236231, 22550214, 'extreme/twister@hotmail.com', 0, '1982-05-02', '', 1, 2, 's', 1),
(1651, 'Gabriel Omar', 'Avilez Gonzalez', 87873674, 22226550, 'gabavilez95@hotmail.com', 0, '1997-02-22', '', 1, 2, 's', 5),
(1652, 'Aimi', 'Ferrera Hiraoka', 97601484, 0, 'pukitafh@gmail.com', 0, '1999-12-21', '', 1, 2, 's', 3),
(1653, 'Josue Gilberto', 'Tabora Meza', 0, 0, 'josue_tabora@yahoo.com', 0, '2015-10-16', '', 1, 2, 's', 1),
(1654, 'Marvin Danilo', 'Amador Ulloa', 0, 0, 'danilo@', 0, '2015-10-16', '', 1, 2, 's', 1),
(1655, 'Adan Odiseo', 'Cerrato Carrasco', 9624, 0, 'odiseo_cc@gmail.com', 0, '2015-11-20', '', 1, 2, 's', 5),
(1656, 'David', 'Alem&Atilde;&iexcl;n', 0, 0, '9947-7220', 0, '2015-11-20', '', 1, 2, 's', 2),
(1657, 'Melvin', 'Ricardo', 22466072, 22466072, 'mrnrades@gmail.com', 801992081, '1999-01-10', 'M', 1, 1, 'S', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_regiones`
--

CREATE TABLE IF NOT EXISTS `tbl_regiones` (
  `CODIGO_REGION` int(11) NOT NULL,
  `NOMBRE_REGION` varchar(35) NOT NULL,
  `ABREVIATURA` varchar(10) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_regiones`
--

INSERT INTO `tbl_regiones` (`CODIGO_REGION`, `NOMBRE_REGION`, `ABREVIATURA`) VALUES
(1, 'America', 'AMER'),
(2, 'Europa', 'EUR'),
(3, 'Africa', 'af'),
(4, 'Asia', 'AS'),
(5, 'America del sur', 'AMS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_roles`
--

CREATE TABLE IF NOT EXISTS `tbl_roles` (
  `CODIGO_ROL` int(11) NOT NULL,
  `NOMBRE_ROL` varchar(35) NOT NULL,
  `ABREVIATURA` varchar(10) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_roles`
--

INSERT INTO `tbl_roles` (`CODIGO_ROL`, `NOMBRE_ROL`, `ABREVIATURA`) VALUES
(1, 'Administrador', 'admin'),
(2, 'Estudiante', 'estud'),
(3, 'Maestro', 'Maest'),
(4, 'Recursos Humanos', 'RRH'),
(5, 'prueba', 'pb');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_secciones`
--

CREATE TABLE IF NOT EXISTS `tbl_secciones` (
  `CODIGO_SECCION` int(11) NOT NULL,
  `DIAS` varchar(15) NOT NULL,
  `CODIGO_AULA` int(11) NOT NULL,
  `CODIGO_CLASE` int(11) NOT NULL,
  `CODIGO_HORARIO` int(11) NOT NULL,
  `CODIGO_PERIODO` int(11) NOT NULL,
  `CODIGO_PERSONA` int(11) NOT NULL,
  `FECHA` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_usuarios`
--

CREATE TABLE IF NOT EXISTS `tbl_usuarios` (
  `CODIGO_USUARIO` int(11) NOT NULL,
  `NOMBRE_USUARIO` varchar(90) NOT NULL,
  `PASSWORD` varchar(60) NOT NULL,
  `CODIGO_PERSONA` int(11) NOT NULL
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
('Ades', 'QXNkLjEyMzQ=', '2015-12-02 00:00:00', '2015-12-04 00:00:00', '2015-12-26 00:00:00', 1, '1657', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `accesos_de_usuario`
--
ALTER TABLE `accesos_de_usuario`
  ADD PRIMARY KEY (`iden`),
  ADD KEY `employedCode_FK` (`employedCode`);

--
-- Indices de la tabla `binnacle`
--
ALTER TABLE `binnacle`
  ADD PRIMARY KEY (`codBinnacle`),
  ADD KEY `codEmpleado_FK_Binnacle` (`codEmpleado`);

--
-- Indices de la tabla `tbl_aulas`
--
ALTER TABLE `tbl_aulas`
  ADD PRIMARY KEY (`CODIGO_AULA`),
  ADD KEY `CODIGOL_EDIFICIOS_FK` (`CODIGO_EDIFICIO`);

--
-- Indices de la tabla `tbl_centros_regionales`
--
ALTER TABLE `tbl_centros_regionales`
  ADD PRIMARY KEY (`CODIGO_CENTRO_REGIONAL`),
  ADD KEY `CODIGO_LOCALIZACIONES_NFK_FK` (`CODIGO_LOCALIZACION`);

--
-- Indices de la tabla `tbl_clases`
--
ALTER TABLE `tbl_clases`
  ADD PRIMARY KEY (`CODIGO_CLASE`);

--
-- Indices de la tabla `tbl_edificios`
--
ALTER TABLE `tbl_edificios`
  ADD PRIMARY KEY (`CODIGO_EDIFICIO`),
  ADD KEY `CODIGO_CENTROS_REGIONALES_FK` (`CODIGO_CENTRO_REGIONAL`);

--
-- Indices de la tabla `tbl_historiales`
--
ALTER TABLE `tbl_historiales`
  ADD PRIMARY KEY (`CODIGO_HISTORIAL`),
  ADD KEY `CODIGO_MATRICULA_FK` (`CODIGO_MATRICULA`);

--
-- Indices de la tabla `tbl_horarios`
--
ALTER TABLE `tbl_horarios`
  ADD PRIMARY KEY (`CODIGO_HORARIO`);

--
-- Indices de la tabla `tbl_localizaciones`
--
ALTER TABLE `tbl_localizaciones`
  ADD PRIMARY KEY (`CODIGO_LOCALIZACION`),
  ADD KEY `CODIGO_PAISES_FK` (`CODIGO_PAIS`);

--
-- Indices de la tabla `tbl_matriculas`
--
ALTER TABLE `tbl_matriculas`
  ADD PRIMARY KEY (`CODIGO_MATRICULA`),
  ADD KEY `CODIGO_PERIODOS_FK` (`CODIGO_PERIODO`),
  ADD KEY `CODIGO_PERSONAS_NFK_FK` (`CODIGO_PERSONA`),
  ADD KEY `CODIGO_SECCIONES_FK` (`CODIGO_SECCION`);

--
-- Indices de la tabla `tbl_niveles`
--
ALTER TABLE `tbl_niveles`
  ADD PRIMARY KEY (`CODIGO_NIVEL`);

--
-- Indices de la tabla `tbl_paises`
--
ALTER TABLE `tbl_paises`
  ADD PRIMARY KEY (`CODIGO_PAIS`),
  ADD KEY `CODIGO_REGIONES_FK` (`CODIGO_REGION`);

--
-- Indices de la tabla `tbl_periodos`
--
ALTER TABLE `tbl_periodos`
  ADD PRIMARY KEY (`CODIGO_PERIODO`);

--
-- Indices de la tabla `tbl_personas`
--
ALTER TABLE `tbl_personas`
  ADD PRIMARY KEY (`CODIGO_PERSONA`),
  ADD KEY `CODIGO_LOCALIZACIONES_FK` (`CODIGO_LOCALIZACION`),
  ADD KEY `CODIGO_ROLES_FK` (`CODIGO_ROL`),
  ADD KEY `CODIGO_NIVEL_NFK1_FK` (`CODIGO_NIVEL`);

--
-- Indices de la tabla `tbl_regiones`
--
ALTER TABLE `tbl_regiones`
  ADD PRIMARY KEY (`CODIGO_REGION`);

--
-- Indices de la tabla `tbl_roles`
--
ALTER TABLE `tbl_roles`
  ADD PRIMARY KEY (`CODIGO_ROL`);

--
-- Indices de la tabla `tbl_secciones`
--
ALTER TABLE `tbl_secciones`
  ADD PRIMARY KEY (`CODIGO_SECCION`),
  ADD KEY `CODIGO_AULAS_FK` (`CODIGO_AULA`),
  ADD KEY `CODIGO_CLASES_FK` (`CODIGO_CLASE`),
  ADD KEY `CODIGO_HORARIOS_FK` (`CODIGO_HORARIO`),
  ADD KEY `CODIGO_PERIODOS_NFK_FK` (`CODIGO_PERIODO`),
  ADD KEY `tbl_secciones_FK` (`CODIGO_PERSONA`);

--
-- Indices de la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  ADD PRIMARY KEY (`CODIGO_USUARIO`),
  ADD KEY `CODIGO_PERSONAS_NFK1_FK` (`CODIGO_PERSONA`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD UNIQUE KEY `userName` (`userName`),
  ADD UNIQUE KEY `codEmpleado` (`codEmpleado`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `accesos_de_usuario`
--
ALTER TABLE `accesos_de_usuario`
  MODIFY `iden` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=141;
--
-- AUTO_INCREMENT de la tabla `binnacle`
--
ALTER TABLE `binnacle`
  MODIFY `codBinnacle` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tbl_aulas`
--
ALTER TABLE `tbl_aulas`
  MODIFY `CODIGO_AULA` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT de la tabla `tbl_centros_regionales`
--
ALTER TABLE `tbl_centros_regionales`
  MODIFY `CODIGO_CENTRO_REGIONAL` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `tbl_clases`
--
ALTER TABLE `tbl_clases`
  MODIFY `CODIGO_CLASE` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `tbl_edificios`
--
ALTER TABLE `tbl_edificios`
  MODIFY `CODIGO_EDIFICIO` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT de la tabla `tbl_historiales`
--
ALTER TABLE `tbl_historiales`
  MODIFY `CODIGO_HISTORIAL` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tbl_horarios`
--
ALTER TABLE `tbl_horarios`
  MODIFY `CODIGO_HORARIO` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `tbl_localizaciones`
--
ALTER TABLE `tbl_localizaciones`
  MODIFY `CODIGO_LOCALIZACION` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `tbl_matriculas`
--
ALTER TABLE `tbl_matriculas`
  MODIFY `CODIGO_MATRICULA` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tbl_niveles`
--
ALTER TABLE `tbl_niveles`
  MODIFY `CODIGO_NIVEL` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `tbl_paises`
--
ALTER TABLE `tbl_paises`
  MODIFY `CODIGO_PAIS` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tbl_periodos`
--
ALTER TABLE `tbl_periodos`
  MODIFY `CODIGO_PERIODO` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tbl_personas`
--
ALTER TABLE `tbl_personas`
  MODIFY `CODIGO_PERSONA` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1658;
--
-- AUTO_INCREMENT de la tabla `tbl_regiones`
--
ALTER TABLE `tbl_regiones`
  MODIFY `CODIGO_REGION` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `tbl_roles`
--
ALTER TABLE `tbl_roles`
  MODIFY `CODIGO_ROL` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `tbl_secciones`
--
ALTER TABLE `tbl_secciones`
  MODIFY `CODIGO_SECCION` int(11) NOT NULL AUTO_INCREMENT;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_aulas`
--
ALTER TABLE `tbl_aulas`
  ADD CONSTRAINT `tbl_aulas_ibfk_1` FOREIGN KEY (`CODIGO_EDIFICIO`) REFERENCES `tbl_edificios` (`CODIGO_EDIFICIO`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tbl_centros_regionales`
--
ALTER TABLE `tbl_centros_regionales`
  ADD CONSTRAINT `CODIGO_LOCALIZACIONES_NFK_FK` FOREIGN KEY (`CODIGO_LOCALIZACION`) REFERENCES `tbl_localizaciones` (`CODIGO_LOCALIZACION`);

--
-- Filtros para la tabla `tbl_localizaciones`
--
ALTER TABLE `tbl_localizaciones`
  ADD CONSTRAINT `CODIGO_PAISES_FK` FOREIGN KEY (`CODIGO_PAIS`) REFERENCES `tbl_paises` (`CODIGO_PAIS`);

--
-- Filtros para la tabla `tbl_paises`
--
ALTER TABLE `tbl_paises`
  ADD CONSTRAINT `CODIGO_REGIONES_FK` FOREIGN KEY (`CODIGO_REGION`) REFERENCES `tbl_regiones` (`CODIGO_REGION`);

--
-- Filtros para la tabla `tbl_personas`
--
ALTER TABLE `tbl_personas`
  ADD CONSTRAINT `tbl_personas_ibfk_1` FOREIGN KEY (`CODIGO_ROL`) REFERENCES `tbl_roles` (`CODIGO_ROL`);

--
-- Filtros para la tabla `tbl_secciones`
--
ALTER TABLE `tbl_secciones`
  ADD CONSTRAINT `tbl_secciones_FK` FOREIGN KEY (`CODIGO_PERSONA`) REFERENCES `tbl_personas` (`CODIGO_PERSONA`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
