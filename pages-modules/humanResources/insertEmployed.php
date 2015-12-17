<?php
    sleep(2);
    try{
        $idCard = $_GET["idcard"];
        $fname  = $_GET["fname"];
        $sname  = $_GET["sname"];
        $lfname  = $_GET["lfname"];
        $lsname  = $_GET["lsname"];
        $phoneNumber = (int)$_GET["phoneNumber"];
        $email = $_GET["email"];
        $birthDay = $_GET["birthDay"];
        $direction = $_GET["direction"];
        $charge = (int)$_GET["charge"];

        $str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
        $cE = "";
        for($i=0;$i<4;$i++) {
        $cE.= substr($str,rand(0,62),1);
        }

        include '../../conection/conection.php';
        $stmt = $db->prepare("CALL insertEmployed(?,?,?,?,?,?,?,?,?,?,?,?)");
        $stmt->execute(array($cE,$idCard,$fname,$sname,$lfname,$lsname,$phoneNumber,
            $email,$birthDay,'M',$direction,$charge));
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

        echo '<div class="alert alert-success">Se ingreso exitosamente</div>';
    }catch (Exception $e){
        echo '<div class="alert alert-danger">Hubo un problema</div>';
    }
?>