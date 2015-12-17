<!DOCTYPE html>
<!--
Ingeniería del software
-->
<?php
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL selectAllEmployed()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
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
        echo
<<<HTML
        <div class="col-sm-6 col-md-3">
            <div class="thumbnail">
                <img src="images/User.png" id="avatar" alt=""/>
                <div class="caption">
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
?>

<div class="modal fade" id="viewMore" tabindex="-1" role="dialog"
    aria-labelledby="Modallabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Cerrar</span>
                </button>
                <h4 class="modal-title">Información de usuario</h4>
            </div>
            <div class="modal-body">
                
            </div>
            <div class="modal-footer right">
                <button type="button" class="btn btn-danger"
                    data-dismiss="modal">
                            Cerrar
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="edit" tabindex="-1" role="dialog"
    aria-labelledby="Modallabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Cerrar</span>
                </button>
                <h4 class="modal-title">Editar usuario</h4>
            </div>
            <div class="modal-body">
                
            </div>
            <div class="modal-footer right">
                <button type="button" class="btn_update btn btn-success"
                    data-dismiss="modal">
                            Actualizar
                </button>
                <button type="button" class="btn btn-danger"
                    data-dismiss="modal">
                            Cerrar
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $(".btn_view").click(function(event){
            event.preventDefault();
            id = $(this).data('id');
            $.get('pages-modules/administration/viewMore.php?codE=' + id, function(html){
                $('#viewMore .modal-body').html(html);
            });
        });
        
        $(".btn_edit").click(function(event){
            event.preventDefault();
            id = $(this).data('id');
            $.get('pages-modules/administration/edit.php?codE=' + id, function(html){
                $('#edit .modal-body').html(html);
            });
        });
    });
</script>