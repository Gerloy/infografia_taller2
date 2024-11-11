function Update(){
    actual_time -= sketch.time.DeltaTime();
    segs = Math.floor(actual_time/1000);
    if (actual_time<=0){
        sketch.setModPath("data/modulos/mod2.json");
        sketch.mandarACargar();
    }
}

function Click(){}

function Dibujar(){
    
    sketch.texto((segs +":"+(((actual_time/1000)-segs).toFixed(2))*100), sketch.crearVector(653,68));
    print(segs);
}

function settime(relleno){time = 0;}
function setactual_time(relleno){actual_time = 15000;}
function setsegs(relleno){segs = 0;}