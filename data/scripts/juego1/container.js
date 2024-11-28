var img;
var activado;

function Init(){}
function Update(){}

function Dibujar(){
    if(activado){
        img.render();
    }
}

function Hover(){}
function Click(a){}

function getActivado(){return activado;}

function setPalabra(_img){
    img = _img;
    img.setPos(boton.getPos());
    img.setTam(boton.getTam());
    activado = true;
}