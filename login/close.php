<?php
    session_start();
    include '../conection/conection.php';
    
    $user = $_SESSION['codEmpleado'];
    $stmt = $db->prepare("CALL updateLog(0,?)");
    $stmt->execute(array($user));
    
    $_SESSION = array();
    session_destroy();
?>
