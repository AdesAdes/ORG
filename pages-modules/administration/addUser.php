
<!-- crea un nuevo usuario-->
<?php
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL employeesWithoutUser()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
echo <<<HTML
    <div class="form-horizontal" id="addForm" name="addForm">
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Nombre de usuario
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-user fa-fw"></i>
                </span>
                <div class="required-field-block">
                    <input type="text" class="form-control"
                        placeholder="usuario" id="username">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Contraseña
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-key fa-fw"></i>
                </span>
                <div class="required-field-block">
                    <input type="password" id="password" name="password"
                        class="form-control" placeholder="Contraseña"
                            id="password">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Repetir contraseña
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-key fa-fw"></i>
                </span>
                <div class="required-field-block">
                    <input type="password" id="passwordR" name="passwordR"
                        class="form-control" placeholder="Repetir contraseña"
                            id="password_again">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Empleado
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-users"></i>
                </span>
                <select class="form-control" id="employeds">
HTML;
                foreach ($rows as $row){
                    $user           = $row['name'];
                    $codeE          = $row['codeE'];
                    echo "<option value = $codeE>($codeE) $user</option>";
                }
                echo '</select>';
echo <<<HTML
            </div>
        </div>
                <div id="message"></div>
    </div>
HTML;
?>