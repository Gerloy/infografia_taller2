var time = 0;
var actual_time;
var segs = 0;

var cuadro;
var ani;

function Init(){
    actual_time = 10000;
    cuadro = sketch.hacerImagen("imagenes/juego"+id+"/tuto/cuadro.png",sketch.escalar(sketch.crearVector(129,25)),sketch.escalar(sketch.crearVector(1048,691)));
    var f=[];
    for(var i=0;i<frames;i++){
        f[i] = "imagenes/juego"+id+"/tuto/"+i+".png";
    }
    if (id == 1){
        ani = sketch.crearAnimacion(f,sketch.escalar(sketch.crearVector(307,97)),sketch.escalar(sketch.crearVector(676,676)),500,true);
    }else{
        ani = sketch.crearAnimacion(f,sketch.escalar(sketch.crearVector(439,268)),sketch.escalar(sketch.crearVector(427,427)),500,true);
    }
}

function Update(){
    actual_time -= sketch.time.DeltaTime();
    if (actual_time<=0){
        modulo.setPantalla(modulo.getPantalla()+1);
    }
    if(ani != null){ani.update();}
}

function Click(){}
function Hvoer(){}

function Dibujar(){
    if(cuadro != null && ani != null){
        cuadro.render();
        ani.render();
    }
}

function settime(relleno){time = 0;}
function setactual_time(t){}//actual_time = t;}
function setsegs(relleno){segs = 0;}
function setid(_id){id=parseInt(_id);}
function setframes(_fr){frames=parseInt(_fr);}