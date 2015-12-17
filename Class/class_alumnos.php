<?php
class Consultar_Salones{
	private $consulta;
	private $fetch;
	
	function __construct($codigo){
		$this->consulta = mysql_query("SELECT * FROM salones WHERE id='$codigo'");
		$this->fetch = mysql_fetch_array($this->consulta);
	}
	
	function consultar($campo){
		return $this->fetch[$campo];
	}
}
class Consultar_Alumnos{
	
	private $consulta;
	private $fetch;
	
	function __construct($codigo){
		$this->consulta = mysql_query("SELECT * FROM alumnos WHERE id=$codigo or nit='$codigo' or nombre='$codigo' or apellido='$codigo'");
		$this->fetch = mysql_fetch_array($this->consulta);
	}
	
	function consultar($campo){
		return $this->fetch[$campo];
	}
}

class Proceso_Salones{
	var $nombre;	var $curso;	var $id;
	
	function __construct($nombre, $curso, $id){
		$this->nombre = $nombre; 		$this->curso = $curso;		$this->id = $id;
	}
	
	function crear(){
		$nombre=$this->nombre;	$curso=$this->curso;
		mysql_query("INSERT INTO salones (nombre, curso, estado) VALUES ('$nombre','$curso','s')");
	}
	
	function actualizar(){
		$nombre=$this->nombre;	$curso=$this->curso;	$id=$this->id;
		mysql_query("Update salones Set	nombre='$nombre', curso='$curso' Where id=$id");
	}
	
	
}

class Proceso_Alumnos{
	var $nombre;		var $telefono;		var $curso;		
	var $apellido;		var $fechan;		var $id;
	var $correo;			var $telefono_movil;			var $estado;
		
	function __construct($nombre, $apellido, $correo, $telefono, $fechan, $telefono_movil, $curso, $estado, $id){
		$this->nombre = $nombre;			$this->curso = $curso;		
		$this->apellido = $apellido;		$this->telefono_movil = $telefono_movil;
		$this->correo = $correo;					$this->estado = $estado;		
		$this->telefono = $telefono;		$this->id = $id;
		$this->fechan = $fechan;			
							
	}
		
	function crear(){
		$nombre=$this->nombre;			$curso=$this->curso;		
		$apellido=$this->apellido;		$estado=$this->estado;
		$correo=$this->correo;				$id=$this->id;
		$telefono=$this->telefono;		$telefono_movil=$this->telefono_movil;
		$fechan=$this->fechan;			
			
		mysql_query("INSERT INTO alumnos (nombre, apellido,telefono, fechan, telefono_movil, curso, estado, correo) VALUES ('$nombre','$apellido','$telefono','$fechan','$telefono_movil','$curso','$estado','$correo')");
	}
	
	function actualizar(){
		$nombre=$this->nombre;			$curso=$this->curso;
		$apellido=$this->apellido;		$estado=$this->estado;
		$correo=$this->correo;				$id=$this->id;
		$telefono=$this->telefono;		$telefono_movil=$this->telefono_movil;
		$fechan=$this->fechan;			
		
		mysql_query("Update alumnos Set	nombre='$nombre',
										apellido='$apellido',
										correo='$correo',
										telefono='$telefono',
										fechan='$fechan',
										telefono_movil='$telefono_movil',
										curso='$curso'
								Where id=$id");
	}	
}
?>