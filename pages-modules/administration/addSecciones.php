
<!-- crea un nuevo usuario-->
<?php




    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL SP_SELECCIONAR_EDIFICIOS()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
echo <<<HTML
               
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Edificio
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-building-o"></i>
                </span>
                <select class="form-control" id="edificio" >
HTML;

                foreach ($rows as $row){
                    $NOMBRE_EDIFICIO           = $row['NOMBRE_EDIFICIO'];
                    $CODIGO_EDIFICIO          = $row['CODIGO_EDIFICIO'];
                    echo "<option value = $CODIGO_EDIFICIO>($CODIGO_EDIFICIO) $NOMBRE_EDIFICIO</option>";
                }
                
                echo '</select>';



             
echo <<<HTML


            </div>
        </div>
                
        
    <script>
        $("#edificio").click(function(event){
            edificio = document.getElementById('edificio');
            edificio = edificio.options[edificio.selectedIndex].value;
            
            $.get('pages-modules/administration/mostrarAulasSecciones.php',{ edificio: edificio}, function(html){
                    $("#message").html(html);
            });
        });

    </script>
HTML;






   include '../../conection/conection.php';
    $stmt = $db->prepare("CALL SP_SELECCIONAR_ASIGNATURAS()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
echo <<<HTML


        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Clase
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-globe"></i>
                </span>
                <select class="form-control" id="asignatura">
HTML;
                foreach ($rows as $row){
                    $NOMBRE_ASIGNATURA           = $row['NOMBRE_CLASE'];
                    $CODIGO_ASIGNATURA          = $row['CODIGO_CLASE'];
                    echo "<option value = $CODIGO_ASIGNATURA>($CODIGO_ASIGNATURA) $NOMBRE_ASIGNATURA</option>";
                }
                echo '</select>';
echo <<<HTML
            </div>
        </div>
                
    
HTML;


    
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL SP_SELECCIONAR_MAESTROS()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
echo <<<HTML
        
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Maestro
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-globe"></i>
                </span>
                <select class="form-control" id="maestros">
HTML;
                foreach ($rows as $row){
                    $NOMBRE_MAESTRO           = $row['NOMBRE'];
                    $APELLIDO           = $row['APELLIDO'];
                    $CODIGO_PERSONA          = $row['CODIGO_PERSONA'];
                    echo "<option value = $CODIGO_PERSONA>($CODIGO_PERSONA) $NOMBRE_MAESTRO - $APELLIDO</option>";
                }
                echo '</select>';
echo <<<HTML
            </div>
        </div>
                
HTML;





    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL SP_VER_HORARIOS()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    
echo <<<HTML
        
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Horario
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-globe"></i>
                </span>
                <select class="form-control" id="horario">
HTML;
                foreach ($rows as $row){
                    $HORA_INICIO           = $row['HORA_INICIO'];
                    $HORA_FIN           = $row['HORA_FIN'];
                    $CODIGO_HORARIO          = $row['CODIGO_HORARIO'];
                    echo "<option value = $CODIGO_HORARIO>($CODIGO_HORARIO) $HORA_INICIO - $HORA_FIN</option>";
                }
                echo '</select>';
echo <<<HTML
            </div>
        </div>
                
HTML;



include '../../conection/conection.php';
    $stmt = $db->prepare("CALL SP_SELECCIONAR_PERIODOS()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
echo <<<HTML


        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Periodo
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-globe"></i>
                </span>
                <select class="form-control" id="periodos">
HTML;
                foreach ($rows as $row){
                    $NOMBRE_PERIODO           = $row['PERIODO'];
                    $CODIGO_PERIODO          = $row['CODIGO_PERIODO'];
                    echo "<option value = $CODIGO_PERIODO>($CODIGO_PERIODO) $NOMBRE_PERIODO</option>";
                }
                echo '</select>';
echo <<<HTML
            </div>
        </div>
                
    
HTML;



echo <<<HTML


        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Dias Clase
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-globe"></i>
                </span>
                <select class="form-control" id="dias">
                    <option value = 1>LUMAMIJU</option>
                    <option value = 2>VI</option>
                    <option value = 3>SA</option>
                </select>

            </div>
        </div>
                <div id="message"></div>
    </div>
    
HTML;
?>