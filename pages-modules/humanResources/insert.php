<?php
    try{
        include '../../conection/conection.php';
        $str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
        $cE = "";
        for($i=0;$i<4;$i++) {
        $cE.= substr($str,rand(0,62),1);
        }
        $stmt = $db->prepare("CALL insertEmployed(?,?,?,?,?,?,?,?,?,?,?,?)");
        $stmt->execute(array($cE,'0601199300001','Juan','','Perez','',99999999,
            'prueba@prueba.prueba','26/08/15','M','Tegucigalpa',2));
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

        echo '<div class="alert alert-success">Se ingreso exitosamente</div>';
    }catch (Exception $e){
        echo '<div class="alert alert-danger">Hubo un problema</div>';
    }
?>


    