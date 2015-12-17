    <!DOCTYPE html>
<!--
Ingeniería del software
-->
<?php
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL selectAllEmployed()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo
<<<HTML
    <div class="page-header">
        <h3>Usuarios en linea</h3>
    </div>
HTML;
    
    foreach ($rows as $row){
        $user           = $row['name'];
        $codeE          = $row['codeE'];
        $office         = $row['office'];
        $log            = $row['log'];
        if($log == 1){
        echo
<<<HTML
        <div class="col-sm-6 col-md-4">
            <div class="thumbnail">
                <img src="images/User.png" id="avatar" alt=""/>
                <div class="caption">
                <span class='badge alert-success'>Conectado</div>
                    <h3>$user</h3>
                    <p>$office</p>
                    <p>
                        <button class="btn_view btn btn-primary" role="button"
                            data-toggle="modal" data-target="#viewMore"
                                data-id = $codeE>
                                Ver más
                        </button>
                        <button class="btn_edit btn btn-default" role="button"
                            data-toggle="modal" data-target="#edit"
                                data-id = $codeE>
                                Editar
                        </button>
                    </p>
                </div>
            </div>
        </div>
HTML;
        }
    }
?>