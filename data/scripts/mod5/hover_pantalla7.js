var normal;
var hover;
var esta_hover;
var ani;
var otra;

function Init(){
    esta_hover=false;
    crearAni();
    normal = sketch.hacerImagen("imagenes/modulo4/pan7/boton"+id+"/normal.png",boton.getPos(),sketch.escalar(sketch.crearVector(67,132)));
    hover = sketch.hacerImagen("imagenes/modulo4/pan7/boton"+id+"/hover.png",boton.getPos(),boton.getTam());
}

function Update(){
    if(esta_hover && ani!=null){
        ani.update();
    }
    esta_hover=false;
}

function Dibujar(){
    if(esta_hover){
        hover.render();
        if (ani!=null){
            ani.render();
        }
    }else{
        normal.render();
    }
}

function Hover(){esta_hover=true;}

function Click(a){}

function  setcant(_cant){
    cant = parseInt(_cant);
}
function crearAni(){
    if(id==1){
        var frames=[];
        for (var i=0;i<parseInt(cant);i++){
            frames.push("imagenes/modulo4/pan7/boton"+id+"/ani/"+i+".png");
        }
        ani = sketch.crearAnimacion(frames,sketch.escalar(sketch.crearVector(733,425)),sketch.escalar(sketch.crearVector(611,308)),33,true);
    }else if(id==2){
        var frames=[];
        for (var i=0;i<parseInt(cant);i++){
            frames.push("imagenes/modulo4/pan7/boton"+id+"/ani/"+i+".png");
        }
        ani = sketch.crearAnimacion(frames,sketch.escalar(sketch.crearVector(713,212)),sketch.escalar(sketch.crearVector(123,92)),33,true);
    }else{ani = null;}
}

function setid(_id){
    id = parseInt(_id);
}