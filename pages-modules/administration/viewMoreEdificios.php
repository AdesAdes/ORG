<!--
Vista de los usuarios  con detalle 
-->
<?php
    $CODIGO_EDIFICIO = $_GET['CODIGO_EDIFICIO'];
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL  SP_VER_DATOS_EDIFICIO(?)");
    $stmt->execute(array($CODIGO_EDIFICIO));
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($rows as $row){
        $nombreEdificio       = $row['NOMBRE_EDIFICIO'];
        $cantidadPisos   = $row['NUMERO_PISOS'];
        $codigoCentroRegional   = $row['CODIGO_CENTRO_REGIONAL'];
        $image = $CODIGO_EDIFICIO.".jpg";
        echo 
<<<HTML
        <div class="profile-header-container">
                <!--<img class="img-circle" src="images/profile/$image" id="profile"/>-->
                <div class="rank-label-container">
HTML;
//echo "<span class='badge alert-success'> </div>";
                    
        echo
<<<HTML
        </div>
            <div class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Edificio
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$nombreEdificio</label>
                        <input id="Edificio" value=$CODIGO_EDIFICIO hidden>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Cantidad de pisos
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$cantidadPisos</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Centro Regional
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$codigoCentroRegional</label>
                    </div>
                </div>

HTML;
    

    }
?>   
   