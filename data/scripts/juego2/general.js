var img_selec;
var selecciono;
var cool_selec = 2000;
var t_selec = 0;

function Init(){
    img_select=sketch.hacerImagen("imagenes/juego2/selec.png",sketch.escalar(sketch.crearVector(365,121)),sketch.escalar(sketch.crearVector(567,567)));
}

function Update(){
    updateTimer();
    if(selecciono){
        t_selec+=sketch.time.DeltaTime();
        if(t_selec>=cool_selec){
            selecciono = false;
            pantalla.getBotones()[0].metodos.invokeFunction("cambiarImg");
            t_selec = 0;
        }
    }
}

function Click(a){}

function Dibujar(){
    //Mostrar texto del cronometro
    sketch.texto((segs +":"+parseInt((((actual_time/1000)-segs).toFixed(2))*100)), sketch.crearVector(653,68));
    if(selecciono){
        img_select.render();
        pantalla.getBotones()[0].metodos.invokeFunction("Dibujar");
    }
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

function Selecciono(){selecciono=true;}