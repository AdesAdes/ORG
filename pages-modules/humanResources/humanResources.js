/* 
Ingeniería del software
*/
$(document).ready(function() {
    $("#employedAdmin").click(function(event) {
        event.preventDefault();
        $("#contentAdministration").load("pages-modules/humanResources/employedAdministration.php" );
    });
});
