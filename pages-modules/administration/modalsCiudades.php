
<div class="modal fade" id="viewMoreCiudades" tabindex="-1" role="dialog"
    aria-labelledby="Modallabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Cerrar</span>
                </button>
                <h4 class="modal-title">Información de la Ciudad</h4>
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


<div class="modal fade" id="addCiudades" tabindex="-1" role="dialog"
    aria-labelledby="Modallabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Cerrar</span>
                </button>
                <h4 class="modal-title">Agregar Ciudad</h4>
            </div>
            <div class="modal-body">
                
            </div>
            <div class="modal-footer right">
                <button type="button" class="btn btn-success" id="addingCiudades">
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
            $.get('pages-modules/administration/viewMoreCiudades.php?CODIGO_LOCALIZACION=' + id, function(html){
                $('#viewMoreCiudades .modal-body').html(html);
            });
        });
        
        $(".btn_add").click(function(event){
            event.preventDefault();
            id = $(this).data('id');
            $.get('pages-modules/administration/addCiudades.php', function(html){
                $('#addCiudades .modal-body').html(html);
            });
        });

        $("#addingCiudades").click(function(event){
            ciudad = $("#ciudad").val();
            abreviatura = $("#abreviatura").val();
            codigoPostal = $("#codigoPostal").val();
            pais = document.getElementById('pais');
            pais = pais.options[pais.selectedIndex].value;
           $("#message").html('<div class="alert alert-success">\n\
            Espere un momento</div>');
           action = 1;
           $.get('pages-modules/administration/actionsCiudades.php',{ ciudad: ciudad, abreviatura: abreviatura,codigoPostal: codigoPostal,pais: pais, action: action}, function(html){
                $("#message").html(html);
                window.setTimeout($("#addCiudades").modal('hide'), 60000);
            });
        });
        
        
    });
</script>
    



