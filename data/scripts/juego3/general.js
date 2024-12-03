//Todo lo que se escriba fuera de una funcion se va a ejecutar una sola vez en el momento en que se cargue el script al ScriptEngine
var inicio = false;
var agarroCaja = false;
var espacios;
var botones;
var bid = -1;

function Init(){
    //Estos son los containers de las cajas cuando las metes en la pila
    espacios = modulo.getPantallaActual().getBotones();

    modulo.getPantallaActual().agregarBotonesAlArray(cargarImagenes(sketch.leerArchivo('/save/imagenes.json')));
    botones = modulo.getPantallaActual().getBotones();
    inicio = true;
}

function Update(){
    if (inicio){
        updateTimer();
    }
}

function Click(pos1){
    if(botones!=null){
        var min_dist = 10000;
        if(!agarroCaja){
            bid = -1;

            for (var i=7;i<botones.length;i++){
                if(botones[i]!=null && !botones[i].metodos.invokeFunction("getActivado")){
                    var actual_dist = sketch.checkearDist(botones[i].getPos(),pos1);                        
                    if(actual_dist<min_dist){
                        min_dist = actual_dist;
                        bid = i;
                    }
                }
            }
            print(bid);
            botones[bid].metodos.invokeFunction("agarrar");
        agarraCaja();
        }else{
            botones[bid].metodos.invokeFunction("soltar");
            sueltaCaja();

        }
        //agarrarCaja(bid);
        

    }
}

function Dibujar(){
    //Mostrar texto del cronometro
    sketch.texto((segs +":"+parseInt((((actual_time/1000)-segs).toFixed(2))*100)), sketch.crearVector(653,68));
}

//Variables
function settime(relleno){time = 0;}
function setactual_time(t){actual_time = parseInt(t);}
function setsegs(relleno){segs = 0;}

//Cositas
function updateTimer(){
    actual_time -= sketch.time.DeltaTime();
    segs = Math.floor(actual_time/1000);
    if (actual_time<=0){
        sketch.setModPath(modulo.getSig());
        sketch.mandarACargar();
    }
}

//parsea el JSON y carga las imagenes como un array de botones y los devuelve
function cargarImagenes(file){
    var json = JSON.parse(file);
    var botones = [json.imagenes.length];

    for (var i=0;i<json.imagenes.length;i++){
        var path = json.imagenes[i].path;
        var id = json.imagenes[i].id;

        botones[i] = sketch.crearBoton(sketch.escalar(sketch.crearVector(82*i,480)),sketch.escalar(sketch.crearVector(79,79)),sketch.crearColor(0,0,0,255),sketch.crearColor(0,0,0,255),modulo,'scripts/juego3/caja.js');

        //Le agrego las variables que necesita porque el constructor no las va a cargar
        botones[i].agregarVariable('img',path);
        botones[i].agregarVariable('id',toString(id));
    }

    return botones;
}

//Para agregar cajas a la pila
function agregarCaja(_id){
    var botones = modulo.getPantallaActual().getBotones();
    var caja;
    //veo que caja tengo que agregar
    for(var i=espacios.length;i<botones.length;i++){
        if (botones[i].metodos.invokeFunction("getId") == _id){
            caja = botones[i];
            break;
        }
    }
    for(var i=0;i<espacios.length;i++){
        if(!botones[i].metodos.invokeFunction("getActivado")){
            caja.metodos.invokeFunction("setPosFinal", botones[i].getPos());
            botones[i].metodos.invokeFunction("cambiaractivado",true);
            break;
        }
    }
}

function hayEspacioEnHover(){
    for(var i=0;i<espacios.length;i++){
        if(espacios[i].metodos.invokeFunction("getHover")){
            return true;
        }
    }
    return false;
}

//Cosas para cosas
function agarraCaja(){agarroCaja=true;}
function sueltaCaja(){agarroCaja=false;}