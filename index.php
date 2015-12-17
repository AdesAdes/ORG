<!DOCTYPE html>
<!--
Ingeniería del software
-->
<?php
   //llama al login seguridad 
    include 'login/security.php';
   // tiempo 
    include 'login/time_out.php';
    // manda a llamar ale head 
    require_once ('pages-modules/head.php');
    
?>

<div id="principalContainer">
    <?php
    if(!isset($_GET['content'])){
        //echo 'hoa esta bien lo que hago';
         require_once("pages-modules/home.php");
         require_once ('pages-modules/footer.php');
    }
    else{
        $content= $_GET['content'];
    }
?>
</div>

<script language="JavaScript" type="text/javascript">
    window.onbeforeunload = accionAntesDeSalir;
    function accionAntesDeSalir()
    {
	$.ajax("login/eventoCerrarPestaña.php");
    }
</script>