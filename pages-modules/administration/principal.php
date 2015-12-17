<!DOCTYPE html>
<!--
Ingeniería del software
-->
<?php
    require_once 'modals.php';
    require_once 'menuOptions.php';
?>

<!-- Main -->
<div id="contentAdministration" class="col-sm-6">
    
</div>

<?php
    require_once 'allUsers.php';
?>

<script>
  $(document).ready(function(){
     $("#contentAdministration").load("pages-modules/administration/usersAdministration.php" );
  });
</script>