class Juego{
  
  PImage fondo;
  Imagen[] imagenes;
  Animacion[] aniaciones;
  Caja[] cajas;
  FWorld mundo;
  String sig;
  ScriptEngine scriptEngine;
  Invocable metodos;
  
  //Para contar los puntos
  int porcentaje;
  
  Juego(String path, ScriptEngineManager _manager, infografia_taller2 app){
    JSONObject file = loadJSONObject(path);
    
    fondo = loadImage(file.getString("Fondo"));
    
    //Carga el script del juego
    JSONObject script = file.getJSONObject("Script");
    String path_script = script.getString("path");
    
    //Creo el script engine del juego
    scriptEngine = _manager.getEngineByName("JavaScript");
    metodos = (Invocable) scriptEngine;

    scriptEngine.put("sketch", app);
    scriptEngine.put("juego", this);
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
    sig = file.getString("Siguiente");
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
  
  public String getSig(){return sig;}
}
