<?php
    include '../../conection/conection.php';
    $stmt = $db->prepare("CALL selectAllUsers()");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo
<<<HTML
    <div style="overflow: scroll;">
        <div class="panel-heading">
            <h3 class="panel-title">Usuarios</h3>
        </div>
        <div class="panel-body">
            <input type="text" class="form-control" id="dev-table-filter"
                data-action="filter" data-filters="#dev-table"
                    placeholder="Filtrar usuarios" />
        </div>
        <table class="table table-hover" id="dev-table">
            <tbody>
HTML;
            foreach ($rows as $row){
                $user           = $row['name'];
                $codeE          = $row['codeE'];
                $office         = $row['office'];
                $log            = $row['log'];
                $image = $codeE.".jpg";

                echo
<<<HTML
                    <tr role="button" data-id = $codeE role="button"
                        class="btn_view" data-toggle="modal"
                            data-target="#viewMore">
HTML;
                        if ($log != 1){
                            echo
<<<HTML
                            <td>
                                <img class="img-circle"
                                    src="images/profile/$image" id="profile2"/>
                            </td>
HTML;
                        }else{
                            echo
<<<HTML
                            <td>
                                <img class="img-circle"
                                    src="images/profile/$image" id="profile3"/>
                            </td>
HTML;
                        }
                        echo
<<<HTML
                        <td>
                            $user
                        </td>
                        <td></td>
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
							var no_results = $('<tr class="filterTable_no_results"><td colspan="'+col_count+'">No hay usuarios</td></tr>')
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