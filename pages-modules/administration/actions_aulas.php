
<!--ACTUALIZA o inserta UNA NUEVA AULA-->
<?php
$action = $_GET["action"];
if ($action == 1){
    sleep(2);
    try{
        $aula = $_GET['aula'];
        $piso = $_GET['pisos'];
        $edificio = $_GET['edificio'];
        $estado = $_GET['estado'];
        include '../../conection/conection.php';
        $stmt = $db->prepare("CALL SP_INSERTAR_AULAS(?,?,?)");
        $stmt->execute(array($aula, $edificio, $piso));
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo '<div class="alert alert-success">Agregado exitosamente</div>';
        
    }catch (Exception $e){
        echo '<div class="alert alert-danger">Hubo un problema</div>';
        
    }
}else if($action == 2){
    try{
        $aula = $_GET['aula'];
        $estado = $_GET['estado'];
        include '../../conection/conection.php';
        $stmt = $db->prepare("CALL SP_ACTUALIZAR_ESTADO_AULAS(?,?)");
        $stmt->execute(array($aula, $estado));
        if ($estado == 1){
            echo '<div>Activo</div>';
        }else{
            
            echo "<div>Deshabilitado</div> ";
        }
    }catch (Exception $e){
        
    }
};

?>
