<!DOCTYPE html>
<!--
Ingeniería del software
-->
<?php
    session_start();
    if(isset($_GET['content'])){
        $content = $_GET['content'];
    }
    else{
        $content = 'Alumnos';
    }
    require_once 'menuOptions.php';
?>
<head>
    <script src="pages-modules/Estudiante/js.js" type="text/javascript" language="javascript">
    </script>
</head>
<!-- Main -->
<div class="container-fluid" >
    <div class="row">
        <div class="col-sm-9"> 
            <div class="row">
                <div class="col-md-12">
                    <div class="featurette">
                        <div id="ContenedorAlumnos" class="alert">
                          
                        </div>
                  </div>
                </div>
            </div>
        </div>   
    </div>
</div>

