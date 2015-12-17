<!--Este es el modal -->
<div class="modal fade" id="viewMore" tabindex="-1" role="dialog"
    aria-labelledby="Modallabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Cerrar</span>
                </button>
                <h4 class="modal-title">Información de Perfil de Usuario</h4>
            </div>
            <div class="modal-body">
                
            </div>
            <div class="modal-footer right">
                <button type="button" class="btn btn-danger"
                    data-dismiss="modal">
                            Cerrar
                </button>
            </div>
        </div>
    </div>
</div>
<!--pie de modal-->
<div class="modal fade" id="addEmployed" tabindex="-1" role="dialog"
    aria-labelledby="Modallabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Cerrar</span>
                </button>
                <h4 class="modal-title">Agregar Perfil De Usuario</h4>
            </div>
            <div class="modal-body">
                
            </div>
            <div class="modal-footer right">
                <button type="button" class="btn_update btn btn-success"
                        >
                            Agregar
                </button>
                <button type="button" class="btn btn-danger"
                    data-dismiss="modal">
                            Cerrar
                </button>
            </div>
        </div>
    </div>
</div>


<!-- mira al personal o el perfil de usuario-->
<script>
    $(document).ready(function() {
        $(".btn_view").click(function(event){
            event.preventDefault();
            id = $(this).data('id');
            $.get('pages-modules/humanResources/viewMore.php?codE=' + id, function(html){
                $('#viewMore .modal-body').html(html);
            });
        });
        
        
        $(".btn_addEmployed").click(function(event){
            event.preventDefault();
            id = $(this).data('id');
            $.get('pages-modules/humanResources/addEmployeds.php', function(html){
                $('#addEmployed .modal-body').html(html);
            });
        });
        $(".btn_update").click(function(event){
            idCard = $("#idcard").val();
            fname  = $("#fname").val();
            sname  = $("#sname").val();
            lfname  = $("#lfname").val();
            lsname  = $("#lsname").val();
            phoneNumber = $("#phoneNumber").val();
            email = $("email").val();
            birthDay = $("#birthDay").val();
            direction = $("#direction").val();
            charge = document.getElementById('charges');
            charge = charge.options[charge.selectedIndex].value;
            if (idCard.length <= 0 && !/^([0-9])*$/.test(idCard)){
                $("#messageHR").html('<div class="alert alert-danger">\n\
                La identidad ingresada no es valida</div>');
            }else{
                if (!/^([a-zA-Z])*$/.test(fname)){
                    $("#messageHR").html('<div class="alert alert-danger">\n\
                    Su primer nombre no es valido</div>');
                }else{
                    if (!/^([a-zA-Z])*$/.test(sname)){
                        $("#messageHR").html('<div class="alert alert-danger">\n\
                        Su segundo nombre no es valido</div>');
                    }else{
                        if (!/^([a-zA-Z])*$/.test(lfname)){
                            $("#messageHR").html('<div class="alert alert-danger">\n\
                            Su primer apellidoe no es valido</div>');
                        }else{
                            if (!/^([a-zA-Z])*$/.test(lsname)){
                                $("#messageHR").html('<div class="alert alert-danger">\n\
                                Su segundo apellidoe no es valido</div>');
                            }else{
                                if(!/^([0-9]+){8}$/.test(phoneNumber)){
                                    $("#messageHR").html('<div class="alert alert-danger">\n\
                                    Teléfono invalido</div>');
                                }else{
                                    $.get('pages-modules/humanResources/insert.php', function(html){
                                            $("#messageHR").html(html);
                                            window.setTimeout($("#addEmployed").modal('hide'), 60000);
                                    });
                                    
                                }
                            }
                        }
                    }
                    
                }
            }
                
                
        });
    });
</script>