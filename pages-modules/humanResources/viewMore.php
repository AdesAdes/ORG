<style>
    #tel,
    #email{
        margin-right: 16px;
    }
</style>
<?php
    $codE = $_GET['codE'];
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL  selectEmployed(?)");
    $stmt->execute(array($codE));
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($rows as $row){
        $user           = $row['name'];
        $userC          = $row['nameC'];
        $sex            = $row['sex'];
        $codeE          = $row['codeE'];
        $email          = $row['email'];
        $direction      = $row['direction'];
        $birthDay       = $row['birthDay'];
        $idCard         = $row['idCard'];
        $phoneNumber    = $row['phoneNumber'];
        $office         = $row['office'];
        $image = $codE.".jpg";
        echo 
<<<HTML
        <div class="profile-header-container">
                <img class="img-circle" src="images/profile/$image" id="profile"/>
        </div>
            <h3>$userC</h3>
            <div class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Código de empleado
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$codE</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Número de identidad
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$idCard</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Cargo
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$office</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup"
                        id="tel">
                        Teléfono
                    </label>
                    <div class="input-group col-sm-6">
                        <span class="input-group-addon"><span
                            class="glyphicon glyphicon-phone"></span></span>
                        <label class="form-control">$phoneNumber</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Fecha de nacimiento
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$birthDay</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Sexo
                    </label>
                    <div class="col-sm-6">
HTML;
                    if($sex == 'M')
                        echo "<label class='form-control'>Masculino</label>";
                    else
                        echo "<label class='form-control'>Femenino</label>";
        echo
<<<HTML
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Dirección
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$direction</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup"
                        id="email">
                        Correo electrónico
                    </label>
                    <div class="input-group col-sm-6">
                        <span class="input-group-addon">@</span>
                        <label class="form-control">$email</label>
                    </div>
                </div>
            </div>
HTML;
    }
?>

