package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;
import flash.media.Sound;
import utiles.InputManager;
import background.Back;


class GameScene extends Scene {
	
	static var MAX_DIF_Y = 100;
	static var TOTAL_X_MIN = 700;
	static var MAX_LONG = 500;
	static var LONG_INI = 700;
	static var GRAVITY = 0.9;

	private var personaje:Personaje;
	private var sound:flash.media.Sound;
	
	private var back = new Back();
	
	public var platforms:Array<Plataforma>;
	private var longPlatform:Float;
	private var circle:MagicCircle;
	
	public function new () {
		super();
		
		back.collapse_x = 5;
		back.fill( Assets.getBitmapData ("images/buildings.png") );
		this.addChild(back);
		
		platforms = new Array<Plataforma>();
				
		var suelo = new Plataforma(0, 380, LONG_INI);
		platforms.push(suelo);
		longPlatform = LONG_INI;
		
		this.addChild(suelo);
		this.hijos.push(suelo);
		
		circle = new MagicCircle();
		circle.x = 700;
		circle.y = 350;
		this.addChild(circle);
		this.hijos.push(circle);
		
		personaje = new Personaje(this);
		this.addChild(personaje);

		this.addEventListener(flash.events.Event.ENTER_FRAME, gameLoop);	
			
		
	}
	
	// Nuestro gameLoop (se ejecuta antes de cada cuadro).
	function gameLoop(e){
		personaje.updateLogic(1 / 60);
		
		if (personaje.isMoving()) {
			longPlatform--;
			if (longPlatform < TOTAL_X_MIN) {
				var width = randWidth();
				var y = newHeight(platforms[platforms.length - 1].getY());
				var suelo = new Plataforma(longPlatform, y, width);
				longPlatform += width;
				this.addChild(suelo);
				this.hijos.push(suelo);
				platforms.push(suelo);
				circle.y = y;
			}
		}

	}

    // Detecta si obj1 y obj2 colisionan por el metodo mas simple de todos.
    public static function detectarColision(obj1:GameElement, obj2:GameElement):Bool {
		if(obj1.x+obj1.width>obj2.x && obj1.x<obj2.x+obj2.width){
		   	if(obj1.y+obj1.height>obj2.y && obj1.y<obj2.y+obj2.height){
		   		return true;
		   	}
		}
		return false;
    }
	
	private function newHeight(y:Float):Float {
		if (y < 2 * MAX_DIF_Y) {
			return y + Math.random() * MAX_DIF_Y;
		}
		if (y > 700) {
			return y - Math.random() * MAX_DIF_Y;
		}
		
		if (Math.random() < 0.5) {
			return y + Math.random() * MAX_DIF_Y;
		} else
			return y - Math.random() * MAX_DIF_Y;
	}
	
	private function randWidth():Float {
		return Math.random() * MAX_LONG;
	}
		
}
