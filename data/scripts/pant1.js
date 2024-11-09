/*function Update(){}*/

function Click(){
    /*
    if (getPantalla >= ULTIMA-PANTALLA) {
        
    }
    */ 
    if (modulo.getPantalla() <= 1) {
        modulo.setPantalla(modulo.getPantalla() + 1) 
    }
}