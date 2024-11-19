function Init(){}

function Update(){}

function Click(){
    if (modulo.getPantalla() < modulo.cantPantallas()-1) {
        modulo.setPantalla(modulo.getPantalla() + 1) 
    }else{
        sketch.setModPath("data/modulos/mod5.json");
        sketch.mandarACargar();
    }
}