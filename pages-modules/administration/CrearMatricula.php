<!DOCTYPE html>
<html>
<head>
        <meta charset="UTF-8">
        
        <meta name = "viewport" content = "width = device-whidth, initial-scale=1">
        <!-- Estilos css -->
        <!-- Estilos de bootstrap -->
        <link href="css/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
        
 </head>


<?php
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL SP_SELECCIONAR_ESTUDIANTES()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
 ?>
 <div class="col-sm-6 col-md-4">
</div>
    <div class="col-sm-6 col-md-4">
        <br>
        <br>
        <div class="profile-header-container btn_add" role="button"
            data-toggle="modal" data-target="#addSalones">
            <img class="img-circle" src="images/add_salones.jpg" alt="" id="profile"/>
            <div class="rank-label-container">
                <span class='badge alert-info'>Agregar estudiantes</div>
            </div>
        </div>
    </div>
    <br>
  <br>
  <br>
  <br>
 <div class="container col-md-12" >
 <div class="form-group">
<div class="table-responsive">
<table id="example" class="table table-striped table-bordered table-hover" >
        <thead>
            <tr>

                <th>Nombre</th>
                <th>Apellido</th>
                <th>Nivel</th>
                <th>Estado</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Nivel</th>
                <th>Estado</th>
            </tr>
        </tfoot>
        <tbody>

<?php
    foreach ($rows as $row){
        $CODIGO_PERSONA           = $row['CODIGO_PERSONA'];
        $NOMBRE          = $row['NOMBRE'];
        $ESTADO               = $row['estado'];
        $APELLIDO               = $row['APELLIDO'];
        $NIVEL               = $row['NOMBRE_NIVEL'];
        $image = $CODIGO_PERSONA.".jpg";
        if($ESTADO == 's'){
        ?>
        
                   <!-- /*if($ESTADO == 1)
                        echo "<span class='badge alert-success'>Activado</div>";
                    else
                        echo "<span class='badge alert-danger'>Desactivado</div>";*/-->

                    
                        <tr class="btn_view" role="button"
                            data-toggle="modal" data-target="#viewMoreMatricula"
                                data-id = <?php echo $CODIGO_PERSONA ?> >
                            <td><?php echo $NOMBRE ?></td>
                            <td><?php echo $APELLIDO ?></td>
                            <td><?php echo $NIVEL ?></td>
                            <td>activado</td>    
                        </tr>
                      
<?php
        }
        else if($ESTADO == 'n'){
?>
            <tr class="btn_view" role="button"
                            data-toggle="modal" data-target="#viewMoreMatricula"
                                data-id = <?php echo $CODIGO_PERSONA ?> >
                            <td><?php echo $NOMBRE ?></td>
                            <td><?php echo $APELLIDO ?></td>
                            <td><?php echo $NIVEL ?></td>
                            <td>Desactivado</td>    
                        </tr>
    <?php
        }
    }
?>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="js/js/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="js/js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="js/js/dataTables.bootstrap.min.js" type="text/javascript"></script>
    <script >
      $(document).ready(function() {
        $('#example').DataTable();
    } );
    </script>
<?php
    require_once 'modalsMatricula.php';  
?>