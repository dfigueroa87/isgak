package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;
import openfl.media.Sound;
import utiles.InputManager;
import background.Back;


class GameScene extends Scene {
	
	static var MIN_DIF_Y = 40;
	static var MAX_DIF_Y = 100;
	static var TOTAL_X_MIN = 700;
	static var MIN_LONG = 50;
	static var MAX_LONG = 500;
	static var LONG_INI = 700;
	static var GRAVITY = 0.9;

	private var personaje:Personaje;
	
	private var back = new Back();
	
	public var platforms:Array<Plataforma>;
	private var longPlatform:Float;
	private var circle:MagicCircle;
	
	private var backgrond_music_path:String = "sounds/Sevish_-_My_Girl_Is_Blue.ogg";
	private var backgrond_music:Sound;
	private var suelo : Plataforma;
	
	private var score :Score;
	
	public function new () {
		super();
		
		backgrond_music = Assets.getSound(backgrond_music_path);
		//0 = start time, 9999 is repeat count
		backgrond_music.play(0,9999);
		
		back.collapse_x = 5;
		back.fill( Assets.getBitmapData ("images/buildings.png") );
		this.addChild(back);
		this.hijos.push(back);
		
		platforms = new Array<Plataforma>();

		suelo = new Plataforma(0, 380, LONG_INI);
		platforms.push(suelo);
		longPlatform = LONG_INI;
		
		this.addChild(suelo);
		this.hijos.push(suelo);
		
		personaje = new Personaje(this);
		this.addChild(personaje);
		
		//SCORE
		score = new Score();
		score.BASE = Math.round( (personaje.x - suelo.x ) / 30 );
		score.LABEL = "Dist ";
		this.addChild(score);
		this.hijos.push(score);
		
		circle = new MagicCircle();
		circle.x = 700;
		circle.y = 350;
		this.addChild(circle);
		this.hijos.push(circle);

		this.addEventListener(flash.events.Event.ENTER_FRAME, gameLoop);	
		
	}
	
	// Nuestro gameLoop (se ejecuta antes de cada cuadro).
	function gameLoop(e){
		personaje.updateLogic(1 / 60);
		var distance = (personaje.x - suelo.x ) / 30;
		score.setValue ( distance );
		if (personaje.isMoving()) {
			longPlatform -= 5;
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
			return y + MIN_DIF_Y + Math.random() * MAX_DIF_Y;
		}
		if (y > 700) {
			return y - MIN_DIF_Y - Math.random() * MAX_DIF_Y;
		}
		
		if (Math.random() < 0.5) {
			return y + MIN_DIF_Y + Math.random() * MAX_DIF_Y;
		} else
			return y - MIN_DIF_Y - Math.random() * MAX_DIF_Y;
	}
	
	private function randWidth():Float {
		return MIN_LONG + Math.random() * MAX_LONG;
	}
		
}
