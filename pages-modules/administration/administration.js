/* 
   
*/
$(document).ready(function() {
    $("#usersAdmin").click(function(event) {
        event.preventDefault();
        $("#contentAdministration").load("pages-modules/administration/usersAdministration.php" );
    });

/* 
  Permite ver que usuarios estan conectados y desconectados 

*/

    $("#usersLogs").click(function(event) {
        event.preventDefault();
        $("#contentAdministration").load("pages-modules/administration/logs.php" );
    });
/* 
Registro de de entradas y salidas de los usuarios

*/
    $("#binnacle").click(function(event) {
        event.preventDefault();
        $("#contentAdministration").load("pages-modules/administration/binnacle.php" );
    });
    
/*Registrar Aulas en la base de datos */
$("#CrearSalones").click(function(event) {
        event.preventDefault();
        $("#contentAdministration").load("pages-modules/administration/CreateSalon.php" );
    });

/*Registrar edificios en la base de datos */
$("#CrearEdificios").click(function(event) {
        event.preventDefault();
        $("#contentAdministration").load("pages-modules/administration/CrearEdificios.php" );
    });
    
/*Registrar Centros Regionales en la base de datos */
$("#CrearCentrosRegionales").click(function(event) {
        event.preventDefault();
        $("#contentAdministration").load("pages-modules/administration/CrearCentrosRegionales.php" );
    });

$("#CrearAsignaturas").click(function(event) {
        event.preventDefault();
        $("#contentAdministration").load("pages-modules/administration/CrearAsignaturas.php" );
    });

$("#CrearSecciones").click(function(event) {
        event.preventDefault();
        $("#contentAdministration").load("pages-modules/administration/CrearSecciones.php" );
    });

$("#MatricularEstudiantes").click(function(event) {
        event.preventDefault();
        $("#contentAdministration").load("pages-modules/administration/CrearMatricula.php" );
    });
$("#CrearRegiones").click(function(event) {
        event.preventDefault();
        $("#contentAdministration").load("pages-modules/administration/CrearRegiones.php" );
    });

$("#CrearPaises").click(function(event) {
        event.preventDefault();
        $("#contentAdministration").load("pages-modules/administration/CrearPaises.php" );
    });
$("#CrearLocalizaciones").click(function(event) {
        event.preventDefault();
        $("#contentAdministration").load("pages-modules/administration/CrearLocalizaciones.php" );
    });
});