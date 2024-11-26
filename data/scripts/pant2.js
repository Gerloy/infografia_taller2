function Init(){}
function Update(){}
function Dibujar(){}

function Click(){
    if (modulo.getPantalla() < modulo.cantPantallas()-1) {
        modulo.setPantalla(modulo.getPantalla() + 1) 
    }else{
        sketch.setModPath(modulo.getSig());
        sketch.mandarACargar();
    }
}