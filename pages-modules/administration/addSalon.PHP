
<!-- crea un nuevo usuario-->
<?php
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL SP_SELECCIONAR_EDIFICIOS()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
echo <<<HTML
    <div class="form-horizontal" id="addSalon" name="addSalon">
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Nombre Aula
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-book"></i>
                </span>
                <div class="required-field-block">
                    <input type="text" class="form-control"
                        placeholder="Aula" id="nombredesalon">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Numero de piso
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-pencil"></i>
                </span>
                <div class="required-field-block">
                    <input type="number" class="form-control"
                        placeholder="Piso" id="numerodepiso">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>
             
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Edificio
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-building-o"></i>
                </span>
                <select class="form-control" id="edificio">
HTML;
                foreach ($rows as $row){
                    $NOMBRE_EDIFICIO           = $row['NOMBRE_EDIFICIO'];
                    $CODIGO_EDIFICIO          = $row['CODIGO_EDIFICIO'];
                    echo "<option value = $CODIGO_EDIFICIO>($CODIGO_EDIFICIO) $NOMBRE_EDIFICIO</option>";
                }
                echo '</select>';
echo <<<HTML
            </div>
        </div>
                <div id="message"></div>
    </div>
HTML;
?>