function Update(){
}

function Dibujar(){
    if (select){
        img.render();
    }
}

function Hover(){
}

function Click(){
    select = !select;
}

/*setea la variable num*/
function setid(_num){
    id = parseInt(_num);
}

function setimg(_selec){
    img = sketch.hacerImagen(_selec,boton.getPos(),boton.getTam());
}

function setselect(_select){
    select = false;
    boton.setColFill(0,128,128,0);
    boton.setColStroke(0,128,128,0);
}