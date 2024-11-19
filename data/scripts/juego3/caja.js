function Update(){}

function Dibujar(){
    img.render();
}

function Click(){}

function Hover(){}


function setid(_num){
    id = parseInt(_num);
}

function setactivado(a){
    activado = false;
}

function cambiaractivado(a){
    activado = a;
}

function setimg(_selec){
    img = sketch.hacerImagen(_selec,boton.getPos(),boton.getTam());
}