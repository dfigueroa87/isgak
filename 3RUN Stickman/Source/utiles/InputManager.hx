package utiles ;

import flash.display.Stage;
import flash.events.KeyboardEvent;


class InputManager {
	
	public  var teclas:Array<Bool>;
	
	private static var instance:InputManager=null;
	
	public static function getInstance():InputManager{
		if(instance==null){
			instance=new InputManager();
		}
		return instance;
	} 
	
	private function new () {
		teclas=new Array<Bool>();
		
	}
	
	public function suscribe(stage:Stage){
		// Suscribo los Eventos para el Teclado
		stage.addEventListener(flash.events.KeyboardEvent.KEY_UP, onKeyUp);
		stage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, onKeyDown);
	}

	// Cuando se Suelta una Tecla
    private function onKeyUp(event:KeyboardEvent){
    	teclas[event.keyCode]=false;
    }

	// Cuando se Presiona una Tecla
    private function onKeyDown(event:KeyboardEvent){
		teclas[event.keyCode]=true;
    }
    
    public function keyPressed(key:String):Bool{
    	return teclas[key.charCodeAt(0)];    
    }
	
	public function keyPressedByCode(key:Int):Bool{
    	return teclas[key];
    }	
	
	public function release(key:String) {
		teclas[key.charCodeAt(0)] = false;    
	}
	
	public function releaseByCode(key:Int){
    	teclas[key] = false;
    }	
    
}
