public class Pantalla{
    Boton[] botones;
    //Text[] textos;
    PImage fondo;
    ScriptEngine scriptEngine;
    Invocable metodos;
    Imagen[] imagenes;
    Animacion[] animaciones;
    

    Pantalla(PImage _fondo, Imagen[] _imagenes, Animacion[] _animaciones, Boton[] _botones, ScriptEngineManager _manager, infografia_taller2 app, String path_script, Modulo mod) throws NullPointerException{
        fondo = _fondo;
        botones = _botones;
        imagenes = _imagenes;
        animaciones = _animaciones;
        
        //Creo el script engine del boton
        scriptEngine = _manager.getEngineByName("JavaScript");
        metodos = (Invocable) scriptEngine;
        
        scriptEngine.put("sketch", app);
        scriptEngine.put("modulo", mod);
        scriptEngine.put("pantalla", this);
        
        if (path_script != ""){
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
        }
    }

    void draw(){
        image(fondo,0,0,width,height);
        for (Boton boton : botones){
            boton.draw();
        }
        for (Imagen img : imagenes){
          img.render();
        }
    }
    
    void update(Vector2 pos1, Vector2 pos2){
      for (Boton boton : botones){
        boton.update(pos1,pos2);
      }
      
      //Hacemos el update del script de la pantalla
      try{
        metodos.invokeFunction("Update");
      }catch(ScriptException ex){
        ex.printStackTrace();
      }catch(NoSuchMethodException ex){
        println("No existe el metodo Update");
      }
    }
    
    void click(Vector2 pos){
      for(Boton boton : botones){
        if(boton.adentro(pos)){
          boton.click();
        }
      }
       //Hacemos el update del script de la pantalla
      try{
        metodos.invokeFunction("Click");
      }catch(ScriptException ex){
        ex.printStackTrace();
      }catch(NoSuchMethodException ex){
        println("No existe el metodo Click");
      }
    }
    
    public void agregarVariable(String _nombre, String _valor){
      scriptEngine.put(_nombre,"");
      try{
        metodos.invokeFunction("set"+_nombre,_valor);
      }catch(ScriptException ex){
        ex.printStackTrace();
      }catch(NoSuchMethodException ex){
        println("No existe el metodo set"+_nombre);
        ex.printStackTrace();
      }
    }
    
    //Estas funciones son las que usas en js para cambiar las variables
    public Imagen[] getImagenes(){return imagenes;}
    public Animacion[] getAnimaciones(){return animaciones;}
}
