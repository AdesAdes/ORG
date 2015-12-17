<!--
Vista de los usuarios  con detalle 
-->
<?php
    $CODIGO_ASIGNATURA = $_GET['CODIGO_ASIGNATURA'];
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL  SP_VER_DATOS_ASIGNATURAS(?)");
    $stmt->execute(array($CODIGO_ASIGNATURA));
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($rows as $row){
        $NOMBRE_CLASE   = $row['NOMBRE_CLASE'];
        $REQUISITO   = $row['REQUISITO'];
        $UV   = $row['UV'];
        $image = $CODIGO_ASIGNATURA.".jpg";
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
                        Asignatura
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$NOMBRE_CLASE</label>
                        <input id="asignatura" value=$CODIGO_ASIGNATURA hidden>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Requisito
                    </label>
                    <div class="col-sm-6">
                    
                        <label class="form-control">$REQUISITO</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        UV
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$UV</label>
                    </div>
                </div>
                

HTML;
    

    }
?>   
   