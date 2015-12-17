<?php
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL SP_SELECCIONAR_CENTROS_REGIONALES()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo
<<<HTML
    <div class="col-sm-6 col-md-4">
        <br>
        <br>
        <div class="profile-header-container btn_add" role="button"
            data-toggle="modal" data-target="#addCentrosRegionales">
            <img class="img-circle" src="images/add_centros_regionales.jpg" alt="" id="profile"/>
            <div class="rank-label-container">
                <span class='badge alert-info'>Agregar centro regional</div>
            </div>
        </div>
    </div>
HTML;
    foreach ($rows as $row){
        $CODIGO_CENTRO_REGIONAL           = $row['CODIGO_CENTRO_REGIONAL'];
        $NOMBRE_CENTRO_REGIONAL          = $row['NOMBRE_CENTRO_REGIONAL'];
        $CIUDAD               = $row['CIUDAD'];
        $PAIS     = $row['PAIS'];
        $image = $CODIGO_CENTRO_REGIONAL.".jpg";
        echo
<<<HTML
        <div class="col-sm-6 col-md-3">
            <div class="profile-header-container">
                <!--<img class="img-circle" src="images/profile/$image" id="profile"/>-->
                <div class="rank-label-container">
HTML;
                    
        echo
<<<HTML

                <div class="jumbotron">
                      <div class="container">
                        <h4> $NOMBRE_CENTRO_REGIONAL</h4>
                        <p>
                        <button class="btn_view btn icon-btn btn-primary" role="button"
                            data-toggle="modal" data-target="#viewMoreCentroRegional"
                                data-id = $CODIGO_CENTRO_REGIONAL>
                                <i class="fa fa-street-view"></i>
                                Ver más
                        </button>
                        </p>
                      </div>
                </div>

                <!--<div  style='background-color:#0079BF; opacity :.7; color:white;'>
                    <h4>Edificio $NOMBRE_CENTRO_REGIONAL</h4>
                    <p>
                        <button class="btn_view btn icon-btn btn-primary" role="button"
                            data-toggle="modal" data-target="#viewMoreEdificio"
                                data-id = $CODIGO_CENTRO_REGIONAL>
                                <i class="fa fa-street-view"></i>
                                Ver más
                        </button>
                    </p>
                </div>-->
                <br>
                <br>
                </div>
            </div>
        </div>
HTML;
    }
    
    require_once 'modalCentrosRegionales.php';  
?>