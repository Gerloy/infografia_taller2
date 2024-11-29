var texto;
var pantalla;

function Init(){
    texto = sketch.hacerImagen(img,sketch.escalar(sketch.crearVector(283,211)),sketch.escalar(sketch.crearVector(752,521)));
    pantalla = modulo.getPantallaActual();
}

function Update(){}
function Dibujar(){}

function Hover(){
    pantalla.metodos.invokeFunction("activar",id);
}

function Click(a){}

function setimg(path){
    img = path;
}

function setid(_id){
    id = parseInt(_id);
}

//function getActivado(){return activado;}

function render(){
    if (texto != null){
        texto.render();
    }
}