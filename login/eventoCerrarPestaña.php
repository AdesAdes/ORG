<?php
	/* Este codigo es llamado unicamamente si se ha cerrado la pestaña del navegador
	se inicializa la sesion, se toma el identificador de la sesion logueada,
	se incluyen los datos de conexion, se actualiza el logueo en la base de datos y
	se destruyen las variables de sesion*/
	session_start();
	$codEmpleado = $_SESSION['codEmpleado'];
	include "../conection/conection.php";
	$stmt = $db->prepare("CALL updateLog(0,?)");
       $stmt->execute(array($codEmpleado));
	$_SESSION = array();
	session_destroy();
        ?>