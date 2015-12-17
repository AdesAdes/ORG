<?php
    session_start();
    $codeE = $_SESSION['codEmpleado'];
    echo "<input value=$codeE id='hidden' hidden/>";
?>
<div class="panel-group">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a data-toggle="collapse" href="#employed" aria-expanded="true"
                   class="col-sm-4" id="ide" data-id = <?php echo $codeE ?>>
                    <span class="fa fa-male" aria-hidden="true"></span>
                    Información de empleado
                </a>
                <a role="button" class="col-sm-offset-7">
                    
                </a>
            </h4>
            
        </div>
        <div class="panel-collapse collapse in" id="employed">
            <div class="panel-body">
                
            </div>
        </div>
    </div>
    
    <div class="panel panel-info">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a data-toggle="collapse" href="#userInf" aria-expanded="true"
                   class="col-sm-4" id="idu" data-id = <?php echo $codeE ?>>
                    <span class="fa fa-user" aria-hidden="true"></span>
                    Información de usuario
                </a>
                <a role="button" class="col-sm-offset-7">

                </a>
            </h4>
        </div>
        <div class="panel-collapse collapse" id="userInf">
            <div class="panel-body">
                
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        id = $("#hidden").val();
        $.get('pages-modules/user/infEmployed.php?codE=' + id, function(html){
                $('#employed .panel-body').html(html);
            });
        $.get('pages-modules/user/infUser.php?codE=' + id, function(html){
                $('#userInf .panel-body').html(html);
            });

    });
</script>