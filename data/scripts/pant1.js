function Init(){}

function Update(){}

function Click(){
    if (modulo.getPantalla() < modulo.cantPantallas()-1) {
        modulo.setPantalla(modulo.getPantalla() + 1) 
    }else{
        sketch.setModPath("data/modulos/juego1.json");
        sketch.mandarACargar();
    }
}