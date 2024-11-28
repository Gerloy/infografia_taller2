import java.util.Map; //<>//
import java.util.Iterator;
import javax.script.*;
import java.lang.reflect.*;

import SimpleOpenNI.*;

public enum Estado {
  CARGANDO, 
  MANDAR_A_CARGAR, 
  JUGANDO,
  CARGAR_CARGANDO;
}

Modulo mod;
Estado estado;
String path_mod;
ScriptEngineManager manager = new ScriptEngineManager();
public Vector2 pos1, pos2;
Mano[] manos;
public Time time;
SimpleOpenNI context;
Map<Integer, PVector>  handPathList = new HashMap<Integer, PVector>();

//Pantalla de carga
PImage cargando;
Animacion logo;

void setup() {
  size(1280, 720, OPENGL);
  //fullScreen(OPENGL);
  frameRate(60);
  textAlign(CENTER);
  textSize(20);
  manos = new Mano[2];

  //Iniciamos todo
  context = new SimpleOpenNI(this);
  context.enableDepth();
  context.setMirror(true);
  context.enableHand();

  //Estos son los dos gestos que voy a usar para la interaccion
  context.startGesture(SimpleOpenNI.GESTURE_HAND_RAISE);
  context.startGesture(SimpleOpenNI.GESTURE_CLICK);
<<<<<<< Updated upstream

  //path_mod = "data/modulos/devolucion.json";
  path_mod = "data/modulos/juego3.json";
=======
  
  path_mod = "data/modulos/mod5.json";
>>>>>>> Stashed changes
  estado = Estado.CARGAR_CARGANDO;
  pos1 = new Vector2(0, 0);
  pos2 = new Vector2(1000, 1000);
  time = new Time();
}

void draw() {
  background(0);
  time.update();
  switch(estado) {
  case CARGANDO:
    image(cargando,0,0,width,height);
    logo.update();
    logo.render();
    break;

  case MANDAR_A_CARGAR:
    thread("cargarModulo");
    thread("UPDATE");
    estado = Estado.CARGANDO;
    break;

  case JUGANDO:
    //context.update();
    //pos1.set(mouseX, mouseY);
    //mod.update(pos1, pos2);
    mod.draw();
    //dibujarManos();
    pushStyle();
    fill(255, 255, 255, 0);
    strokeWeight(6);
    stroke(255, 255, 255);
    ellipse(pos1.x, pos1.y, 100, 100);
    ellipse(pos2.x, pos2.y, 100, 100);
    popStyle();
    //updateInfo();
    break;
    
  case CARGAR_CARGANDO:
    //Cosas de la pantalla de carga
    cargando = loadImage("imagenes/cargando/fondo.png");
    String[] frames = new String[29];
    for (int i=0;i<frames.length;i++){
      frames[i]= "imagenes/cargando/ani/"+(i)+".png";
    }
    logo = new Animacion(frames,escalar(new Vector2(409,112)),escalar(new Vector2(487,365)),60,true);
    estado = Estado.MANDAR_A_CARGAR;
  break;

  default:
    text("Rompiste todo pelotudo", width*0.5, height*0.5);
    break;
  }
}

void UPDATE(){ //<>//
  println("Se llamo");
  while(true){
    //println("actualiza");
    context.update();
    //updateInfo();
    pos1=new Vector2(mouseX,mouseY);
    if (estado == Estado.JUGANDO){ //<>//
      mod.update(pos1, pos2);
    }
    delay(16);
  }
}


void updateInfo() {
  if (handPathList.size() > 0)  
  {    
    Iterator itr = handPathList.entrySet().iterator();
    while (itr.hasNext())
    {
      Map.Entry mapEntry = (Map.Entry)itr.next(); 
      int handId =  (Integer)mapEntry.getKey();
      PVector p = (PVector)mapEntry.getValue();
      PVector p2d = new PVector();

      context.convertRealWorldToProjective(p, p2d);
      for (int i=0; i<manos.length; i++) {
        if (manos[i]!=null) {
          if (manos[i].idCoincide(handId)) {
            manos[i].setPos(escalar(new Vector2(map(p2d.x, 0, 640, 0, 1280), map(p2d.y, 0, 480, 0, 720))));
          }
        }
      }
    }
  }
  if (manos[0] != null) {
    pos1 = manos[0].pos;
  }// else {
  //  pos1 = new Vector2(2000, 2000);
  //}
  if (manos[1] != null) {
    pos2 = manos[1].pos;
  }// else {
    //pos2 = new Vector2(2000, 2000);
  //}
}

