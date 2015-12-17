<!--
Vista de los usuarios  con detalle 
-->
<?php
    $CODIGO_LOCALIZACION = $_GET['CODIGO_LOCALIZACION'];
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL  SP_VER_DATOS_CIUDADES(?)");
    $stmt->execute(array($CODIGO_LOCALIZACION));
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($rows as $row){
        $COD_LOCALIZACION       = $row['CODIGO_LOCALIZACION'];
        $NOMBRE_CIUDAD   = $row['NOMBRE_CIUDAD'];
        $ABREVIATURA   = $row['ABREVIATURA'];
        $CODIGO_POSTAL = $row['CODIGO_POSTAL'];
        $NOMBRE_PAIS = $row['NOMBRE_PAIS'];
        
        echo 
<<<HTML
        <div class="profile-header-container">
                
                <div class="rank-label-container">
HTML;
//echo "<span class='badge alert-success'> </div>";
                    
        echo
<<<HTML
        </div>
            <div class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Codigo Ciudad
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$COD_LOCALIZACION</label>
                        <input id="Ciudad" value=$COD_LOCALIZACION hidden>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Ciudad
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$NOMBRE_CIUDAD</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Abreviatura
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$ABREVIATURA</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Codigo postal
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$CODIGO_POSTAL</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Pais
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$NOMBRE_PAIS</label>
                    </div>
                </div>
HTML;
    

    }
?>   
   