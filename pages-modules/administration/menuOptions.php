
<!DOCTYPE html>
<!--
Ingeniería del software
-->
<div class="span3 col-sm-3">
<div class="btn-group-vertical span3 col-sm-12" role="group" aria-label="...">
    <div  class="list-group">
        <a id ="usersAdmin" role="button" class="list-group-item">
            <i class="fa fa-cog fa-fw" ></i>&nbsp;
            Administrar usuarios
        </a>
        
        <a id ="MatricularEstudiantes" role="button" class="list-group-item">
            <i class = "fa fa-graduation-cap" ></i>&nbsp;
            Matricular Estudiantes
        </a>
        
         <a role="button" class="list-group-item" aria-hidden="true" onclick="mostrar_Ocultar_Mant()" id="mostrar">
                    <i class = "fa fa-bars" ></i>&nbsp;
                    Mantenimiento
        </a>
        <div id="MenuMantenimiento" style="display:none">
                <a id ="CrearSecciones" role="button" class="list-group-item">
                    <i class = "fa fa-bar-chart" ></i>&nbsp;
                        Crear una seccion
                </a>

                <a id ="CrearAsignaturas" role="button" class="list-group-item">
                    <i class = "fa fa-pencil-square-o" ></i>&nbsp;
                    Asignaturas
                </a>
                <a id ="CrearSalones" role="button" class="list-group-item">
                    <i class = "fa fa-book" ></i>&nbsp;
                    Aulas
                </a> 
               <a id ="CrearEdificios" role="button" class="list-group-item">
                    <i class = "fa fa-building" ></i>&nbsp;
                    Edificios
                </a>
                <a id ="CrearCentrosRegionales" role="button" class="list-group-item">
                    <i class = "fa fa-university" ></i>&nbsp;
                    Centros Regionales
                </a>
               
                <a id ="CrearLocalizaciones" role="button" class="list-group-item">
                    <i class = "fa fa-globe" ></i>&nbsp;
                    Localizaciones
                </a>
                  
                <a id ="CrearPaises" role="button" class="list-group-item">
                    <i class = "fa fa-globe" ></i>&nbsp;
                    Paises
                </a>
                  
                <a id ="CrearRegiones" role="button" class="list-group-item">
                    <i class = "fa fa-globe" ></i>&nbsp;
                    Regiones
                </a>
                      
        </div>
                
        
        
        <!--<div class="btn-group-vertical" role="group" aria-label="...">
  
            <a id ="CrearLocalizaciones" role="button" class="list-group-item">
            <i class = "fa fa-globe" ></i>&nbsp;
            Localizaciones
            </a>
            <a id ="CrearPaises" role="button" class="list-group-item">
                <i class = "fa fa-globe" ></i>&nbsp;
                Paises
            </a>
            <a id ="CrearRegiones" role="button" class="list-group-item">
                <i class = "fa fa-globe" ></i>&nbsp;
                Regiones
            </a>
        </div>-->

        
    
        
        </div>
    </div>
        <!---<a id ="binnacle" role="button" class="list-group-item">
            <i class = "fa fa-signal fa-fw" ></i>&nbsp;
            Bitacora
        </a>--->
    </div>
</div>
<!-- Esto hace la función de cada una de las opciones del menu de opciones
sin embargo, es mejor hacer referencia desde la carpeta js a el head "REVISAR" -->
<script type="text/javascript">
        
        function mostrar_Ocultar_Mant()
        {
            if(document.getElementById('MenuMantenimiento').style.display=='none')
            {
                document.getElementById('MenuMantenimiento').style.display = 'block';
            }
            else
            {
                document.getElementById('MenuMantenimiento').style.display = 'none';
            }
        }
    </script>
    
<script src="pages-modules/administration/administration.js" type="text/javascript"></script>
<script src="pages-modules/administration/newjavascript.js" type="text/javascript"></script>