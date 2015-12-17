<!--
Vista de los usuarios  con detalle 
-->
<?php
    $CODIGO_CENTRO_REGIONAL = $_GET['CODIGO_CENTRO_REGIONAL'];
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL  SP_VER_DATOS_CENTROS_REGIONALES(?)");
    $stmt->execute(array($CODIGO_CENTRO_REGIONAL));
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($rows as $row){
        $nombreCentroRegional       = $row['CENTRO'];
        $ciudad   = $row['CIUDAD'];
        $pais   = $row['PAIS'];
        $region   = $row['REGION'];
        $image = $CODIGO_CENTRO_REGIONAL.".jpg";
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
                        Centro Regional
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$nombreCentroRegional</label>
                        <input id="CentroRegional" value=$CODIGO_CENTRO_REGIONAL hidden>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Ciudad
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$ciudad</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Pais
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$pais</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Region
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$region</label>
                    </div>
                </div>

HTML;
    

    }
?>   
   