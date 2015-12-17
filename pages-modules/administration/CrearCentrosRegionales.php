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
    $stmt = $db->prepare("CALL SP_SELECCIONAR_CENTROS_REGIONALES()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
 ?>
 <div class="col-sm-6 col-md-4">
 </div>
 <div class="col-sm-6 col-md-4">

        <div class="profile-header-container btn_add" role="button"
            data-toggle="modal" data-target="#addCentrosRegionales">
            <img class="img-circle" src="images/add_centros_regionales.jpg" alt="" id="profile"/>
            <div class="rank-label-container">
                <span class='badge alert-info'>Agregar centro regional</div>
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
                <th>Ciudad</th>
                
                
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>Nombre</th>
                <th>Ciudad</th>
                
                
            </tr>
        </tfoot>
        <tbody>
        <?php 
          foreach ($rows as $row){
          $CODIGO_CENTRO_REGIONAL           = $row['CODIGO_CENTRO_REGIONAL'];
          $NOMBRE_CENTRO_REGIONAL          = $row['NOMBRE_CENTRO_REGIONAL'];
          $CIUDAD               = $row['CIUDAD'];
          $PAIS     = $row['PAIS'];
          $image = $CODIGO_CENTRO_REGIONAL.".jpg";
        ?>      
            <tr class="btn_view" role="button" data-toggle="modal" 
            data-target="#viewMoreCentroRegional" data-id = <?php echo $CODIGO_CENTRO_REGIONAL; ?> >
                
                <td><img class="img-circle"
                    src="images/profile/$image" id="profile3"/>&nbsp &nbsp &nbsp
                    <?php echo $NOMBRE_CENTRO_REGIONAL; ?></td>
                <td><?php echo $CIUDAD; ?></td>
                
                
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
<?php require_once 'modalCentrosRegionales.php'; ?>
</html>

