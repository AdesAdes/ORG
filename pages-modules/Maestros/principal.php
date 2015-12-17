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
        $content = 'Maestros';
    }
    require_once 'menuOptions.php';
?>
<head>
    <script src="pages-modules/Maestros/js.js" type="text/javascript" language="javascript">
    </script>
</head>
<!-- Main -->
<div class="container-fluid" >
    <div class="row">
        <div class="col-sm-9"> 
            <div class="row">
                <div class="col-md-12">
                    <div class="featurette">
                        <div id="ContenedorMaestros" class="alert alert-info">
                          
                        </div>
                  </div>
                </div>
            </div>
        </div>   
    </div>
</div>

