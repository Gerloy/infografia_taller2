public class Boton{
    private Vector2 pos, tam;
    private Col col_fill, col_stroke;
    public  ScriptEngine scriptEngine;
    public  Invocable metodos;

    Boton(float _posx, float _posy,float _tamx, float _tamy, Col _col_fill, Col _col_stroke, ScriptEngineManager _manager, infografia_taller2 app, String path_script, Modulo mod){
        pos = new Vector2(_posx,_posy);
        tam = new Vector2(_tamx,_tamy);
        col_fill = _col_fill;
        col_stroke = _col_stroke;
        
        //Creo el script engine del boton
        scriptEngine = _manager.getEngineByName("JavaScript");
        metodos = (Invocable) scriptEngine;
        
        scriptEngine.put("sketch", app);
        scriptEngine.put("modulo", mod);
        scriptEngine.put("boton",this);
        
        if(path_script != ""){
          //Carga el archivo del script como un String
          String content = "";
          {
            String[] archivo = loadStrings(path_script);
            for(String s : archivo){
              content += s;
              content += '\n';
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
    
    public void init(){
      //Hacemos el init del script del boton
      try{
        metodos.invokeFunction("Init");
      }catch(ScriptException ex){
        ex.printStackTrace();
      }catch(NoSuchMethodException ex){
        println("No existe el metodo Init");
      }
    }
        
    public void update(Vector2 pos1, Vector2 pos2){
      //Hacemos el update del script del boton
      try{
        metodos.invokeFunction("Update");
      }catch(ScriptException ex){
        ex.printStackTrace();
      }catch(NoSuchMethodException ex){
        println("No existe el metodo Update");
      }
      
      if (adentro(pos1) || adentro(pos2)){
        hover();
      }
    }

    public void draw(){
        pushStyle();
            fill(col_fill.r,col_fill.g,col_fill.b,col_fill.a);
            stroke(col_stroke.r,col_stroke.g,col_stroke.b,col_stroke.a);
            rect(pos.x,pos.y,tam.x,tam.y);
        popStyle();
        try{
        metodos.invokeFunction("Dibujar");
      }catch(ScriptException ex){
        ex.printStackTrace();
      }catch(NoSuchMethodException ex){
        println("No existe el metodo Dibujar");
      }
    }
    
    public void click(Vector2 _pos){
      try{
        metodos.invokeFunction("Click",_pos);
      }catch(ScriptException ex){
        ex.printStackTrace();
      }catch(NoSuchMethodException ex){
        println("No existe el metodo Click");
      }
    }
    
    public void hover(){
      try{
        metodos.invokeFunction("Hover");
      }catch(ScriptException ex){
        ex.printStackTrace();
      }catch(NoSuchMethodException ex){
        println("No existe el metodo Hover");
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
    public boolean adentro(Vector2 _pos){
        return (((_pos.x>pos.x) && (_pos.x<pos.x+tam.x)) && ((_pos.y>pos.y) && (_pos.y<pos.y+tam.y)));
    }
    
    //getters
    public int[] getColFill(){return col_fill.getCol();}
    public int[] getColStroke(){return col_fill.getCol();}
    public Vector2 getPos(){return pos;}
    public Vector2 getTam(){return tam;}
    
    //setters
    public void setColFill(int _r, int _g, int _b, int _a){ col_fill.setCol(_r,_g,_b,_a);}
    public void setColStroke(int _r, int _g, int _b, int _a){ col_stroke.setCol(_r,_g,_b,_a);}
    
    public void setPos(Vector2 _pos){pos=_pos;}
    public void setTam(Vector2 _tam){tam=_tam;}
}
