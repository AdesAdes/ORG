
<!-- crea un nuevo usuario-->
<?php
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL SP_SELECCIONAR_ASIGNATURAS()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
echo <<<HTML
    <div class="form-horizontal" id="addAsignatura" name="addAsignatura">
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Asignatura
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-university"></i>
                </span>
                <div class="required-field-block">
                    <input type="text" class="form-control"
                        placeholder="Nombre de asignatura" id="asignatura">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Unidades valorativas
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-university"></i>
                </span>
                <div class="required-field-block">
                    <input type="number" class="form-control"
                        placeholder="Unidades valorativas" id="uv">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Requisito
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-globe"></i>
                </span>
                <select class="form-control" id="requisito">
HTML;
                foreach ($rows as $row){
                    $NOMBRE_ASIGNATURA           = $row['NOMBRE_CLASE'];
                    $CODIGO_ASIGNATURA          = $row['CODIGO_CLASE'];
                    echo "<option value = $CODIGO_ASIGNATURA>($CODIGO_ASIGNATURA) $NOMBRE_ASIGNATURA</option>";
                }
                echo '</select>';
echo <<<HTML
            </div>
        </div>
                <div id="message"></div>
    </div>
HTML;
?>