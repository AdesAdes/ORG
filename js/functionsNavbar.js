$(document).ready(function() {
    //este evento vuelve al inicio del sistema
    $("#home").click(function(event) {
        event.preventDefault();
        $("#principalContainer" ).load("pages-modules/home.php?content=home");
    });
    
    //envia a la pagina principal de administracion
    $("#admin").click(function(event) {
        event.preventDefault();
        $("#principalContainer" ).load("pages-modules/administration/principal.php" );
    });
    
    //envia a la pagina principal de el Modulo de maestros 
     $("#Maestro").click(function(event) {
        event.preventDefault();
        $("#principalContainer" ).load("pages-modules/Maestros/principal.php" );
    });
    
     //envia a la pagina principal de el modulo de estudiantes 
     $("#Estudiante").click(function(event) {
        event.preventDefault();
        $("#principalContainer" ).load("pages-modules/Estudiante/principal.php");
    });
    
    //evento para el modulo de recursos  humanos
   $(document).ready(function() {
    $("#resources").click(function(event) {
        event.preventDefault();
        $("#principalContainer" ).load("pages-modules/humanResources/principal.php" );
    });
});
}); 

