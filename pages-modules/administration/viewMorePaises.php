<!--
Vista de los usuarios  con detalle 
-->
<?php
    $CODIGO_PAIS = $_GET['CODIGO_PAIS'];
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL  SP_VER_DATOS_PAIS(?)");
    $stmt->execute(array($CODIGO_PAIS));
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($rows as $row){
        $COD_PAIS       = $row['CODIGO_PAIS'];
        $NOMBRE_PAIS   = $row['NOMBRE_PAIS'];
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
                        Codigo Pais
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$CODIGO_PAIS</label>
                        <input id="Region" value=$CODIGO_PAIS hidden>
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
   