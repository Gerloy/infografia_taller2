var imgs = [];
var imgs_selec = [];
var img_actual = 0;

var cooldown = 4000;
var time = 0;

function Init(){
    imgs = [];
    imgs_selec = [];
    for(var i=0; i<28; i++){
        imgs[i] = sketch.hacerImagen('imagenes/juego2/imgs_juego/'+i+'.png',boton.getPos(),boton.getTam());
    }
    img_actual = Math.floor(Math.random()*imgs.length);
}

function Update(){
    time += sketch.time.DeltaTime();
    if(time >= cooldown){
        img_actual = Math.floor(Math.random()*imgs.length);
        time = 0;
    }
}

function Dibujar(){
    if(imgs != null && img_actual != null){
    imgs[img_actual].render();
    }
}

function Hover(){}

function Click(a){
    imgs_selec.push(imgs[img_actual]);
    imgs.splice(img_actual,1);
    img_actual = Math.floor(Math.random()*imgs.length);
    time = 0;
}

function getImgs_selec(){return imgs_selec;}
