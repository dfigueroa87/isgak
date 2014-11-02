package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;
import flash.media.Sound;
/**
 * ...
 * @author fbricker
 */
class Game extends Sprite {

	private var personaje:Personaje;
	private var obstaculo:Bitmap;
	private var inmunidad:Int;
	private var sound:flash.media.Sound;

	public function new () {
		super();
		
		//Cargo los Assets
		obstaculo = new Bitmap (Assets.getBitmapData ("images/asteroid.png"));
		personaje = new Personaje();
		sound = Assets.getSound ("sound3");
		
		// Inicializo algunas variables
		inmunidad=0;
		
		obstaculo.x=-700;
		obstaculo.y=200;
		obstaculo.scaleX=obstaculo.scaleY=0.6;
		
		// Los coloco en Pantalla
		this.addChild(personaje);
		this.addChild(obstaculo);

		stage.addEventListener(flash.events.Event.ENTER_FRAME,gameLoop);

		InputManager.getInstance().suscribe(stage);		
	}
	
	// Nuestro gameLoop (se ejecuta antes de cada cuadro).
	function gameLoop(e){
		personaje.updateLogic(1/60);
		
		obstaculo.x-=2.2;
       	       	
       	if(obstaculo.x<obstaculo.width*-1){
	       	obstaculo.x=850;
	       	obstaculo.y=Math.random()*400;
       	}
       	
       	
       	// Colision contra asteroide e inmunidad post-colision
       	if(inmunidad>0){
       		inmunidad--;
       		//personaje.visible=inmunidad%20<10;
       	}else{
	       	if(detectarColision(personaje,obstaculo)){
	       		inmunidad=200;
	       		sound.play();
	       	}
       	}
	}


    // Detecta si obj1 y obj2 colisionan por el metodo mas simple de todos.
    private function detectarColision(obj1:GameElement,obj2:Bitmap):Bool{
		if(obj1.x+obj1.width>obj2.x && obj1.x<obj2.x+obj2.width){
		   	if(obj1.y+obj1.height>obj2.y && obj1.y<obj2.y+obj2.height){
		   		return true;
		   	}
		}
		return false;
    }
		
}
