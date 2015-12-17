
<!--ACTUALIZA o inserta UNA NUEVA AULA-->
<?php
$action = $_GET["action"];
if ($action == 1){
    sleep(2);
    try{
        $region = $_GET['region'];
        $abreviatura = $_GET['abreviatura'];
        
        
        include '../../conection/conection.php';
        $stmt = $db->prepare("CALL SP_INSERTAR_REGION(?,?)");
        $stmt->execute(array( $region,$abreviatura));
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo '<div class="alert alert-success">Agregado exitosamente</div>';
        
    }catch (Exception $e){
        echo '<div class="alert alert-danger">Hubo un problema</div>';
        
    }
}

?>
