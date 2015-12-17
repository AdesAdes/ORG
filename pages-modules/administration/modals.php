<div class="modal fade" id="viewMore" tabindex="-1" role="dialog"
    aria-labelledby="Modallabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Cerrar</span>
                </button>
                <h4 class="modal-title">Información de usuario</h4>
            </div>
            <div class="modal-body">
                
            </div>
            <div class="modal-footer right">
                <button type="button" class="btn btn-warning">
                    <i class="fa fa-user-secret"></i>
                    Recuperar contraseña
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="addUser" tabindex="-1" role="dialog"
    aria-labelledby="Modallabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Cerrar</span>
                </button>
                <h4 class="modal-title">Agregar usuario</h4>
            </div>
            <div class="modal-body">
                
            </div>
            <div class="modal-footer right">
                <button type="button" class="btn btn-success" id="adding">
                    <i class="fa fa-user-plus"></i>
                            Agregar
                </button>
                <button type="button" class="btn btn-danger"
                    data-dismiss="modal">
                    <i class="fa fa-times"></i>
                            Cerrar
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $(".btn_view").click(function(event){
            event.preventDefault();
            id = $(this).data('id');
            $.get('pages-modules/administration/viewMore.php?codE=' + id, function(html){
                $('#viewMore .modal-body').html(html);
            });
        });
        
        $(".btn_add").click(function(event){
            event.preventDefault();
            id = $(this).data('id');
            $.get('pages-modules/administration/addUser.php', function(html){
                $('#addUser .modal-body').html(html);
            });
        });
    
        $("#adding").click(function(event){
            username = $("#username").val();
            password = $("#password").val();
            passwordR = $("#passwordR").val();
            employed = document.getElementById('employeds');
            employed = employed.options[employed.selectedIndex].value;
            var validateUsername = /^[a-z0-9ü][a-z0-9ü_]{3,14}$/;
            if (validateUsername.test(username)){
                if (password.length < 8){
                    $("#message").html('<div class="alert alert-danger">\n\
                    La contraseña debe tener al menos 8 caracteres</div>');
                }else{
                    var validatePassword = /[A-Z]/;
                    if (validatePassword.test(password))
                    {
                        validatePassword = /[a-z]/;
                        if(validatePassword.test(password)){
                             validatePassword = /[0-9]/;
                             if(validatePassword.test(password)){
                                 validatePassword = /[+-.,!@#$%^&*():;\\/|<>"']/;
                                 if(validatePassword.test(password)){
                                     if(password == passwordR){
                                         $("#message").html('<div class="alert alert-success">\n\
                                            Espere un momento</div>');
                                            encript = Base64.encode(password);
                                            action = 1;
                                            $.get('pages-modules/administration/actions.php',{ user: username, pass: encript, emplo: employed, action: action}, function(html){
                                                $("#message").html(html);
                                                window.setTimeout($("#addUser").modal('hide'), 60000);
                                            });
                                     }else{
                                         $("#message").html('<div class="alert alert-danger">\n\
                                            Las contraseñas no coinciden</div>');
                                     }
                                 }else{
                                     $("#message").html('<div class="alert alert-danger">\n\
                                     La contraseña debe tener al menos un simbolo</div>');
                                 }
                             }else{
                                 $("#message").html('<div class="alert alert-danger">\n\
                                 La contraseña debe tener al menos un número</div>');
                             }
                        }else{
                            $("#message").html('<div class="alert alert-danger">\n\
                            La contraseña debe tener por lo menos una minuscula</div>');
                        }
                    }else{
                        $("#message").html('<div class="alert alert-danger">\n\
                        La contraseña debe tener por lo menos una mayuscula</div>');
                    }
            }
            }else{
                $("#message").html('<div class="alert alert-danger">'
                   + username +' invalido, usuario de 4 a 15 caracteres</div>');
            }
        });
        
        function encrypt(password, keys){
            result = '';
            for(i=0; i<password.length; i++){
                password[i]+=password.length;
                alert(password[i]);
            }
        }
    });
</script>

<?php
function encrypta($string, $key) {
   $result = '';
   for($i=0; $i<strlen($string); $i++) {
      $char = substr($string, $i, 1);
      $keychar = substr($key, ($i % strlen($key))-1, 1);
      $char = chr(ord($char)+ord($keychar));
      $result.=$char;
   }
   return base64_encode($result);
}
?>


