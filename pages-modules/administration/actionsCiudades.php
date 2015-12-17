
<!--ACTUALIZA o inserta UNA NUEVA AULA-->
<?php
$action = $_GET["action"];
if ($action == 1){
    sleep(2);
    try{
        $ciudad = $_GET['ciudad'];
        $pais = $_GET['pais'];
        $abreviatura = $_GET['abreviatura'];
        $codigoPostal = $_GET['codigoPostal'];
        
        include '../../conection/conection.php';
        $stmt = $db->prepare("CALL SP_INSERTAR_CIUDADES(?,?,?,?)");
        $stmt->execute(array( $ciudad,$abreviatura,$codigoPostal,$pais));
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo '<div class="alert alert-success">Agregado exitosamente</div>';
        
    }catch (Exception $e){
        echo '<div class="alert alert-danger">Hubo un problema</div>';
        
    }
}

?>
