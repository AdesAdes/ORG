
<!--ACTUALIZA o inserta UNA NUEVA AULA-->
<?php
$action = $_GET["action"];
if ($action == 1){
    sleep(2);
    try{
        $dias = $_GET['dias'];
        $horario  = $_GET['horario'];
        $edificio = $_GET['edificio'];
        $aula = $_GET['aula'];
        $asignatura = $_GET['asignatura'];
        $maestros = $_GET['maestros'];
        $periodos = $_GET['periodos'];
        
        include '../../conection/conection.php';
        $stmt = $db->prepare("CALL SP_INSERTAR_SECCIONES(?,?,?,?,?,?)");
        $stmt->execute(array( $dias,$aula,$asignatura,$horario,$periodos,$maestros));
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo '<div class="alert alert-success">Agregado exitosamente</div>';
        
    }catch (Exception $e){
        echo '<div class="alert alert-danger">Hubo un problema</div>';
        
    }
}

?>
