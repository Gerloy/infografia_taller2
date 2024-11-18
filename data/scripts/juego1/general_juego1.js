function Update(){
    actual_time -= sketch.time.DeltaTime();
    segs = Math.floor(actual_time/1000);
    if (actual_time<=0){
        sketch.setModPath(modulo.getSig());
        sketch.mandarACargar();
    }
}

function Click(){}

function Dibujar(){
    
    sketch.texto((segs +":"+(((actual_time/1000)-segs).toFixed(2))*100), sketch.crearVector(653,68));
}

function settime(relleno){time = 0;}
function setactual_time(t){actual_time = t;}
function setsegs(relleno){segs = 0;}