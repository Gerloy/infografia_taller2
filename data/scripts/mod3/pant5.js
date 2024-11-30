var img_actual = 0;
var imgs;

imgs = [];
for (var i=0;i<4;i++){
    var img = sketch.hacerImagen("imagenes/modulo2/pan5/"+i+".png",sketch.crearVector(0,0),sketch.escalar(sketch.crearVector(1280,720)));
    imgs.push(img);
}

function Init(){}
function Update(){}

function Dibujar(){
    imgs[img_actual].render();
}

function Hover(){}
function Click(a){}

function cambiarImg(id){img_actual = id;}