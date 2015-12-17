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
    $stmt = $db->prepare("CALL SP_SELECCIONAR_PAISES()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
 ?>
 <div class="col-sm-6 col-md-4">
 </div>
 <div class="col-sm-6 col-md-4">

        <div class="profile-header-container btn_add" role="button"
            data-toggle="modal" data-target="#addPaises">
            <img class="img-circle" src="images/add_centros_regionales.jpg" alt="" id="profile"/>
            <div class="rank-label-container">
                <span class='badge alert-info'>Agregar paises</div>
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
                <th>Abreviatura</th>
                
                
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>Nombre</th>
                <th>Abreviatura</th>
                
                
            </tr>
        </tfoot>
        <tbody>
        <?php 
          foreach ($rows as $row){
          $CODIGO_PAIS           = $row['CODIGO_PAIS'];
          $NOMBRE_PAIS          = $row['NOMBRE_PAIS'];
          $ABREVIATURA               = $row['ABREVIATURA'];
          
        ?>      
            <tr class="btn_view" role="button" data-toggle="modal" 
            data-target="#viewMorePais" data-id = <?php echo $CODIGO_PAIS; ?> >
                
                <td><img class="img-circle"
                    src="images/profile/$image" id="profile3"/>&nbsp &nbsp &nbsp
                    <?php echo $NOMBRE_PAIS; ?></td>
                <td><?php echo $ABREVIATURA; ?></td>
                
                
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
<?php require_once 'modalsPaises.php'; ?>
</html>

