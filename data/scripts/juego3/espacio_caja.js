var activado = false;
var hover = false;
var img;

function Init(){}

function Update(){hover = false;}

function Dibujar(){
    //if (activado){
    //    img.renderizar();
    //}
}

function Click(a){}

function Hover(){hover = true;}

function setid(_num){
    id = parseInt(_num);
}

function cambiaractivado(a){
    activado = a;
}

function setimg(_img){
    img = sketch.hacerImagen(_img,boton.getPos(),boton.getTam());
}

function getHover(){return hover}

function getId(){return id;}
function getActivado(){return activado;}