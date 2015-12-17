
<!-- crea un nuevo usuario-->
<?php

    
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL  SP_SELECCIONAR_PAISES()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo <<<HTML
    <div class="form-horizontal" id="addCiudad" name="addCiudad">
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Ciudad
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-university"></i>
                </span>
                <div class="required-field-block">
                    <input type="text" class="form-control"
                        placeholder="Nombre ciudad" id="ciudad">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Abreviatura
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-university"></i>
                </span>
                <div class="required-field-block">
                    <input type="text" class="form-control"
                        placeholder="Abreviatura" id="abreviatura">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Codigo postal
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-university"></i>
                </span>
                <div class="required-field-block">
                    <input type="text" class="form-control"
                        placeholder="Codigo postal" id="codigoPostal">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Pais
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-globe"></i>
                </span>
                <select class="form-control" id="pais">
HTML;
                foreach ($rows as $row){
                    $NOMBRE_PAIS           = $row['NOMBRE_PAIS'];
                    $CODIGO_PAIS          = $row['CODIGO_PAIS'];
                    echo "<option value = $CODIGO_PAIS>($CODIGO_PAIS) $NOMBRE_PAIS</option>";
                }
                echo '</select>';
echo <<<HTML
            </div>
        </div>
                <div id="message"></div>
    </div>
HTML;

?>