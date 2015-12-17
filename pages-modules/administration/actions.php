
<!--agrega o inserta un nuevo usario-->
<?php
$action = $_GET["action"];
if ($action == 1){
    sleep(2);
    try{
        $user = $_GET['user'];
        $pass = $_GET['pass'];
        $emplo = $_GET['emplo'];
        include '../../conection/conection.php';
        $stmt = $db->prepare("CALL insertUser(?,?,?)");
        $stmt->execute(array($user, $pass, $emplo));
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo '<div class="alert alert-success">Agregado exitosamente</div>';
    }catch (Exception $e){
        echo '<div class="alert alert-danger">Hubo un problema</div>';
    }
}else if($action == 2){
    try{
        $user   = $_GET['user'];
        $status = $_GET['status'];
        include '../../conection/conection.php';
        $stmt = $db->prepare("CALL updateStatus(?,?)");
        $stmt->execute(array($user, $status));
        if ($status == 1){
            echo '<div>Activo</div>';
        }else{
            include '../../conection/conection.php';
            $stmt = $db->prepare("CALL viewUser(?)");
            $stmt->execute(array($user));
            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
            foreach ($rows as $row){
                $disablingdate  = $row['disablingdate'];
            }
            echo "<div>Deshabilitado - $disablingdate</div>";
        }
    }catch (Exception $e){
        
    }
};
?>
<!DOCTYPE html>
<<!DOCTYPE html>
<html>
<head>
    <title>
    </title>
    <link rel="stylesheet" type="text/css" href="../../bootstrap/css/bootstrap.css">
</head>
<body>

</body>
</html>