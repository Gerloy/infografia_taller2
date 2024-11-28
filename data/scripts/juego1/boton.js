var hover = false;
var select = false;

function Init(){}

function Update(){hover = false;}

function Dibujar(){
    if (hover || select){
        img.render();
    }
}

function Hover(){hover = true;}

function Click(){
    select = true;
    var botones = modulo.getPantallaActual().getBotones();
    for(var i=6;i<botones.length;i++){
        if(!botones[i].metodos.invokeFunction("getActivado")){
            botones[i].metodos.invokeFunction("setPalabra",img_sel);
            break;
        }
    }
}

/*setea la variable num*/
function setid(_num){
    id = parseInt(_num);
}

function setimg(_selec){
    img = sketch.hacerImagen(_selec,boton.getPos(),boton.getTam());
}

function setimg_sel(_img){
    img_sel = _img = sketch.hacerImagen(_img,boton.getPos(),boton.getTam());
}