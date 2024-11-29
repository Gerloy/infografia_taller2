/*
,

{
    "path":"imagenes/intro/pant2/8.png"
},
{
    "path":"imagenes/intro/pant2/9.png"
},
{
    "path":"imagenes/intro/pant2/10.png"
},
{
    "path":"imagenes/intro/pant2/11.png"
},
{
    "path":"imagenes/intro/pant2/12.png"
},
{
    "path":"imagenes/intro/pant2/13.png"
},
{
    "path":"imagenes/intro/pant2/14.png"
},
{
    "path":"imagenes/intro/pant2/15.png"
},
{
    "path":"imagenes/intro/pant2/16.png"
},
{
    "path":"imagenes/intro/pant2/17.png"
},
{
    "path":"imagenes/intro/pant2/18.png"
},
{
    "path":"imagenes/intro/pant2/19.png"
},
{
    "path":"imagenes/intro/pant2/20.png"
},
{
    "path":"imagenes/intro/pant2/21.png"
},
{
    "path":"imagenes/intro/pant2/22.png"
},
{
    "path":"imagenes/intro/pant2/23.png"
},
{
    "path":"imagenes/intro/pant2/24.png"
},
{
    "path":"imagenes/intro/pant2/25.png"
},
{
    "path":"imagenes/intro/pant2/26.png"
},
{
    "path":"imagenes/intro/pant2/27.png"
},
{
    "path":"imagenes/intro/pant2/28.png"
},
{
    "path":"imagenes/intro/pant2/29.png"
}

*/

var time = 0;
var t_active = 3000;
var active = false;
var cooldown = 20000;
var mano;
var texto;

function Init(){
    var f = [];
    for (var i=0;i<3;i++){
        f[i] = "imagenes/tuto/"+i+".png";
    }
    mano = sketch.crearAnimacion(f,sketch.escalar(sketch.crearVector(380,39)),sketch.escalar(sketch.crearVector(531,531)),333,true);
    texto = sketch.hacerImagen("imagenes/tuto/texto.png",sketch.escalar(sketch.crearVector(389,554)),sketch.escalar(sketch.crearVector(261,51)));
}

function Dibujar(){
    if(active){
        mano.render();
        texto.render();
    }
}

function Update(){
    time += sketch.time.DeltaTime();
    if(!active){
        if(time>=cooldown){
            active = true;
            time = 0;
        }
    }else{
        mano.update();
        if(time>=t_active){
            active = false;
            time = 0;
        }
    }
}

function Click(e){
    if (modulo.getPantalla() < modulo.cantPantallas()-1) {
        active = false;
        time = 0;
        modulo.setPantalla(modulo.getPantalla() + 1) 
    }else{
        sketch.setModPath(modulo.getSig());
        sketch.mandarACargar();
    }
}