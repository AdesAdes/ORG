
<div class="modal fade" id="viewMoreCentroRegional" tabindex="-1" role="dialog"
    aria-labelledby="Modallabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Cerrar</span>
                </button>
                <h4 class="modal-title">Información del Centro Regional</h4>
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


<div class="modal fade" id="addCentrosRegionales" tabindex="-1" role="dialog"
    aria-labelledby="Modallabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Cerrar</span>
                </button>
                <h4 class="modal-title">Agregar Centro Regional</h4>
            </div>
            <div class="modal-body">
                
            </div>
            <div class="modal-footer right">
                <button type="button" class="btn btn-success" id="addingCentroRegional">
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
            $.get('pages-modules/administration/viewMoreCentrosRegionales.php?CODIGO_CENTRO_REGIONAL=' + id, function(html){
                $('#viewMoreCentroRegional .modal-body').html(html);
            });
        });
        
        $(".btn_add").click(function(event){
            event.preventDefault();
            id = $(this).data('id');
            $.get('pages-modules/administration/addCentrosRegionales.php', function(html){
                $('#addCentrosRegionales .modal-body').html(html);
            });
        });

        $("#addingCentroRegional").click(function(event){
            centroRegional = $("#centroRegional").val();
            ciudad = document.getElementById('ciudad');
            ciudad = ciudad.options[ciudad.selectedIndex].value;
           $("#message").html('<div class="alert alert-success">\n\
            Espere un momento</div>');
           action = 1;
           $.get('pages-modules/administration/actions_centrosRegionales.php',{ centroRegional: centroRegional, ciudad: ciudad, action: action}, function(html){
                $("#message").html(html);
                window.setTimeout($("#addCentrosRegionales").modal('hide'), 60000);
            });
        });
        
        
    });
</script>




