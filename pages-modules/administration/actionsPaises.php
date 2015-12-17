
<!--ACTUALIZA o inserta UNA NUEVA AULA-->
<?php
$action = $_GET["action"];
if ($action == 1){
    sleep(2);
    try{
        $pais = $_GET['pais_p'];
        $abreviatura_pais = $_GET['abreviatura_pais'];
        $region = $_GET['region_p'];
        
        include '../../conection/conection.php';
        $stmt = $db->prepare("CALL SP_INSERTAR_PAISES(?,?,?)");
        $stmt->execute(array( $pais,$abreviatura_pais,$region));
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo '<div class="alert alert-success">Agregado exitosamente</div>';
        
    }catch (Exception $e){
        echo '<div class="alert alert-danger">Hubo un problema</div>';
        
    }
}

?>