void dibujarManos(){
    for (int i=0; i<manos.length; i++) {
    if (manos[i]!=null) {
      manos[i].dibujar();
    }
  }
}

//Cuando aparece una mano nueva la metemos en el vector de manos
void onNewHand(SimpleOpenNI curContext, int handId, PVector pos)
{
  handPathList.put(handId, pos);
  context.startTrackingHand(pos);
  boolean creo = false;
  for (int i=0; i<manos.length; i++) {
    if (manos[i]==null && !creo) {
      manos[i] = new Mano(handId, new Vector2(6000, 6000));
      creo = true;
    }
  }
}

boolean manoEsta(int _id) {
  if (handPathList.size() > 0)  
  {   
    int id = 0;
    Iterator itr = handPathList.entrySet().iterator();     
    while (itr.hasNext())
    {
      Map.Entry mapEntry = (Map.Entry)itr.next(); 
      id = (Integer)mapEntry.getKey();
      if (id == _id) {
        return true;
      }
    }
  }
  return false;
}

//Update de la mano trackeada
void onTrackedHand(SimpleOpenNI curContext, int handId, PVector pos)
{
  handPathList.put(handId, pos);
}

//Cuando el usuario realiza un gesto, hacemos algo
void onCompletedGesture(SimpleOpenNI curContext, int gestureType, PVector pos)
{
  println("onCompletedGesture - gestureType: " + gestureType + ", pos: " + pos);

  if (gestureType == SimpleOpenNI.GESTURE_HAND_RAISE) {
    int handId = context.startTrackingHand(pos);
    println("hand stracked: " + handId);
  } else if (gestureType == SimpleOpenNI.GESTURE_CLICK) {
    PVector p2d = new PVector();
    context.convertRealWorldToProjective(pos, p2d);
    Click(escalar(new Vector2(map(p2d.x, 0, 640, 0, 1280), map(p2d.y, 0, 480, 0, 720))));
  }
}

//Cuando la mano no se ve desaparece el puntero
void onLostHand(SimpleOpenNI curContext, int handId)
{
  println("onLostHand - handId: " + handId);
  handPathList.remove(handId);
  boolean creo = false;
  for (int i=0; i<manos.length; i++) {
    if (manos[i]!=null && !creo) {
      if (manos[i].idCoincide(handId)) {
        manos[i] = null;
        creo = true;
      }
    }
  }
}

void mandarACargar() {
  estado = Estado.MANDAR_A_CARGAR;
}

void cargarModulo() {
  mod = null;
  mod = new Modulo(path_mod, manager, this);
  mod.init();
  estado = Estado.JUGANDO;
}


//Estas funciones son las que usas en js para cambiar las variables
public void setEstado(Estado _e) {
  estado = _e;
}

public void setModPath(String _path) {
  path_mod=_path;
}

void Click(Vector2 pos) {
  mod.click(pos);
}

void mouseClicked() {
  if(estado == Estado.JUGANDO){
    mod.click(new Vector2(mouseX,mouseY));
  }
}

//Con esta funcion se guarda la puntuacion de los juegos
public void guardarPuntos(int p, String name) {
  JSONObject obj = new JSONObject();
  obj.setInt("puntos", p);
  saveJSONObject(obj, "saves/"+name+".json");
} 

//Con esta funcion se carga la puntuacion de los juegos
public int cargarPuntos(String name) {
  JSONObject obj = loadJSONObject("saves/"+name+".json");
  return obj.getInt("puntos");
}

//Funcion para crear los archivos json que necesitemos
public void escribirArchivo(String path, String contenido){
  String[] cont= {contenido};
  saveStrings(path, cont);
}

public Mano[] getManos(){
  return manos;
}

public Vector2 crearVector(float x, float y) {
  return new Vector2(x, y);
}
public void texto(String t, Vector2 _pos) {
  Vector2 pos = escalar(_pos);
  text(t, pos.x, pos.y);
}

public Boton crearBoton(Vector2 pos, Vector2 tam, Col fill, Col stroke, Modulo mod, String path) {
  return new Boton(pos.x, pos.y, tam.x, tam.y, fill, stroke, manager, this, path, mod);
}

