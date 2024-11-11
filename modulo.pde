public class Modulo {
  Pantalla[] pantallas;
  String sig;
  public int pantalla;
  ScriptEngine scriptEngine;
  Invocable metodos;


  Modulo(String path, ScriptEngineManager _manager, infografia_taller2 app) {
    pantalla = 0;
    JSONObject mod_file = loadJSONObject(path);

    JSONArray _pantallas = mod_file.getJSONArray("Pantallas");
    pantallas = new Pantalla[_pantallas.size()];

    for (int i=0; i<_pantallas.size(); i++) {
      JSONObject pan = _pantallas.getJSONObject(i);
      //println(i);

      //Carga los botones
      JSONArray _botones = pan.getJSONArray("Botones");
      Boton[] botones = new Boton[_botones.size()];
      for (int e=0; e<_botones.size(); e++) {
        JSONObject bot = _botones.getJSONObject(e);
        float posx = bot.getFloat("posx");
        float posy = bot.getFloat("posy");
        float tamx = bot.getFloat("tamx");
        float tamy = bot.getFloat("tamy");
        Col col_fill = new Col(bot.getInt("colFR"), bot.getInt("colFG"), bot.getInt("colFB"), bot.getInt("colFA"));
        Col col_stroke = new Col(bot.getInt("colSR"), bot.getInt("colSG"), bot.getInt("colSB"), bot.getInt("colSA"));

        //Cosas del script
        JSONObject script = bot.getJSONObject("Script");
        String path_script = script.getString("path");

        botones[e] = new Boton(posx, posy, tamx, tamy, col_fill, col_stroke, _manager, app, path_script, this);

        //botones[e].scriptEngine.put("boton", botones[e]);
        JSONArray variables = script.getJSONArray("Variables");
        for (int o=0; o<variables.size(); o++) {
          JSONObject var = variables.getJSONObject(o);
          botones[e].agregarVariable(var.getString("nombre"), var.getString("valor"));
        }
      }

      //Carga el fondo
      PImage fondo = loadImage(pan.getString("Fondo"));
      //Carga el script de la pantalla
      JSONObject script = pan.getJSONObject("Script");
      String path_script = script.getString("path");
      //Cargo las otras imagenes que va a haber en la pantalla
      JSONArray arr_imgs = pan.getJSONArray("Imagenes");
      Imagen[] imgs = new Imagen[arr_imgs.size()];
      for (int e=0; e<arr_imgs.size(); e++){
        JSONObject img = arr_imgs.getJSONObject(e);
        imgs[e] = new Imagen(img.getString("path"),new Vector2(img.getFloat("posx"),img.getFloat("posy")),new Vector2(img.getFloat("tamx"),img.getFloat("tamy")));
      }
      //Cargamos las animaciones
      JSONArray arr_anis = pan.getJSONArray("Animaciones");
      Animacion[] anis = new Animacion[arr_anis.size()];
      for (int e=0; e<arr_anis.size(); e++){
        JSONObject ani = arr_anis.getJSONObject(e);
        Vector2 pos = new Vector2(ani.getFloat("posx"),ani.getFloat("posy"));
        Vector2 tam = new Vector2(ani.getFloat("tamx"),ani.getFloat("tamy"));
        JSONArray arr_frames = ani.getJSONArray("frames");
        String[] frames = new String[arr_frames.size()];
        for (int o=0; o<arr_frames.size(); o++){
          JSONObject frame = arr_frames.getJSONObject(o);
          frames[o] = frame.getString("path");
        }
        anis[e] = new Animacion(frames, pos, tam, ani.getInt("cooldown"), ani.getBoolean("repite"));
      }
      
      //Carga todo a la pantalla
      pantallas[i] = new Pantalla(fondo, imgs, anis, botones, _manager, app, path_script, this);
      //println(i);
      //Le agregamos las variables a la pantalla
      JSONArray variables = script.getJSONArray("Variables");
      for (int o=0; o<variables.size(); o++) {
        JSONObject var = variables.getJSONObject(o);
        pantallas[i].agregarVariable(var.getString("nombre"), var.getString("valor"));
      }
    }
    
    
    //Carga el script del modulo
    JSONObject script = mod_file.getJSONObject("Script"); //<>// //<>//
    String path_script = script.getString("path");
    
    //Creo el script engine del modulo
    scriptEngine = _manager.getEngineByName("JavaScript");
    metodos = (Invocable) scriptEngine;

    scriptEngine.put("sketch", app);
    scriptEngine.put("modulo", this);
    if(path_script != ""){
      //Carga el archivo del script como un String
      String content = "";
      {
        String[] archivo = loadStrings(path_script);
        for(String s : archivo){
          content += s;
        }
      }
      //Agrega el script al script engine
      try{
        scriptEngine.eval(content);
      }catch(ScriptException ex){
        ex.printStackTrace();
      }
      //Le agregamos las variables al modulo
      JSONArray variables = script.getJSONArray("Variables");
      for (int o=0; o<variables.size(); o++) {
        JSONObject var = variables.getJSONObject(o);
        this.agregarVariable(var.getString("nombre"), var.getString("valor"));
      }
    }
    
    //Agrega el path al siguiente modulo
    sig = mod_file.getString("Siguiente");
  }

  void draw() {
    pantallas[pantalla].draw();
    try{
        metodos.invokeFunction("Dibujar");
      }catch(ScriptException ex){
        ex.printStackTrace();
      }catch(NoSuchMethodException ex){
        println("No existe el metodo Dibujar");
      }
  }

  void update(Vector2 pos1, Vector2 pos2) {
    //println(pantalla); //<>// //<>//
    pantallas[pantalla].update(pos1, pos2);
    try{
        metodos.invokeFunction("Update");
      }catch(ScriptException ex){
        ex.printStackTrace();
      }catch(NoSuchMethodException ex){
        println("No existe el metodo Update");
      }
  }
  
  void click(Vector2 pos){
    pantallas[pantalla].click(pos);
    try{
        metodos.invokeFunction("Click");
      }catch(ScriptException ex){
        ex.printStackTrace();
      }catch(NoSuchMethodException ex){
        println("No existe el metodo Click");
      }
    
  }

  public void agregarVariable(String _nombre, String _valor) {
    scriptEngine.put(_nombre, "");
    try {
      metodos.invokeFunction("set"+_nombre, _valor);
    }
    catch(ScriptException ex) {
      ex.printStackTrace();
    }
    catch(NoSuchMethodException ex) {
      println("No existe el metodo set"+_nombre);
      ex.printStackTrace();
    }
  }
  
  
  //Estas funciones son las que usas en js para cambiar las variables
  public void setPantalla(int _e) {
    pantalla = _e;
  }
  public int getPantalla() {
    return pantalla;
  }
  
  public int cantPantallas(){return pantallas.length;}
  
  public String getSig(){return sig;}
}
