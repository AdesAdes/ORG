
 $(document).ready(function() {
   
    $("#Matricula").click(function(event) {
        event.preventDefault(); 
         
           $("#ContenedorAlumnos").load("pages-modules/Estudiante/registroAlumnos.php?" );
         
           
    });
    $("#Historial").click(function(event) {
        event.preventDefault(); 
         
           $("#ContenedorAlumnos").load("pages-modules/Estudiante/Historial.php?" );
         
           
    });
    $("#CambiodeClave").click(function(event) {
        event.preventDefault(); 
         
           $("#ContenedorAlumnos").load("pages-modules/Estudiante/FormaJP.php?" );
         
           
    });
     
}); 
