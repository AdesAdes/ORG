
<!--este es el contenido del modal-->

<?php
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL allCharges()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo <<<HTML
    <div class="form-horizontal" id="addFormEmployed" name="addForm">
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Numero de identidad
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-user fa-fw"></i>
                </span>
                <div class="required-field-block">
                    <input type="text" class="form-control"
                        placeholder="Número de identidad" id="idcard"
                            maxlength="13" onChange="validateCountless(this.value);"
                                require>
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Primer nombre
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-user fa-fw"></i>
                </span>
                <div class="required-field-block">
                    <input type="text" class="form-control"
                        placeholder="Primer nombre" id="fname"
                                onChange="validateName(this.value);">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- segundo nombre
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Segundo nombre
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-user fa-fw"></i>
                </span>
                <div class="required-field-block">
                    <input type="text" class="form-control"
                        placeholder="Segundo nombre" id="sname"
                            onChange="validateName(this.value);">
                </div>
            </div>
        </div>
        -->

        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Primer apellido
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-user fa-fw"></i>
                </span>
                <div class="required-field-block">
                    <input type="text" class="form-control"
                        placeholder="Primer apellido" id="lfname"
                            onChange="validateName(this.value);">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- segundo apellido 
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Segundo apellido
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-user fa-fw"></i>
                </span>
                <div class="required-field-block">
                    <input type="text" class="form-control"
                        placeholder="Segundo apellido" id="lsname"
                            onChange="validateName(this.value);">
                </div>
            </div>
        </div>
        -->
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Teléfono
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-user fa-fw"></i>
                </span>
                <div class="required-field-block">
                    <input type="text" class="form-control"
                        placeholder="Número de teléfono" id="phoneNumber"
                            onChange="validatePhone(this.value);"
                                maxlength="8">
                </div>
            </div>
        </div>
        <!--Numero de telefono movil-->
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Movil
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-user fa-fw"></i>
                </span>
                <div class="required-field-block">
                    <input type="text" class="form-control"
                        placeholder="Movil" id="MovilPhone"
                            onChange="validatePhone(this.value);"
                                maxlength="8">
                </div>
            </div>
        </div>
        <!--Fin de telefono movil-->

        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Correo electrónico
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-user fa-fw"></i>
                </span>
                <div class="required-field-block">
                    <input type="email" class="form-control"
                        placeholder="Correo electrónico" id="email">
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Fecha de nacimiento
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-user fa-fw"></i>
                </span>
                <div class="required-field-block">
                    <input type="date" class="form-control"
                        placeholder="Fecha de nacimiento" id="birthDay"
                            name="fecha">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Dirección
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-key fa-fw"></i>
                </span>
                <div class="required-field-block">
                    <input class="form-control"
                        placeholder="Dirección" id="direction">
                    <div class="required-icon">
                        <div class="text">*</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Cargo
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-users"></i>
                </span>
                <select class="form-control" id="charges">
HTML;
                foreach ($rows as $row){
                    $cargoID           = $row['cargoID'];
                    $nombreCargo          = $row['nombreCargo'];
                    echo "<option value = $cargoID>$nombreCargo</option>";
                }
                echo '</select>';
echo <<<HTML
            </div>
        </div>
          <!--Si la persona es estudiante-->
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Nivel Curso
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-users"></i>
                </span>
                <select class="form-control" id="charges">
HTML;
                include '../../conection/conection.php';
                $stmt1 = $db->prepare("CALL allNevel()");
                $stmt1->execute();
                $rows1 = $stmt1->fetchAll(PDO::FETCH_ASSOC);
                foreach ($rows1 as $row){
                    $CodNevel           = $row['CodNevel'];
                    $NameNevel           = $row['NameNevel'];
                    echo "<option value = $CodNevel>$NameNevel</option>";
                }
                echo '</select>';
echo <<<HTML
            </div>
        </div>  
    <!--fin si es estufiante  -->

                <div id="messageHR"></div>
    </div>
HTML;
?>

<script>
    function validateCountless(number){
        if (!/^([0-9])*$/.test(number))
            $("#messageHR").html('<div class="alert alert-danger">\n\
                La identidad ingresada no es valida</div>');  
        else
                $("#messageHR").html(''); 
    }
    function validatePhone(number){
        var expresionRegular1=/^([0-9]+){8}$/;//<--- con esto vamos a validar el numero
        if(!expresionRegular1.test(number))
            $("#messageHR").html('<div class="alert alert-danger">\n\
             El número de telefono no es valido</div>'); 
        else
            $("#messageHR").html(''); 
    }
    
    function validateName(name){
        if (!/^([a-zA-Z])*$/.test(name))
            $("#messageHR").html('<div class="alert alert-danger">\n\
             El nombre o apellido ingresado no es valido</div>');
        else
            $("#messageHR").html('');  
    }


</script>