<!DOCTYPE html>
<!--
Ingeniería del software
-->
<?php
    require_once 'modals.php';
    require_once 'menuOptions.php';
?>

<!-- Main -->
<div id="contentUser" class="col-sm-9">
    
</div>

<script>
  $(document).ready(function(){
     $("#contentUser").load("pages-modules/user/panels.php" );
});
</script>