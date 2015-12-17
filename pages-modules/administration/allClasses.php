<?php
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL SP_SELECCIONAR_EDIFICIOS()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo
<<<HTML
    <div style="overflow: scroll;">
        <div class="panel-heading">
            <h3 class="panel-title">Edificios</h3>
        </div>
        <div class="panel-body">
            <input type="text" class="form-control" id="dev-table-filter"
                data-action="filter" data-filters="#dev-table"
                    placeholder="Filtrar edificios" />
        </div>
        <table class="table table-hover" id="dev-table">
            <thead>
                <tr>
                    <th><STRONG>Clase</STRONG> </th>
                    <th><STRONG>UV</STRONG> </th>
                    
                </tr>
            </thead>
            <tbody>
HTML;
            foreach ($rows as $row){
                $idEdificio= $row['resource_id'];
                $nombreRecurso=$row['name'];    

                echo
<<<HTML
                    <tr role="button" data-id = $idEdificio role="button"
                        class="btn_view">
HTML;
                        
                        echo
<<<HTML
                        <td><a type='submit' href='RecursoEdificio.php?Recurso=".$idEdificio."'>".$nombreRecurso."</a><br></td>
                        
                        <td></td>
                        <td></td>
                    </tr>
HTML;
                }
echo
<<<HTML
            </tbody>
        </table>
    </div>
HTML;
?>

<script>
    (function(){
    'use strict';
	var $ = jQuery;
	$.fn.extend({
		filterTable: function(){
			return this.each(function(){
				$(this).on('keyup', function(e){
					$('.filterTable_no_results').remove();
					var $this = $(this), 
                        search = $this.val().toLowerCase(), 
                        target = $this.attr('data-filters'), 
                        $target = $(target), 
                        $rows = $target.find('tbody tr');
                        
					if(search == '') {
						$rows.show(); 
					} else {
						$rows.each(function(){
							var $this = $(this);
							$this.text().toLowerCase().indexOf(search) === -1 ? $this.hide() : $this.show();
						})
						if($target.find('tbody tr:visible').size() === 0) {
							var col_count = $target.find('tr').first().find('td').size();
							var no_results = $('<tr class="filterTable_no_results"><td colspan="'+col_count+'">No hay edificios</td></tr>')
							$target.find('tbody').append(no_results);
						}
					}
				});
			});
		}
	});
	$('[data-action="filter"]').filterTable();
})(jQuery);

$(function(){
    // attach table filter plugin to inputs
	$('[data-action="filter"]').filterTable();
	
	$('.container').on('click', '.panel-heading span.filter', function(e){
		var $this = $(this), 
			$panel = $this.parents('.panel');
		
		$panel.find('.panel-body').slideToggle();
		if($this.css('display') != 'none') {
			$panel.find('.panel-body input').focus();
		}
	});
	$('[data-toggle="tooltip"]').tooltip();
})
</script>