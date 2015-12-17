<!DOCTYPE html>
<!--
    Ingeniería del software
-->
<?php
    if(!isset($_SESSION)) { 
        session_start(); 
	}
    
    function getRealIP() {
        if (!empty($_SERVER['HTTP_CLIENT_IP']))
            return $_SERVER['HTTP_CLIENT_IP'];

        if (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))
            return $_SERVER['HTTP_X_FORWARDED_FOR'];

        return $_SERVER['REMOTE_ADDR'];
    }
    
    include '../conection/conection.php';
    $user = $_POST['username'];
    $password = $_POST['password'];
    
    $stmt = $db->prepare("CALL selectUser(?)");
    $stmt->execute(array($user));
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);  
    foreach ($rows as $row){
        $status         =   $row['status'];
        $log            =   $row['log'];
        $codEmpleado    =   $row['codEmpleado'];
        $user           =   $row['userName'];
        $codRole        =   $row['codRole'];
        $passwordB      =   $row['password'];
        }
    
    if ($password == $passwordB){    
        if($status == 1){
            if($log == 0){
                $_SESSION['authenticated'] = '1';
                $_SESSION['user'] = $user;
                $_SESSION['codEmpleado'] = $codEmpleado;
                $_SESSION['time_out'] = time();
                $_SESSION['codRole'] = $codRole;
                
                include '../conection/conection.php';
                $stmt = $db->prepare("CALL updateLog(1,?)");
                $stmt->execute(array($codEmpleado));
                
                include '../conection/conection.php';
                $ipAccess = (string)getRealIP();
                $reason = 'Inicio de sesión';
                
                $stmt = $db->prepare("CALL accessLog(?,?,?)");
                $stmt->execute(array($codEmpleado, $ipAccess, $reason));
                header('location:../index.php');
            }
            else{
                header('location:login.php?error=0');
            }
        }
        else{
            header('location:login.php?error=1');
        }
    }
    else{
        header('location:login.php?error=2');
    }
?>
<script src="../js/encrypt.js" type="text/javascript"></script>