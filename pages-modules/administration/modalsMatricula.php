
<div class="modal fade" id="viewMoreMatricula" tabindex="-1" role="dialog"
    aria-labelledby="Modallabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Cerrar</span>
                </button>
                <h4 class="modal-title">Matricula</h4>
            </div>
            <div class="modal-body">
                
            </div>
            <div class="modal-footer right">
            
                <button type="button" class="btn btn-info btn-lg" id = "btnMatricular"
                    data-dismiss="modal">
                    <i class="fa fa-times"></i>
                            Matricular
                </button>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="addSalones" tabindex="-1" role="dialog"
    aria-labelledby="Modallabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Cerrar</span>
                </button>
                <h4 class="modal-title">Agregar Salon</h4>
            </div>
            <div class="modal-body">
                
            </div>
            <div class="modal-footer right">
                <button type="button" class="btn btn-success" id="addingSalon">
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
            $.get('pages-modules/administration/viewMoreMatricula.php', function(html){
                $('#viewMoreMatricula .modal-body').html(html);
            });
        });
        
        $(".btn_add").click(function(event){
            event.preventDefault();
            id = $(this).data('id');
            $.get('pages-modules/administration/addSalon.php', function(html){
                $('#addSalones .modal-body').html(html);
            });
        });

        $("#addingSalon").click(function(event){
            nombredeaula = $("#nombredesalon").val();
            numerodepiso = $("#numerodepiso").val();
            edificio = document.getElementById('edificio');
            edificio = edificio.options[edificio.selectedIndex].value;
           $("#message").html('<div class="alert alert-success">\n\
            Espere un momento</div>');
           action = 1;
           $.get('pages-modules/administration/actions_aulas.php',{ aula: nombredeaula, pisos: numerodepiso, edificio: edificio, action: action}, function(html){
                $("#message").html(html);
                window.setTimeout($("#addSalones").modal('hide'), 60000);
            });
        });
        
        
    });
</script>



