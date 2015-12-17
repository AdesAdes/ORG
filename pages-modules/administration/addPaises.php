
<!-- crea un nuevo usuario-->
<?php

    
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL  SP_SELECCIONAR_REGIONES()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo <<<HTML
    <div class="form-horizontal" id="addPais" name="addPais">
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Pais
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-university"></i>
                </span>
                <div class="required-field-block">
                    <input type="text" class="form-control"
                        placeholder="Pais" id="pais_p">
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
                        placeholder="Abreviatura" id="abreviatura_pais">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Region
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-globe"></i>
                </span>
                <select class="form-control" id="region_p">
HTML;
                foreach ($rows as $row){
                    $NOMBRE_REGION           = $row['NOMBRE_REGION'];
                    $CODIGO_REGION          = $row['CODIGO_REGION'];
                    echo "<option value = $CODIGO_REGION>($CODIGO_REGION) $NOMBRE_REGION</option>";
                }
                echo '</select>';
echo <<<HTML
            </div>
        </div>
                <div id="message"></div>
    </div>
HTML;

?>