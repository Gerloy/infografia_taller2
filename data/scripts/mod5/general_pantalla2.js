var botones;
var activado = 1;

function Init(){
    botones = pantalla.getBotones();
}
function Update(){
    //for(var i=0;i<botones.length;i++){
    //    if(botones[i].metodos.invokeFunction("getActivado")){
    //        activado = i;
    //    }
    //}
}
function Dibujar(){
    if(botones != null){
        botones[activado].metodos.invokeFunction("render");
    }
}
function Hover(){}
function Click(a){}

function activar(id){activado = id;}

