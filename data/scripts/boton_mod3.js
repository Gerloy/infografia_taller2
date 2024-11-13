function Update(){
}

function Dibujar(){
    if (select){
        img_selec.render();
    }else{
        img.render();
    }
    select = false;
}

function Hover(){
    select = true;
}

function Click(){}

/*setea la variable num*/
function setid(_num){
    id = parseInt(_num);
}

function setimg(_selec){
    img = sketch.hacerImagen(_selec,boton.getPos(),boton.getTam());
}

function setimg_selec(_selec){
    img_selec = sketch.hacerImagen(_selec,boton.getPos(),boton.getTam());
}

function setselect(_select){
    select = false;
    boton.setColFill(0,128,128,0);
    boton.setColStroke(0,128,128,0);
}