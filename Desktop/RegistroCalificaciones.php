<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <title>Registro de Calificaciones</title>
  <link rel="stylesheet" href="../../bootstrap/css/bootstrap.min.css">
</head>
<body>

  <header style="background:#2c3e50;color:#fff">
    <div class="container">
      <h1 style="text-align:center">Registro de Calificaciones</h1>
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
              <th>Nota</th>
              <th>Obs</th>
            </tr>
          </thead>

          <tbody>
            <tr>
              <td>1</td>
              <td>Carlos Maradiaga</td>
              <td>70</td>
              <td>APR</td>
            </tr>
            <tr>
              <td>2</td>
              <td>Joel Gonzales</td>
              <td>73</td>
              <td>APR</td>
            </tr>
            <tr>
              <td>3</td>
              <td>Guadalupe Colindres</td>
              <td>80</td>
              <td>APR</td>
            </tr>
            <tr>
              <td>4</td>
              <td>Samuel Nieto</td>
              <td>73</td>
              <td>APR</td>
            </tr>
            <tr>
              <td>5</td>
              <td>Irma Avila</td>
              <td>74</td>
              <td>APR</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
                                    <!--Creacion de los botones-->

  <div class="row">
    <div class="col-md-offset-4">
      <div class="form-group">
        <button type="button" name="guardar" class=" btn btn-primary">Guardar</button>
        <button type="button" name="imprimirCalificaciones" class=" btn btn-primary">Imprimir Calificaciones</button>
        <button type="button" name="modificar" class=" btn btn-primary">Modificar</button>
      </div>
    </div>
  </div>
  </div>

  </body>
  </html>
