<!DOCTYPE html>
<!--
agrega un nuevo empleado
-->
<?php
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL selectAllEmployed()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo
<<<HTML
    <div class="col-sm-6 col-md-4">
        <br>
        <br>
        <div class="profile-header-container btn_addEmployed" role="button"
            data-toggle="modal" data-target="#addEmployed">
            <img class="img-circle" src="images/add_user.png" alt="" id="profile"/>
            <div class="rank-label-container">
                <span class='badge alert-info'>Agregar Perfil De Usuario</div>
            </div>
        </div>
    </div>
HTML;
    
    foreach ($rows as $row){
        $user           = $row['name'];
        $sex            = $row['sex'];
        $codeE          = $row['codeE'];
        $email          = $row['email'];
        $direction      = $row['direction'];
        $birthDay       = $row['birthDay'];
        $idCard         = $row['idCard'];
        $phoneNumber    = $row['phoneNumber'];
        $office         = $row['office'];
        $image = $codeE.".jpg";
        echo
<<<HTML
        <div class="col-sm-6 col-md-4">
            <div class="thumbnail">
                <div class="profile-header-container">
                    <img class="img-circle" src="images/profile/$image" id="profile"/>
                </div>
                <div class="caption">
                    <h4>$user</h4>
                    <p>$office</p>
                    <p>
                        <button class="btn_view btn btn-primary" role="button"
                            data-toggle="modal" data-target="#viewMore"
                                data-id = $codeE>
                                Ver más
                        </button>
                    </p>
                </div>
            </div>
        </div>
HTML;
    }
?>

<?php
    require_once 'modals.php';
?>