<!--
Vista de los usuarios  con detalle 
-->
<?php
    $CODIGO_SECCION = $_GET['CODIGO_SECCION'];
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL  SP_VER_DATOS_SECCIONES(?)");
    $stmt->execute(array($CODIGO_SECCION));
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($rows as $row){
        $CODIGO_SECCION       = $row['CODIGO_SECCION'];
        $AULA       =$row['NOMBRE_AULA'];
        $NOMBRE_CLASE   = $row['NOMBRE_CLASE'];
        $HORA_INICIO   = $row['HORA_INICIO'];
        $HORA_FIN   = $row['HORA_FIN'];
        $PERIODO    =$row['PERIODO'];
        $DIAS       =$row['DIAS'];
        $ANIO       =$row['AñO'];
        $EDIFICIO   =$row['NOMBRE_EDIFICIO'];
        $MAESTRO   =$row['NOMBRE'];
        echo 
<<<HTML
        <div class="profile-header-container">
                
                <div class="rank-label-container">
HTML;
                    
        echo
<<<HTML
        </div>
            <div class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Seccion
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$CODIGO_SECCION</label>
                        <input id="Seccion" value=$CODIGO_SECCION hidden>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Edificio
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$EDIFICIO</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Aula
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$AULA</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Clase
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$NOMBRE_CLASE</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Maestro(a)
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$MAESTRO</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Hora Inicio
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$HORA_INICIO</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Hora Fin
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$HORA_FIN</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Dias
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$DIAS</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Periodo
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$PERIODO</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Año
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$ANIO</label>
                    </div>
                </div>
HTML;
    

    }
?>   
   