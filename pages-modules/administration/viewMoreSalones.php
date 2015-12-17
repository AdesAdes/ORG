<!--
Vista de los usuarios  con detalle 
-->
<?php
    $CODIGO_AULA = $_GET['CODIGO_AULA'];
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL  SP_VER_AULAS(?)");
    $stmt->execute(array($CODIGO_AULA));
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($rows as $row){
        $nombreAula       = $row['NOMBRE_AULA'];
        $NOMBRE_EDIFICIO   = $row['NOMBRE_EDIFICIO'];
        $estado   = $row['ESTADO'];
        $image = $CODIGO_AULA.".jpg";
        echo 
<<<HTML
        <div class="profile-header-container">
                <!--<img class="img-circle" src="images/profile/$image" id="profile"/>-->
                <div class="rank-label-container">
HTML;
                    /*if($estado == 1)
                        echo "<span class='badge alert-success'>Activo</div>";
                    else
                        echo "<span class='badge alert-danger'>Desactivado</div>";*/
        echo
<<<HTML
        </div>
            <div class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Aula
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$nombreAula</label>
                        <input id="aula" value=$CODIGO_AULA hidden>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Edificio
                    </label>
                    <div class="col-sm-6">
                        <label class="form-control">$NOMBRE_EDIFICIO</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="formGroup">
                        Estado
                    </label>
                    <div class="input-group col-sm-6" style="padding-left: 14px;">
HTML;
                        if($estado == 1)
                        echo 
<<<HTML
                        <label class='form-control' id="status">Activo</label>
                        <span class="input-group-addon alert-danger disabling"
                            role="button" id="action">
                            <i class="fa fa-power-off"></i>
                        </span>
HTML;
                    else
                        echo 
<<<HTML
                        <label class='form-control' id="status">
                            Deshabilitado
                        </label>
                        <span class="input-group-addon alert-success active"
                            role="button" id="action">
                            <i class="fa fa-power-off"></i>
                        </span>
HTML;

    } 
?>   
<script>
    $(document).ready(function() {
        $('.active').tooltip({
            placement: 'rigth',
            title: 'Activar usuario'
        });
        $('.active').click(function(){
            action = 2;
            aula = $("#aula").val();
            estado = 1;
            $.get('pages-modules/administration/actions_aulas.php',{ aula: aula,estado: estado, action: action}, function(html){
                $("#status").html(html);
                $("#action").removeClass("active");
                $("#action").addClass("disabling");
                $("#action").removeClass("alert-success");
                $("#action").addClass("alert-danger");
            });
        });
        $('.disabling').tooltip({
            placement: 'rigth',
            title: 'Desactivar usuario'
        });
        $('.disabling').click(function(){
            action = 2;
            aula = $("#aula").val();
            estado = 0;
            $.get('pages-modules/administration/actions_aulas.php',{ aula: aula,estado: estado, action: action}, function(html){
                $("#status").html(html);
                $("#action").removeClass("disabling");
                $("#action").addClass("active");
                $("#action").removeClass("alert-danger");
                $("#action").addClass("alert-success");
            });
        });
    });
</script>   