var img;
var activado;
var p=0;
var c;

//CONSTANTES
var val1 =  (360 * 35) / 100;
var val2 =  (360 * 25) / 100;
var val3 =  (360 * 25) / 100;
var val4 =  (360 * 15) / 100;

function Init(){
    img = [];
    p=0;
    for (var i=0;i<4;i++){
        img[i]=sketch.hacerImagen("imagenes/modulo2/pan2/grafico/porc"+(i+1)+".png",boton.getPos(),boton.getTam());
    }
    c = sketch.crearVector(boton.getPos().getX()+(boton.getTam().getX()/2),boton.getPos().getY()+(boton.getTam().getY()/2))
    activado=false;
}

function Update(){
    if(activado){
        //Consigo el angulo del punto de la mano
        if(c !=null){
        var dx = sketch.pos1.getX()-c.getX();
        var dy = sketch.pos1.getY()-c.getY();
        var theta = Math.atan2(dy,dx);
        theta *= 180 / Math.PI;
        if(theta<0){theta = 360+theta;}

        //Checkearlo con todo
        if(theta<val1){
            p=0;
        }else if (theta<val1+val2){
            p=1;
        }else if (theta<val1+val2+val3){
            p=2;
        }else if (theta<val1+val2+val3+val4){
            p=3;
        }
        }
        
    }
    activado = false;
}

function Dibujar(){
    if(activado && img!=null){
        if (img[p]!=null){
            img[p].render()
        }
    }
}

function Hover(){activado=true;}

function Click(a){}