
<div class="modal fade" id="viewMoreSeccion" tabindex="-1" role="dialog"
    aria-labelledby="Modallabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Cerrar</span>
                </button>
                <h4 class="modal-title">Información de la Seccion</h4>
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


<div class="modal fade" id="addSecciones" tabindex="-1" role="dialog"
    aria-labelledby="Modallabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Cerrar</span>
                </button>
                <h4 class="modal-title">Agregar Seccion</h4>
            </div>
            <div class="modal-body">
                
            </div>
            <div class="modal-footer right">
                <button type="button" class="btn btn-success" id="addingSeccion">
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
            $.get('pages-modules/administration/viewMoreSecciones.php?CODIGO_SECCION=' + id, function(html){
                $('#viewMoreSeccion .modal-body').html(html);
            });
        });
        
        $(".btn_add").click(function(event){
            event.preventDefault();
            id = $(this).data('id');
            $.get('pages-modules/administration/addSecciones.php', function(html){
                $('#addSecciones .modal-body').html(html);
            });
        });

        $("#addingSeccion").click(function(event){

            
            dias = document.getElementById('dias');
            dias = dias.options[dias.selectedIndex].text;

            horario = document.getElementById('horario');
            horario = horario.options[horario.selectedIndex].value;
            
            edificio = document.getElementById('edificio');
            edificio = edificio.options[edificio.selectedIndex].value;
            
            periodos = document.getElementById('periodos');
            periodos = periodos.options[periodos.selectedIndex].value;
            
            maestros = document.getElementById('maestros');
            maestros = maestros.options[maestros.selectedIndex].value;

            asignatura = document.getElementById('asignatura');
            asignatura = asignatura.options[asignatura.selectedIndex].value;

            aula = document.getElementById('aula');
            aula = aula.options[aula.selectedIndex].value;

           $("#message").html('<div class="alert alert-success">\n\
            Espere un momento</div>');
           action = 1;
           $.get('pages-modules/administration/actionsSecciones.php',{ dias: dias, horario: horario, edificio: edificio, periodos: periodos, maestros: maestros, asignatura: asignatura, aula: aula , action: action}, function(html){
                $("#message").html(html);
                window.setTimeout($("#addSecciones").modal('hide'), 60000);
            });
        });
        
        
    });
</script>




