
<!--ACTUALIZA o inserta UNA NUEVA AULA-->
<?php
$action = $_GET["action"];
if ($action == 1){
    sleep(2);
    try{
        $centroRegional = $_GET['centroRegional'];
        $ciudad = $_GET['ciudad'];
        
        
        include '../../conection/conection.php';
        $stmt = $db->prepare("CALL SP_INSERTAR_CENTROS_REGIONALES(?,?)");
        $stmt->execute(array( $centroRegional,$ciudad));
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo '<div class="alert alert-success">Agregado exitosamente</div>';
        
    }catch (Exception $e){
        echo '<div class="alert alert-danger">Hubo un problema</div>';
        
    }
}

?>
