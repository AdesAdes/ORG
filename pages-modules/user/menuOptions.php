<?php
    session_start();
    $user = $_SESSION['codEmpleado'];
    $user = $user.".jpg";
?>
<div class="span3 col-sm-3">
    <div class="profile-header-container btn-capture" role="button">
        <img class="img-circle img-responsive" src="images/profile/<?php echo $user ?>" alt=""
             style="width: 250px; height: 250px; border: 2px solid #51D2B7;"/>
        <div class="rank-label-container">
            <div class="btn_capture" data-toggle="modal" data-target="#changeImage">
                <span class='badge alert-link'>
                    <span class="fa fa-camera"></span>
                    Tomar imagen
                </span>
            </div>
        </div>
    </div>
</div>
