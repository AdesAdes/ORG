<!--
Vista de los usuarios  con detalle 
-->
<?php
    $CODIGO_REGION = $_GET['CODIGO_REGION'];
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL  SP_VER_DATOS_REGION(?)");
    $stmt->execute(array($CODIGO_REGION));
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($rows as $row){
        $COD_REGION       = $row['CODIGO_REGION'];
        $NOMBRE_REGION   = $row['NOMBRE_REGION'];
        $ABREVIATURA   = $row['ABREVIATURA'];
        
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
                        Codigo Region
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$CODIGO_REGION</label>
                        <input id="Region" value=$CODIGO_REGION hidden>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Region
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$NOMBRE_REGION</label>
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

HTML;
    

    }
?>   
   