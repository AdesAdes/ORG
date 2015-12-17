<!DOCTYPE html>
<!--
Ingeniería del software
-->
<?php
    //Se incluye el archivo para la conexión con la base de datos
    include 'conection/conection.php';
    
    /*
     *Se captura el rol y el codigo de usuario ya logueado para optener el
     * nombre del empleado con este codigo
     */
    $rol = $_SESSION['codRole'];
    $user = $_SESSION['codEmpleado'];
    
    //Se prepara la llamada al procedimiento, se ejecuta y captura el nombre
    $stmt = $db->prepare("CALL selectEmployed(?)");
    $stmt->execute(array($user));
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($rows as $row){
        $user = $row['name'];
    }
?>

<html>
    <head>
        <meta charset="UTF-8">
        <title>AHBEJA</title>
        <meta name = "viewport" content = "width = device-whidth, initial-scale=1">
        <!-- Estilos css -->
        <!-- Estilos de bootstrap -->
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        
        <!-- Estilos personales -->
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link href="css/style2.css" rel="stylesheet" type="text/css"/>
        <link href="css/style3.css" rel="stylesheet" type="text/css"/>
        <link href="css/style4.css" rel="stylesheet" type="text/css"/>
        <link href="css/style6.css" rel="stylesheet" type="text/css"/>
        <!-- Iconos -->
        <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        
        <!-- Validador de contraseñas -->
        <link href="bootstrap/css/site-demos.css" rel="stylesheet" type="text/css"/>
        <!-- Estilos css -->
        
        
    </head>
    <body>
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header page-scroll">
                    <button type='button' class='navbar-toggle'
                        data-toggle='collapse' data-target='#headNavbar'>
                        <span class="sr-only">Navegación responsiva</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <!---<a class="navbar-brand page-scroll" href="#" rel="popover"
                       data-placement="bottom" data-content=""
                       data-original-title="">
                        <i class="fa fa-th"></i>
                    </a>--->
                    <a class="navbar-brand page-scroll" role="button" id="homes">AHBEJA<small></small></a>
                </div>
                <div class="collapse3 navbar-collapse" id="headNavbar">
                    <ul class="nav navbar-nav navbar-left">
                    <!-- Generacion del navbar  -->
                    <?php
                        // --------------------------------------------------------------
                        // pagina del -  estudiante
                        if($rol == 2){
                            echo <<<HTML
                                <li><a class="pages-scroll" role="button" id="Estudiante">Estudiante</a></li>
HTML;
                        }else{
//                            echo <<<HTML
//                                <li class="disabled"><a class="pages-scroll" role="button">Estudiante</a></li>
//HTML;
                        }
                        // --------------------------------------------------------------  
                        // página del Maestro
                        if($rol == 3){
                            echo <<<HTML
                                <li><a  class="pages-scroll" role="button" id="Maestro">Maestro</a></li>
HTML;
                        }else{
//                            echo <<<HTML
//                                <li class="disabled"><a  class="pages-scroll" role="button">Maestro</a></li>
//HTML;
                        }
 
                        // --------------------------------------------------------------  
                        // página de RRHH
                        if($rol == 1){
                            echo <<<HTML
                                <li><a  class="pages-scroll" role="button" id="resources">Recursos Humanos</a></li>
                                  <li><a  class="pages-scroll" role="button" id="Maestro">Maestro</a></li>
HTML;
                        }else{
//                            echo <<<HTML
//                                <li class="disabled"><a  class="pages-scroll" role="button">RR HH</a></li>
//HTML;
                        }
                         if($rol == 5){
                            echo <<<HTML
                                <li><a  class="pages-scroll" role="button" id="resources">Recursos Humanos</a></li>
HTML;
                        }else{
//                            echo <<<HTML
//                                <li class="disabled"><a  class="pages-scroll" role="button">RR HH</a></li>
//HTML;
                        }
                   
                    ?>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <?php
                        //En esta parte se carga la del usuario según su rol
                        if($rol == 1){
                            echo <<<HTML
                                    <li class="dropdown">   
                                        <a id ="admin" role="button" class="fa fa-cogs" >
                                                Administración
                                        </a>
                                    </li> 
HTML;
                        }
                        ?>
                        <li class="dropdown">
                            <a id="" role="button" class="fa fa-user">
                                <?php echo " ".$user; ?>
                            </a>
                        </li>
                        <li class="dropdown" >
                            <a href="login/login.php" role="button">
                               <i class="glyphicon glyphicon-log-out"></i> Salir
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <script src="bootstrap/js/jquery-2.1.4.min.js" type="text/javascript"></script>
        <script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>
        <script src="js/functionsNavbar.js" type="text/javascript"></script>
        <script src="js/otherFunctionsNavbar.js" type="text/javascript"></script>
        <script src="js/other.js" type="text/javascript"></script>
        <script src="js/new.js" type="text/javascript"></script>
        <!-- Gráficos -->
        <script src="Highcharts/js/highcharts.js" type="text/javascript"></script>
        <!-- Validador de contraseñas -->
        <script src="bootstrap/js/additional-methods.min.js" type="text/javascript"></script>
        <script src="bootstrap/js/jquery.validate.min.js" type="text/javascript"></script>
        <!-- Utililzado para encriptar y desencriptar contraseñas -->
        <script src="js/encrypt.js" type="text/javascript"></script>


   
        <script>
            $(function(){
                $('[rel=popover]').popover({ 
                    html : true, 
                    content: function() {
                      return $('#popover_content_wrapper').html();
                    }
                });
            });
        </script>


    </body>
</html>
