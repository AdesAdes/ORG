<div class="modal fade" id="changeImage" tabindex="-1" role="dialog"
    aria-labelledby="Modallabel" aria-hidden="true"
    data-keyboard="false" data-backdrop="static">>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button id="botonDetener" type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Cerrar</span>
                </button>
                <h4 class="modal-title">Cambiar imagen</h4>
            </div>
            <div class="modal-body">
                
            </div>
            <div class="modal-footer right">
                <button id='botonFoto' type='button' class="btn btn-success">
                    <i class="fa fa-camera"></i>
                    Capturar imagen
                </button>
                <button id="botonGuardar" type="button" class="btn btn-success">
                    <i class="fa fa-floppy-o"></i>
                    Guardar
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $(".btn_capture").click(function(event){
            event.preventDefault();
            $.get('pages-modules/user/capture.php', function(html){
                $('#changeImage .modal-body').html(html);
            });
        });
    });
        
</script>