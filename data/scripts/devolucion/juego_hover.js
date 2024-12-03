var hover = false;

function Init(){
    var tam = sketch.escalar(sketch.crearVector(465,234)); 
    var pos = sketch.escalar(sketch.crearVector(443,234*id))
    img.setPos(pos);
    img.setTam(tam);
}

function Update(){hover = false;}

function Dibujar(){
    if(hover){
        img.render();
    }
}

function Hover(){hover = true;}
function Click(a){}

function setimg(_selec){
    img = sketch.hacerImagen(_selec,boton.getPos(),boton.getTam());
}

function setid(_id){
    id = parseInt(_id);
}