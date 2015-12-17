
<!-- crea un nuevo usuario-->
<?php
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL SP_VER_LOCALIZACIONES()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
echo <<<HTML
    <div class="form-horizontal" id="addCentroRegional" name="addCentroRegional">
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Centro Regional
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-university"></i>
                </span>
                <div class="required-field-block">
                    <input type="text" class="form-control"
                        placeholder="Centro Regional" id="centroRegional">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Ciuadad
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-globe"></i>
                </span>
                <select class="form-control" id="ciudad">
HTML;
                foreach ($rows as $row){
                    $NOMBRE_CIUDAD           = $row['NOMBRE_CIUDAD'];
                    $CODIGO_LOCALIZACION          = $row['CODIGO_LOCALIZACION'];
                    echo "<option value = $CODIGO_LOCALIZACION>($CODIGO_LOCALIZACION) $NOMBRE_CIUDAD</option>";
                }
                echo '</select>';
echo <<<HTML
            </div>
        </div>
                <div id="message"></div>
    </div>
HTML;
?>