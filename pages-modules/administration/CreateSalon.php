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
    $stmt = $db->prepare("CALL SP_SELECCIONAR_SALONES()");
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
                <span class='badge alert-info'>Agregar salon</div>
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

                <th>Aula</th>
                <th>Estado</th>

            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>Aula</th>
                <th>Estado</th>
                
                
            </tr>
        </tfoot>
        <tbody>

<?php
    foreach ($rows as $row){
        $CODIGO_AULA           = $row['CODIGO_AULA'];
        $NOMBRE_AULA          = $row['NOMBRE_AULA'];
        $ESTADO               = $row['ESTADO'];
        $image = $CODIGO_AULA.".jpg";
        if($ESTADO == 1){
        ?>
        
                   <!-- /*if($ESTADO == 1)
                        echo "<span class='badge alert-success'>Activado</div>";
                    else
                        echo "<span class='badge alert-danger'>Desactivado</div>";*/-->

                    
                        <tr class="btn_view" role="button"
                            data-toggle="modal" data-target="#viewMoreSalon"
                                data-id = <?php echo $CODIGO_AULA ?> >
                            <td><?php echo $NOMBRE_AULA ?></td>
                            <td>Activo</td>    
                        </tr>
                      
<?php
        }
        else{
?>
            <tr class="btn_view" role="button"
                            data-toggle="modal" data-target="#viewMoreSalon"
                                data-id = <?php echo $CODIGO_AULA ?> >
                            <td><?php echo $NOMBRE_AULA ?></td>
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
    require_once 'modalSalones.php';  
?>