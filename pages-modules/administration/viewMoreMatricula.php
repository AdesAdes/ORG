<div class="col-md-12">
	<div class="form-group col-md-4" >
		

	  	<label for="usr">Clase:</label>
	  	<select multiple="" class="form-control" id="sel2">
	        <?php
		    
		    include '../../conection/conection.php';
		    $stmt = $db->prepare("CALL  SP_SELECCIONAR_ASIGNATURAS()");
		    $stmt->execute();
		    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
		    foreach ($rows as $row){
		    	$CODIGO_ASIGNATURA = $row['CODIGO_CLASE'];
		        $NOMBRE_CLASE   = $row['NOMBRE_CLASE'];
		        $REQUISITO   = $row['REQUISITO'];
		        $UV   = $row['UV'];
		        
		        
        	?>
	        <option value= <?php echo $CODIGO_ASIGNATURA; ?> ><?php echo $NOMBRE_CLASE; ?></option>
	       	<?php } ?>
	   	</select>
	</div>
	<div class="form-group col-md-4" >
	  	<label for="usr">Seccion:</label>
	  	<select multiple="" class="form-control" id="sel2">
	  		
			
	        <option></option>
	        
	   	</select>
	</div>
	<div class="form-group col-md-4" >
		<label for="usr">Maestro:</label>
		<select multiple="" class="form-control" id="sel2">
		    <option>1</option>
		    <option>2</option>
		    <option>3</option>
		    <option>4</option>
		    <option>5</option>
		</select>
	</div>
</div>
