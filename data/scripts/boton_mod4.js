let hoverX = 200; // Coordenada X del área de hover
let hoverY = 200; // Coordenada Y del área de hover
let hoverAncho = 1280; // Ancho del área de hover
let hoverAlto = 720; // Alto del área de hover

function Init() {}

function Update() {}

function Dibujar() {
    // Renderiza la imagen seleccionada o no seleccionada según el estado
    if (select) {
        img_selec.render();
    } else {
        img.render();
    }
    select = false; // Reinicia el estado después de dibujar
}

function Hover(mouseX, mouseY) {
    // Comprueba si el mouse está dentro del área de hover
    if (
        mouseX > hoverX && mouseX < hoverX + hoverAncho &&
        mouseY > hoverY && mouseY < hoverY + hoverAlto
    ) {
        select = true; // Activa el estado de hover
    } else {
        select = false; // Desactiva el estado de hover
    }
}

function Click() {}

function setid(_num) {
    id = parseInt(_num); // Convierte el número a entero y lo asigna
}

function setimg(_selec) {
    // Crea la imagen normal
    img = sketch.hacerImagen(_selec, boton.getPos(), boton.getTam());
}

function setimg_selec(_selec) {
    // Crea la imagen seleccionada
    img_selec = sketch.hacerImagen(_selec, boton.getPos(), boton.getTam());
}

function setselect(_select) {
    select = false; // Reinicia el estado de selección
    boton.setColFill(0, 128, 128, 0); // Establece el color de relleno
    boton.setColStroke(0, 128, 128, 0); // Establece el color del borde
}

// Eventos del mouse
document.addEventListener("mousemove", (event) => {
    Hover(event.clientX, event.clientY); // Detecta la posición del mouse
});
