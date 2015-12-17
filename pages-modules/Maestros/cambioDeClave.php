<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
<!--	<link rel="stylesheet" type="text/css" href="pages-modules/reception/diseño.css">
	<link rel="stylesheet" type="text/css" href="pages-modules/reception/bootstrap.css">-->
	<!--<script type="text/javascript" src="pages-modules/receptoion/modulePages/jquery-2.1.4.min.js"></script>-->
       
     <script type="text/javascript">
      
    $("#Cambiodeclave").click(function(event) {
        
         var claveAnterior = document.getElementById("Clave_Actual").value; 
         var nuevaClave = document.getElementById("Nueva_Actual").value;
         var ConfirmacionDeClave = document.getElementById("Confirmacion_De_Clave").value;
         
         if(claveAnterior==""){
             alert("Ingrese la clave Actual");
         }
         else{
            if(nuevaClave==""){
              alert("No hay nueva contraseña");
            }
            else{
              
            }
         }
       
    });
        
        </script>
</head>
<body>

<div class="container">
<div class="row " style="margin: 10px;">
	<div class="col-sm-12" style="margin: 10px">   

	 		<ul class="nav nav-tabs">
  			<li role="presentation" class="active" id="buscarEmpleado"><a class="button">Cambiar Clave</a></li>
<!--  			<li role="presentation" id="crearCita"><a class="button" >Crear Cita</a></li>
  			<li role="presentation" id="borrarCita"><a class="button"  >Cancelar Cita</a></li>-->
  			</ul>
	</div>
</div>

  
<div class="row col-sm-9" id="formulario_nueva_cita">

  <div class="form-group row col-sm-8">
    <label for="Clave_Actual">Clave Actual</label>
    <input type="password" maxlength="20" class="form-control" id="Clave_Actual"
           placeholder="Clave Actual">
  </div>
  <div class="form-group row col-sm-8">
    <label for="Nueva_clave">Nueva Clave</label>
    <input type="password" maxlength="20" class="form-control" id="Nueva_Actual"
           placeholder="Nueva Clave">
  </div> 
  <div class="row col-sm-8">

    <label for="Confirmacion_De_Clave">Confirmacion De Clave</label>
    <input type="password" maxlength="20" class="form-control" placeholder="Confirmacion De Clave" id="Confirmacion_De_Clave">

  </div> 
  <div class="row col-sm-12">
      <button type="submit"   class="btn btn-default" id="Cambiodeclave">Cambiar clave</button>
  </div>
</div>
</div>
</div>

</body>
</html>


