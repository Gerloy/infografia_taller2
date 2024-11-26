var time = 0;
var actual_time;
var segs = 0;

function Init(){actual_time = 10000;}

function Update(){
    actual_time -= sketch.time.DeltaTime();
    if (actual_time<=0){
        modulo.setPantalla(modulo.getPantalla()+1);
    }
}

function Click(){}
function Hvoer(){}

function Dibujar(){}

function settime(relleno){time = 0;}
function setactual_time(t){}//actual_time = t;}
function setsegs(relleno){segs = 0;}