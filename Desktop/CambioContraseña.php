<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <title>Cambio de Contraseña</title>
  <link rel="stylesheet" href="../../bootstrap/css/bootstrap.min.css">
</head>
<body>

<header style="background:#2c3e50;color:#fff">
  <div class="container">
    <h1 style="text-align:center">Cambio de Contraseña</h1>
  </div>
</header>

<br><br>

<!-- Creacio del menu para cambiar la contraseña-->

<div class="container">

<form action="index.html" method="post" class="form-horizontal" >

<div class="form-group">
<label for="contraseñaActual" class="control-label col-md-2" >Contraseña Actual</label>
<div class="col-md-10">
<input type="password" name="ContraseñaActual" class="form-control">
</div>
</div>

<div class="form-group">
<label for="nuevaContraseña" class="control-label col-md-2">Nueva Contraseña</label>
<div class="col-md-10">
<input type="password" name="nuevaContraseña" class="form-control">
</div>
</div>

<div class="form-group">
<label for="confirmeContraseña" class="control-label col-md-2">Confirme Contraseña</label>
<div class="col-md-10">
<input type="password" name="confirmeContraseña" class="form-control">
</div>
</div>

<div class="form-group">
<input type="button" name="guardar" class="btn btn-block btn-primary" value="Guardar">
</div>

</form>

</div>


</body>
</html>
