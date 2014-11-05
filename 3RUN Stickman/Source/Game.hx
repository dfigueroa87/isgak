package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;
import flash.media.Sound;
import utiles.InputManager;
import background.Back;


class Game extends GameElement {

	private var personaje:Personaje;
	private var sound:flash.media.Sound;
	
	private var back = new Back();
	
	public function new () {
		super();
		
		//Cargo los Assets
		//obstaculo = new Bitmap (Assets.getBitmapData ("images/asteroid.png"));
		personaje = new Personaje();
		//sound = Assets.getSound ("sound3");

		// Los coloco en Pantalla
		this.addChild(personaje);

		this.addEventListener(flash.events.Event.ENTER_FRAME, gameLoop);	
			
		back.collapse_x = 5;
		back.fill( Assets.getBitmapData ("images/buildings.png") );
		this.addChild(back);
	}
	
	// Nuestro gameLoop (se ejecuta antes de cada cuadro).
	function gameLoop(e){
		personaje.updateLogic(1/60);
       	
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
