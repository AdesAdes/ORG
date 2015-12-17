
<!-- crea un nuevo usuario-->
<?php
    
echo <<<HTML
    <div class="form-horizontal" id="addRegion" name="addRegion">
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Region
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-university"></i>
                </span>
                <div class="required-field-block">
                    <input type="text" class="form-control"
                        placeholder="Region" id="region">
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

        <div id="message"></div>
    </div>
HTML;
?>