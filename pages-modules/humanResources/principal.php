<!DOCTYPE html>
<!--
Ingeniería del software
-->
<?php
    require_once 'modals.php';
    require_once 'menuOptions.php';
?>

<!-- Main -->
<div id="contentAdministration" class="col-sm-7">
    
</div>

<script>
  $(document).ready(function(){
     $("#contentAdministration").load("pages-modules/humanResources/employedAdministration.php" );
  });
</script>