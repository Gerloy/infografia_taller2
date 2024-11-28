function Init(){
}

function Update(){
    updateTimer();
}

function Click(a){}

function Dibujar(){
    //Mostrar texto del cronometro
    sketch.texto((segs +":"+parseInt((((actual_time/1000)-segs).toFixed(2))*100)), sketch.crearVector(653,68));
}

//Variables
function settime(relleno){time = 0;}
function setactual_time(t){actual_time = parseInt(t);}
function setsegs(relleno){segs = 0;}

//Cositas
function updateTimer(){
    actual_time -= sketch.time.DeltaTime();
    segs = Math.floor(actual_time/1000);
    if (actual_time<=0){
        guardarImagenes();
        sketch.setModPath(modulo.getSig());
        sketch.mandarACargar();
    }
}

function guardarImagenes(){
    var imgs = pantalla.getBotones()[0].metodos.invokeFunction("getImgs_selec");
    var dic = [];
    for (var i=0; i<imgs.length; i++){
        dic.push({
            "path": imgs[i].getPath(),
            "id": i
        });
    }
    var imagenes = {"imagenes": dic};
    var json = JSON.stringify(imagenes);
    sketch.escribirArchivo('data/save/imagenes.json',json);

}