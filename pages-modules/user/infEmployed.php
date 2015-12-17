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
        echo
<<<HTML
            <h3>$userC</h3>
<div class="container">
    <div class="col-sm-5">  
        <label class=""><i class="fa fa-barcode"></i>  Código de empleado: $codE </label>
            <br><hr>
        <label class=""><i class="fa fa-credit-card"></i>  Número de identidad: $idCard </label>
            <br><hr>
        <label class=""><i class="fa fa-user"></i>  Cargo: $office </label>
            <br><hr>
HTML;
                if($sex == 'M')
                    echo "<label class=''><i class='fa fa-mars'></i> Masculino </label>";
                else
                    echo "<label class=''><i class='fa fa-female'></i> Femenino </label>";
    echo
<<<HTML
            <br><hr>
        <label class=""><i class="fa fa-comment"></i> Correo: $email </label>
    </div>
    <div class="col-sm-4">
            <label class=""><i class="fa fa-mobile"></i> $phoneNumber</label>
                <br>
            <label class=""><i class="fa fa-building-o"></i>  $direction</label>
                <br>
            <label class="f"><i class="fa fa-birthday-cake"></i> $birthDay</label>
    </div>
</div>
HTML;
    }
?>

