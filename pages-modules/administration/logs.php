<!DOCTYPE html>
<!--
Ingeniería del software
-->

<?php
    include '../../conection/conection.php';

    $stmt = $db->prepare("CALL allRegisters()");
    $stmt->execute(array());
    
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    foreach ($rows as $row){
        $totalAccess         =   $row['totalAccess'];
        $P_Nombre            =   $row['P_Nombre'];
    }
?>

<input type="hidden" name="name" value="<?php echo $P_Nombre;?>">
<input type="hidden" name="access" value="<?php echo $totalAccess;?>">

<div class="page-header">
    <h3>Accesos de usuario</h3>
</div>
<div id="contenedorLog">
<!--    Aqui va lo de los logs-->
</div>

<script type="text/javascript">
$(document).ready(function() {
    $('#contenedorLog').highcharts({
        chart: {
            type: 'pie',
            options3d: {
                enabled: true,
                alpha: 45,
                beta: 0
            }
        },
        title: {
            text: 'Acceso total de usuarios al sistema, 2015'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                depth: 35,
                dataLabels: {
                    enabled: true,
                    format: '{point.name}'
                }
            }
        },
//        series: [{
//            type: 'pie',
//            name: 'Browser share',
//            data: [['Alex Flores',   45.0],
//                ['Edwin Paz',       26.8],
//                {
//                    name: 'Hector Llanos',
//                    y: 12.8,
//                    sliced: true,
//                    selected: true
//                },
//                ['Douglas Guillen',    8.5],
//                ['Irma Pineda',     6.2],
//                ['Melvin Nuñez',   0.7]]
//        }]
    });
});		
</script>