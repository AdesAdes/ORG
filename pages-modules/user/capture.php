
<style type="text/css">
        .contenedor{ width: 200px; float: left;}
        .titulo{ font-size: 12pt; font-weight: bold;}
        #camara, #foto{
            width: 200px;
            min-height: 150px;
            border: 1px solid #008000;
        }
</style>

<div class="contenedor">
    <div class="titulo">Cámara</div>
    <video id="camara" autoplay controls></video>
</div>
<div class="contenedor">
    <div class="titulo">Foto</div>
    <canvas id="foto"></canvas>
</div>
<script>
//Nos aseguramos que estén definidas
//algunas funciones básicas
window.URL = window.URL || window.webkitURL;
navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia || function(){alert('Su navegador no soporta navigator.getUserMedia().');};
 
jQuery(document).ready(function(){
    //Este objeto guardará algunos datos sobre la cámara
    window.datosVideo = {
        'StreamVideo': null,
        'url' : null
    };
    navigator.getUserMedia({'audio':false, 'video':true}, function(streamVideo){
            datosVideo.StreamVideo = streamVideo;
            datosVideo.url = window.URL.createObjectURL(streamVideo);
            jQuery('#camara').attr('src', datosVideo.url);
        }, function(){
            alert('No fue posible obtener acceso a la cámara.');
        });
 
    jQuery('#botonDetener').on('click', function(e){
        if(datosVideo.StreamVideo){
            datosVideo.StreamVideo.stop();
            window.URL.revokeObjectURL(datosVideo.url);
        };
    });
    
    jQuery('#botonGuardar').on('click', function(e){
        var dato = canvas.toDataURL("image/jpg");
        dato = dato.replace("image/jpg", "image/octet-stream");
        document.location.href = dato;
        
    });
    
    jQuery('#botonFoto').on('click', function(e){
    var oCamara, 
        oFoto,
        oContexto,
        w, h;
         
    oCamara = jQuery('#camara');
    oFoto = jQuery('#foto');
    w = oCamara.width();
    h = oCamara.height();
    oFoto.attr({'width': w, 'height': h});
    oContexto = oFoto[0].getContext('2d');
    oContexto.drawImage(oCamara[0], 0, 0, w, h);
 
});
});
</script>