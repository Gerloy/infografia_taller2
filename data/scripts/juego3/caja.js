//variables para la posicion del puntero que interactue con el boton
var p_pos;
var pos;
var activado = false;
var colocado = false;
var mano;

function Init() {
    p_pos = boton.getPos();
}

function Update() {
    if (!colocado){
        if (activado){
            //ESTO ES NECESARIO PARA QUE ANDE CON KINECT
            //DESCOMENTAR PARA PROBARLO CON EL KINECT
            //if(mano == 1){pos=sketch.pos1;}else{pos=sketch.pos2;}
            pos = sketch.pos1;
            //boton.setPos(sketch.crearVector(boton.getPos().x+(pos.x-p_pos.x),boton.getPos().y+(pos.y-p_pos.y)));
            boton.setPos(pos);
            p_pos = pos;

            //ESTO ES PARA PROBAR CON EL MOUSE
            //COMENTARLO PARA PROBAR CON EL KINECT
            //boton.setPos(sketch.crearVector(boton.getPos().x+(sketch.pos1.x-p_pos.x),boton.getPos().y+(sketch.pos1.y-p_pos.y)));
            //p_pos = sketch.pos1;


            img.setPos(boton.getPos());
        }
    }
}

function Dibujar() {
    img.render();
}

function Click(_pos) {
    if(!colocado){
        if (!activado) {
            //ESTO ES NECESARIO PARA QUE ANDE CON KINECT
            //DESCOMENTAR PARA PROBARLO CON EL KINECT
            //var manos = sketch.getManos();
            //for (i=0;i<manos.length;i++){
            //    if ((manos[i]!=null) && (manos[i].getPos() == _pos)) {
            //        mano = m;
            //    }
            //}
            //p_pos = mano.getPos();

            //var dist_pos1 = Math.sqrt(Math.pow(sketch.pos1.x-_pos.x),Math.pow(sketch.pos1.y-_pos.y));
            //var dist_pos2 = Math.sqrt(Math.pow(sketch.pos2.x-_pos.x),Math.pow(sketch.pos2.y-_pos.y));
            //if(dist_pos1<dist_pos2){mano=1; p_pos=sketch.pos1;}else{mano=2; p_pos=sketch.pos2;}
            p_pos = sketch.pos1;

            //ESTO ES PARA PROBAR CON EL MOUSE
            //COMENTARLO PARA PROBAR CON EL KINECT
            //p_pos = sketch.pos1;

            activado = true;
        }else{
            var pant = modulo.getPantallaActual();
            if(pant.metodos.invokeFunction("hayEspacioEnHover")){
                pant.metodos.invokeFunction("agregarCaja",id);
            }
            activado = false;
        }
    }
}

function Hover(){}

function setPosFinal(pos){
    boton.setPos(pos);
    img.setPos(boton.getPos());
    colocado = true;
}

//Funcion para el foreach
function formano(m){
    if (m.getPos() == _pos) {
        mano = m;
    }
}

function setid(_num) {
    id = parseInt(_num);
}

function cambiaractivado(a) {
    activado = a;
}

function setimg(_selec) {
    img = sketch.hacerImagen(_selec, boton.getPos(), boton.getTam());
}

function getId(){return id;}
function getActivado(){return activado;}

