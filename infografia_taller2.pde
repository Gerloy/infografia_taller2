import javax.script.*;
import java.lang.reflect.*;
import fisica.*;

public enum Estado{
    CARGANDO,
    MANDAR_A_CARGAR,
    JUGANDO;
}

Modulo mod;
Estado estado;
String path_mod;
ScriptEngineManager manager = new ScriptEngineManager();
Vector2 pos1,pos2;
Time time;

void setup(){
    size(1280,720,P2D);
    frameRate(60);
    textAlign(CENTER);
    path_mod = "data/modulos/mod3.json";
    mod = new Modulo(path_mod, manager, this);
    estado = Estado.JUGANDO;
    pos1 = new Vector2(0,0);
    pos2 = new Vector2(1000,1000);
    time = new Time();
}

void draw(){
    background(0);
    switch(estado) {
        case CARGANDO:
            text("Cargando", width*0.5, height*0.5);
        break;

        case MANDAR_A_CARGAR:
            thread("cargarModulo");
            estado = Estado.CARGANDO;
        break;

        case JUGANDO:
          pos1.set(mouseX,mouseY);
            mod.update(pos1,pos2);
            mod.draw();
        break;

        default:
            text("Rompiste todo pelotudo", width*0.5, height*0.5);
        break;
    }
}

void cargarModulo(){
    mod = new Modulo(path_mod, manager, this);
    estado = Estado.JUGANDO;
}


//Estas funciones son las que usas en js para cambiar las variables
public void setEstado(Estado _e){estado = _e;}

public void setModPath(String _path){path_mod=_path;}

void mouseClicked(){
  mod.click(pos1);
}

//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------

//Clases para lo que se necesite
public class Vector2{
  float x;
  float y;
  
  Vector2(float _x, float _y){
    x = _x;
    y = _y;
  }
  
  //Estas funciones son las que usas en js para cambiar las variables
  public void set(float _x, float _y){
    x = _x;
    y = _y;
  }
  
  public float getX(){return x;}
  public float getY(){return y;}
}

public class Col{
  public int r, g, b;
  
  Col(int _r, int _g, int _b){
    r = _r;
    g = _g;
    b = _b;
  }
  
  //Estas funciones son las que usas en js para cambiar las variables
  //getter para usar en un momento especifico
  public int[] getCol(){
    int[] arr = {r,g,b};
    return(arr);
  }
  //seter para usar en un momento especifico
  public void setCol(int _r, int _g, int _b){
    r = _r;
    g = _g;
    b = _b;
  }
}

public class Imagen{
  public PImage img;
  public Vector2 pos, tam;
  
  Imagen(PImage _img, Vector2 _pos, Vector2 _tam){
    img = _img;
    pos = _pos;
    tam = _tam;
  }
  
  //Estas funciones son las que usas en js para cambiar las variables
  public void chgImagen(PImage _img){img = _img;}
  public void setPos(Vector2 _pos){pos = _pos;}
  public void setTam(Vector2 _tam){tam = _tam;}
  public void render(){image(img, pos.x, pos.y, tam.x, tam.y);}
}

public class Animacion{
  Imagen[] imgs;
  int id;
  int cooldown, t;
  boolean repite;
  
  Animacion(PImage[] _imgs, Vector2 _pos, Vector2 _tam, int _cooldown, boolean _repite){
    imgs = new Imagen[_imgs.length];
    for(int i=0; i<_imgs.length; i++){
      imgs[i] = new Imagen(_imgs[i],_pos,_tam);
    }
    id = 0;
    t = 0;
    cooldown = _cooldown;
    repite = _repite;
  }
  
  //Estas funciones son las que usas en js para cambiar las variables
  //(si es que las tenes que usar. Pero creo que no deberia ser necesario quitando casos muuuuy expecificos)
  public void update(){
    t+=time.DeltaTime();
    if (t>=cooldown){
      if (id<imgs.length){
        id ++;
      }else{
        if (repite){
          id = 0;
        }
      }
      t-=cooldown;
    }
  }
  
  public void render(){
    imgs[id].render();
  }
  
  public void setId(int _id){id = _id;}
  public void setCooldown(int _cooldown){cooldown=_cooldown;}
}

public class Time{
  int p_millis ,delta;
  
  Time(){
    p_millis = millis();
    delta = 0;
  }
  
  public void update(){
    delta = millis() - p_millis;
    p_millis = millis();
  }
  
  //Con esta function conseguis el deltatime si lo necesitas
  public int DeltaTime(){
    return delta;
  }
}
