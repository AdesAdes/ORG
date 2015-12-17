<!--Editar perfil de usuario -->
<?php
    $codE = $_GET['codE'];
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL  viewEmployed(?)");
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
            <div class="thumbnail">
                <img src="images/User.png" id="avatar" alt=""/>
                <div class="caption">
                    <h3>$userC</h3>
                    <p><strong>Código de empleado:  </strong>$codE<p>
                    <p><strong>Número de identidad: </strong>$idCard<p>
                    <p><strong>Cargo:               </strong>$office</p>
                    <p><strong>Teléfono:            </strong><input type='text'/></p>
                    <p><strong>Fecha de nacimiento: </strong>$birthDay</p>
                    <p><strong>Sexo:                </strong>
HTML;
                    if($sex == 'M')
                        echo "Masculino";
                    else
                        echo "Femenino";
        echo
<<<HTML
                    <p><strong>Dirección:           </strong><input type='text'/></p>
                    <p><strong>Correo:           </strong><input type='text'/></p>
                </div>
            </div>
HTML;
    }
?>