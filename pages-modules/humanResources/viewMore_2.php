<?php
    $codE = $_GET['codE'];
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL  viewUser(?)");
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
        echo
<<<HTML
            <img src="images/User.png" id="avatar" alt=""/>
            <h3>$userC</h3>
            <div class="form">
                <div class="form-group">
                    <label for="codE">Código de empleado</label>
                    <label class="form-control">$codE</label>
                </div>
                <div class="form-group">
                    <label for="idCard">Número de identidad</label>
                    <label class="form-control">$idCard</label>
                </div>
                <div class="form-group">
                    <label for="office">Cargo</label>
                    <label class="form-control">$office</label>
                </div>
                <div class="form-group">
                    <label for="phoneNumber">Teléfono</label>
                    <label class="form-control">$phoneNumber</label>
                </div>
                <div class="form-group">
                    <label for="birthDay">Fecha de nacimiento</label>
                    <label class="form-control">$birthDay</label>
                </div>
                <div class="form-group">
                    <label for="sex">Sexo</label>
HTML;
                    if($sex == 'M')
                        echo "<label class='form-control'>Masculino</label>";
                    else
                        echo "<label class='form-control'>Femenino</label>";
        echo
<<<HTML
                </div>
                <div class="form-group">
                    <label for="direction">Dirección</label>
                    <label class="form-control">$direction</label>
                </div>
                <div class="form-group">
                    <label for="email">Correo electrónico</label>
                    <label class="form-control">$email</label>
                </div>
            </div>
HTML;
    }
?>

