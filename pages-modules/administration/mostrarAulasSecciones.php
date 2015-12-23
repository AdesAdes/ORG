<?php    
    
    $result = $_GET['edificio'];
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL SP_VER_AULAS_X_EDIFICIO(?)");
    $stmt->execute(array($result));
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
echo <<<HTML
               
        <div class="form-group">
            <label class="col-sm-4 control-label" for="formGroup">
                Aula
            </label>
            <div class="input-group col-sm-6">
                <span class="input-group-addon">
                    <i class="fa fa-building-o"></i>
                </span>
                <select class="form-control" id="aula">
HTML;
                foreach ($rows as $row){
                    $NOMBRE_AULA           = $row['NOMBRE_AULA'];
                    $CODIGO_AULA          = $row['CODIGO_AULA'];
                    echo "<option value = $CODIGO_AULA>($CODIGO_AULA) $NOMBRE_AULA</option>";
                }
                echo '</select>';
echo <<<HTML
            </div>
        </div>
    
HTML;
?>