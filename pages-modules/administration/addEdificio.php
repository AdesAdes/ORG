
<!-- crea un nuevo usuario-->
<?php
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL SP_VER_CENTROS_REGIONALES()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
echo <<<HTML
    <div class="form-horizontal" id="addEdificio" name="addEdificio">
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Nombre Edificio
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-building-o"></i>
                </span>
                <div class="required-field-block">
                    <input type="text" class="form-control"
                        placeholder="Edificio" id="nombredeedificio">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Cantidad de pisos
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-pencil"></i>
                </span>
                <div class="required-field-block">
                    <input type="number" class="form-control"
                        placeholder="Numero de pisos" id="cantidaddepisos">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Aulas por piso
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-pencil"></i>
                </span>
                <div class="required-field-block">
                    <input type="number" class="form-control"
                        placeholder="Aulas por piso" id="codigoedificio">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Centro Regional
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-university"></i>
                </span>
                <select class="form-control" id="centros_regionales">
HTML;
                foreach ($rows as $row){
                    $NOMBRE_CENTRO_REGIONAL           = $row['NOMBRE_CENTRO_REGIONAL'];
                    $CODIGO_CENTRO_REGIONAL          = $row['CODIGO_CENTRO_REGIONAL'];
                    echo "<option value = $CODIGO_CENTRO_REGIONAL>($CODIGO_CENTRO_REGIONAL) $NOMBRE_CENTRO_REGIONAL</option>";
                }
                echo '</select>';
echo <<<HTML
            </div>
        </div>
                <div id="message"></div>
    </div>
HTML;
?>