public Vector2 escalar(Vector2 vec) {
  return new Vector2(map(vec.x, 0, 1280, 0, width), map(vec.y, 0, 720, 0, height));
}

public Col crearColor(int r, int g, int b, int a) {
  return new Col(r, g, b, a);
}

public String leerArchivo(String path) {
  String content = "";
  {
    String[] archivo = loadStrings(path);
    for (String s : archivo) {
      content += s;
      content += '\n';
    }
  }
  return content;
}

//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------

//Clases para lo que se necesite
public static class Vector2 {
  float x;
  float y;

  Vector2(float _x, float _y) {
    x = _x;
    y = _y;
  }

  //Estas funciones son las que usas en js para cambiar las variables
  public void set(float _x, float _y) {
    x = _x;
    y = _y;
  }

  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }
}

public class Col {
  public int r, g, b, a;

  Col(int _r, int _g, int _b, int _a) {
    r = _r;
    g = _g;
    b = _b;
    a = _a;
  }

  //Estas funciones son las que usas en js para cambiar las variables
  //getter para usar en un momento especifico
  public int[] getCol() {
    int[] arr = {r, g, b, a};
    return(arr);
  }
  //seter para usar en un momento especifico
  public void setCol(int _r, int _g, int _b, int _a) {
    r = _r;
    g = _g;
    b = _b;
    a = _a;
  }
}

public class Imagen {
  public PImage img;
  public Vector2 pos, tam;
  public String path;

  Imagen(String _img, Vector2 _pos, Vector2 _tam) {
    img = loadImage(_img);
    pos = _pos;
    tam = _tam;
    path = _img;
  }

  //Estas funciones son las que usas en js para cambiar las variables
  public void chgImagen(PImage _img) {
    img = _img;
  }
  public void setPos(Vector2 _pos) {
    pos = _pos;
  }
  public void setTam(Vector2 _tam) {
    tam = _tam;
  }
  public void render() {
    image(img, pos.x, pos.y, tam.x, tam.y);
  }
  
  public String getPath(){return path;}
}

public Imagen hacerImagen(String _img, Vector2 _pos, Vector2 _tam) {
  return new Imagen(_img, _pos, _tam);
}

public class Animacion {
  Imagen[] imgs;
  int id;
  int cooldown, t;
  boolean repite;

  Animacion(String[] _imgs, Vector2 _pos, Vector2 _tam, int _cooldown, boolean _repite) {
    imgs = new Imagen[_imgs.length];
    for (int i=0; i<_imgs.length; i++) {
      imgs[i] = new Imagen(_imgs[i], _pos, _tam);
    }
    id = 0;
    t = 0;
    cooldown = _cooldown;
    repite = _repite;
  }

  //Estas funciones son las que usas en js para cambiar las variables
  //(si es que las tenes que usar. Pero creo que no deberia ser necesario quitando casos muuuuy expecificos)
  public void update() {
    t+=time.DeltaTime();
    if (t>=cooldown) {
      if (id<imgs.length-1) {
        id ++;
      } else {
        if (repite) {
          id = 0;
        }
      }
      t-=cooldown;
    }
  }

  public void render() {
    imgs[id].render();
  }

  public void setId(int _id) {
    id = _id;
  }
  public void setCooldown(int _cooldown) {
    cooldown=_cooldown;
  }
}

public Animacion crearAnimacion(String[] _imgs, Vector2 _pos, Vector2 _tam, int _cooldown, boolean _repite){return new Animacion(_imgs,_pos,_tam,_cooldown,_repite);};

public class Mano {
  int id;
  Vector2 pos;
  Mano(int _id, Vector2 _pos) {
    id = _id;
    pos = _pos;
  }

  public boolean idCoincide(int _id) {
    return(id==_id);
  }

  public void setPos(Vector2 _pos) {
    pos = _pos;
  }
  public Vector2 getPos(){return pos;}

  public void dibujar() {
    pushStyle();
    fill(255, 255, 255, 0);
    strokeWeight(6);
    stroke(255, 255, 255);
    ellipse(pos.x, pos.y, 100, 100);
    popStyle();
  }
}

public class Time {
  int p_millis, delta;

  Time() {
    p_millis = millis();
    delta = 0;
  }

  public void update() {
    delta = millis() - p_millis;
    p_millis = millis();
  }

  //Con esta function conseguis el deltatime si lo necesitas
  public int DeltaTime() {
    return delta;
  }
}
