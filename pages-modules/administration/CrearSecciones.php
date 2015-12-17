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
    $stmt = $db->prepare("CALL SP_SELECCIONAR_SECCIONES()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
 ?>
 <div class="col-sm-6 col-md-4">
 </div>
 <div class="col-sm-6 col-md-4">

        <div class="profile-header-container btn_add" role="button"
            data-toggle="modal" data-target="#addSecciones">
            <img class="img-circle" src="images/add_secciones.png" alt="" id="profile"/>
            <div class="rank-label-container">
                <span class='badge alert-info'>Agregar Seccion</div>
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

                <th>Seccion</th>
                <th>Clase</th>
                <th>Hora inicio</th>
                <th>Hora fin</th>
                <th>Dias</th>
              
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>Seccion</th>
                <th>Clase</th>
                <th>Hora inicio</th>
                <th>Hora fin</th>
                <th>Dias</th>
                
                
            </tr>
        </tfoot>
        <tbody>
        <?php 
          foreach ($rows as $row){
          $CODIGO_SECCION           = $row['CODIGO_SECCION'];
          $NOMBRE_CLASE          = $row['NOMBRE_CLASE'];
          $HORA_INICIO               = $row['HORA_INICIO'];
          $HORA_FIN     = $row['HORA_FIN'];
          $DIAS         = $row['DIAS'];
        ?>      
            <tr class="btn_view" role="button" data-toggle="modal" 
            data-target="#viewMoreSeccion" data-id = <?php echo $CODIGO_SECCION; ?> >
                
                <td><?php echo $CODIGO_SECCION; ?></td>
                <td><?php echo $NOMBRE_CLASE; ?></td>
                <td><?php echo $HORA_INICIO; ?></td>
                <td><?php echo $HORA_FIN; ?></td>
                <td><?php echo $DIAS; ?></td>
                
                
            </tr>
        <?php
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
<?php require_once 'modalsSecciones.php'; ?>
</html>

