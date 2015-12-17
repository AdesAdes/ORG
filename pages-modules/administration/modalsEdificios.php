
<div class="modal fade" id="viewMoreEdificio" tabindex="-1" role="dialog"
    aria-labelledby="Modallabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Cerrar</span>
                </button>
                <h4 class="modal-title">Información del Edificio</h4>
            </div>
            <div class="modal-body">
                
            </div>
            <div class="modal-footer right">
                <button type="button" class="btn btn-danger" id = "btnCerrar"
                    data-dismiss="modal">
                    <i class="fa fa-times"></i>
                            Cerrar
                </button>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="addEdificios" tabindex="-1" role="dialog"
    aria-labelledby="Modallabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Cerrar</span>
                </button>
                <h4 class="modal-title">Agregar Edificio</h4>
            </div>
            <div class="modal-body">
                
            </div>
            <div class="modal-footer right">
                <button type="button" class="btn btn-success" id="addingEdificio">
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
            $.get('pages-modules/administration/viewMoreEdificios.php?CODIGO_EDIFICIO=' + id, function(html){
                $('#viewMoreEdificio .modal-body').html(html);
            });
        });
        
        $(".btn_add").click(function(event){
            event.preventDefault();
            id = $(this).data('id');
            $.get('pages-modules/administration/addEdificio.php', function(html){
                $('#addEdificios .modal-body').html(html);
            });
        });

        $("#addingEdificio").click(function(event){
            codigoedificio = $("#codigoedificio").val();
            nombredeedificio = $("#nombredeedificio").val();
            cantidaddepisos = $("#cantidaddepisos").val();
            centros_regionales = document.getElementById('centros_regionales');
            centros_regionales = centros_regionales.options[centros_regionales.selectedIndex].value;
           $("#message").html('<div class="alert alert-success">\n\
            Espere un momento</div>');
           action = 1;
           $.get('pages-modules/administration/actions_edificios.php',{ nombreedificio: nombredeedificio, pisos: cantidaddepisos, centro_regional: centros_regionales, codigoedificio: codigoedificio, action: action}, function(html){
                $("#message").html(html);
                window.setTimeout($("#addEdificios").modal('hide'), 60000);
            });
        });
        
        
    });
</script>




