<!DOCTYPE html>
<!--

-->
<?php
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL mostRelevantUsers()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo
<<<HTML
    <div class="col-sm-6 col-md-4">
        <br>
        <br>
        <div class="profile-header-container btn_add" role="button"
            data-toggle="modal" data-target="#addUser">
            <img class="img-circle" src="images/add_user.png" alt="" id="profile"/>
            <div class="rank-label-container">
                <span class='badge alert-info'>Agregar usuario</div>
            </div>
        </div>
    </div>
HTML;
    foreach ($rows as $row){
        $user           = $row['name'];
        $codeE          = $row['codeE'];
        $office         = $row['office'];
        $log            = $row['log'];
        $image = $codeE.".jpg";
        echo
<<<HTML
        <div class="col-sm-6 col-md-4">
            <div class="profile-header-container">
                <img class="img-circle" src="images/profile/$image" id="profile"/>
                <div class="rank-label-container">
HTML;
                    if($log == 1)
                        echo "<span class='badge alert-success'>Conectado</div>";
                    else
                        echo "<span class='badge alert-danger'>Desconectado</div>";
        echo
<<<HTML
                    <h4>$user</h4> $office
                    <p>
                        <button class="btn_view btn icon-btn btn-primary" role="button"
                            data-toggle="modal" data-target="#viewMore"
                                data-id = $codeE>
                                <i class="fa fa-street-view"></i>
                                Ver más
                        </button>
                    </p>
                </div>
            </div>
        </div>
HTML;
    }
    
    require_once 'modals.php';  
?>