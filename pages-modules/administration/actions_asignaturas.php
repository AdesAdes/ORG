
<!--ACTUALIZA o inserta UNA NUEVA AULA-->
<?php
$action = $_GET["action"];
if ($action == 1){
    sleep(2);
    try{
        $asignatura = $_GET['asignatura'];
        $uv = $_GET['uv'];
        $requisito = $_GET['requisito'];
        
        include '../../conection/conection.php';
        $stmt = $db->prepare("CALL SP_INSERTAR_ASIGNATURAS(?,?,?)");
        $stmt->execute(array( $asignatura,$uv,$requisito));
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo '<div class="alert alert-success">Agregado exitosamente</div>';
        
    }catch (Exception $e){
        echo '<div class="alert alert-danger">Hubo un problema</div>';
        
    }
}

?>
