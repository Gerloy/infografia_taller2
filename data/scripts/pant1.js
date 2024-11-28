function Init(){}

function Dibujar(){}

function Update(){}

function Click(e){
    if (modulo.getPantalla() < modulo.cantPantallas()-1) {
        modulo.setPantalla(modulo.getPantalla() + 1) 
    }else{
        sketch.setModPath(modulo.getSig());
        sketch.mandarACargar();
    }
}