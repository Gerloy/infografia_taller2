//Todo lo que se escriba fuera de una funcion se va a ejecutar una sola vez en el momento en que se cargue el script al ScriptEngine
var inicializado = false;

function Update(){
    if (!inicializado){inicializar;}
    updateTimer();
}

function Click(){}

function Dibujar(){
    
    //Mostrar texto del cronometro
    sketch.texto((segs +":"+(((actual_time/1000)-segs).toFixed(2))*100), sketch.crearVector(653,68));
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

function inicializar(){
    modulo.getPantallaActual().agregarBotonesAlArray(cargarImagenes(sketch.leerArchivo('/save/imagenes.json')));
    inicializado = true;
}
//lee el JSON y lo devuelve como texto
function fetchJSON(){
    //fetch('../../save/imagenes.json')
    //    .then((res)=>{
    //        if (!res.ok){
    //            throw new Error("F");    
    //        }
    //        return res.json();
    //    })
    //    .catch((error)=> print("Pasaron cosas", error));
    //var fr = new FileReader;
    //return fr.readAsText('../../save/imagenes.json');
}

//parsea el JSON y carga las imagenes como un array de botones y los devuelve
function cargarImagenes(file){
    var json = JSON.parse(file);
    //print(json.imagenes);
    var botones = [json.imagenes.length];

    for (var i=0;i<json.imagenes.length;i++){
        var path = json.imagenes[i].path;
        var id = json.imagenes[i].id;

        botones[i] = sketch.crearBoton(sketch.escalar(sketch.crearVector(82*i,638)),sketch.escalar(sketch.crearVector(82,82)),sketch.crearColor(0,0,0,255),sketch.crearColor(0,0,0,255),modulo,'scripts/juego3/caja.js');

        //Le agrego las variables que necesita porque el constructor no las va a cargar
        botones[i].agregarVariable('activado','0');
        botones[i].agregarVariable('img',path);
        botones[i].agregarVariable('id',toString(id));
    }

    return botones;
}