<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <title>Secciones</title>
  <link rel="stylesheet" href="../../bootstrap/css/bootstrap.min.css">
<body>

<!--Ignora esta parte, es solo para que se mire bien mientras lo desarrollo-->
<header style="background:#2c3e50;color:#fff">
  <div class="container">
    <h1 style="text-align:center">Secciones</h1>
  </div>
</header>

<br>


<div class="container">

<!-- Las secciones supongo se iran llenando automaticamente tambien, solo rellene esos valores para que no se vea vacio-->
<div class="row">
  <div class="col-md-3">
    <div class="form-group">
      <p>Sección</p>
        <select name="Secciones" class="form-control">
          <option value="JP10801">Japones 1 0801</option>
          <option value="JP20801">Japones 2 1000</option>
        </select>
    </div>
  </div>
</div>

                              <!--Creacion de la tabla donde se muestran la informacion del estudiante-->


<div class="form-group">
    <div class="table-responsive">
      <table class="table table-striped table-bordered table-hover">
        <thead>
          <tr class="success">
            <th>N°</th>
            <th>Estudiante</th>
            <th>Celular</th>
            <th>E-Mail</th>
          </tr>
        </thead>

        <tbody>
          <tr>
            <td>1</td>
            <td>Carlos Maradiaga</td>
            <td>123456789</td>
            <td>dfsdfasdf@yahoo.com</td>
          </tr>
          <tr>
            <td>2</td>
            <td>Joel Gonzales</td>
            <td>123456789</td>
            <td>sfsgsfdgsdfg@yahoo.com</td>
          </tr>
          <tr>
            <td>3</td>
            <td>Guadalupe Colindres</td>
            <td>123456789</td>
            <td>sdfgsdfgsfg@yahoo.com</td>
          </tr>
          <tr>
            <td>4</td>
            <td>Samuel Nieto</td>
            <td>123456789</td>
            <td>sfdgsdfgdgh@yahoo.com</td>
          </tr>
          <tr>
            <td>5</td>
            <td>Irma Avila</td>
            <td>7123456789</td>
            <td>sfasdfasfsf@yahoo.com</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
                                  <!--Creacion de los botones-->

<div class="row">
  <div class="col-md-12">
    <div class="form-group">
      <button type="button" name="imprimirCalificaciones" class="btn btn-block btn-primary">Imprimir Lista</button>
    </div>
  </div>
</div>
</div>

</body>
</html>
