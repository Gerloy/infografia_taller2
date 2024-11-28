/*
{
	"path": "imagenes/juego3/linea.png",
        "posx": 0,
        "posy": 231,
        "tamx": 1023,
        "tamy": 10
},
*/

var barrita;
var activado = false;
var hover = false;
var img;

function Init(){
	barrita=sketch.hacerImagen("imagenes/juego3/linea.png",sketch.escalar(sketch.crearVector(0,231)),sketch.escalar(sketch.crearVector(1023,10)));
}

function Update(){hover = false;}

function Dibujar(){
    if(barrita != null){
	    barrita.render();
    }
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
