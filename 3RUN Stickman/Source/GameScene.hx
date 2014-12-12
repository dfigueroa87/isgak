package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;
import openfl.media.Sound;
import utiles.InputManager;
import utiles.Aligner;
import utiles.Persistence;
import openfl.text.TextFormatAlign;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import haxe.Timer;

class GameScene extends Scene {
	
	static var MIN_DIF_Y = 40;
	static var MAX_DIF_Y = 100;
	static var TOTAL_X_MIN = 700;
	static var MIN_LONG = 50;
	static var MAX_LONG = 500;
	static var LONG_INI = 700;
	static var GRAVITY = 0.9;
	static var MIN_JUMP = 110;
	static var MAX_JUMP = 200;

	private var personaje:Personaje;
	
	private var background : FondoAnimado;
	private var background2 : FondoAnimado;
	private var backgroundRain : FondoLluvia;
	
	public var platforms:Array<Plataforma>;
	private var longPlatform:Float;
	//private var circle:MagicCircle;
	
	private var backgrond_music_path:String = "sounds/Rain.ogg";
	private var backgrond_music:Sound;
	
	private var score :Score;
	private var distance : Int;
	
	public function new () {
		super();
		
		backgrond_music = Assets.getSound(backgrond_music_path);
		//0 = start time, 9999 is repeat count
		backgrond_music.play(0,9999);
		
		background = new FondoAnimado("images/buildings.png", 30);
		background2 = new FondoAnimado("images/buildings2.png", 80);
		backgroundRain = new FondoLluvia("images/rain.png", 50);
		
		backgroundRain.alpha = 0.5;
		
		this.addChild(background);
		this.addChild(backgroundRain);
		this.addChild(background2);
		
		this.hijos.push(background);
		this.hijos.push(background2);
		this.hijos.push(backgroundRain);
		
		platforms = new Array<Plataforma>();

		var suelo = new Plataforma(0, 380, LONG_INI);
		platforms.push(suelo);
		longPlatform = LONG_INI;
		
		this.addChild(suelo);
		this.hijos.push(suelo);
		
		personaje = new Personaje(this);
		this.addChild(personaje);
		
		//SCORE
		distance = 0;
		score = new Score();
		score.BASE = Math.round( (personaje.x - suelo.x ) / 30 );
		score.LABEL = "Dist ";
		this.addChild(score);
		this.hijos.push(score);
		
		//circle = new MagicCircle();
		//circle.x = 700;
		//circle.y = 350;
		//this.addChild(circle);
		//this.hijos.push(circle);

		this.addEventListener(flash.events.Event.ENTER_FRAME, gameLoop);	
		
	}
	
	// Nuestro gameLoop (se ejecuta antes de cada cuadro).
	function gameLoop(e) {
		if (personaje.estado == 0) return;
		
		if (personaje.y > stage.stageHeight) {
			personaje.die();
			showFinalScore();
			
		}
		
		// Eliminar plataformas pasadas
		for (platform in platforms) {
			if (platform.x + platform.long < 0) {
				this.hijos.remove(platform);
				this.removeChild(platform);
				platforms.remove(platform);
			}
		}
		
		background.updateLogic(1 / 60);
		background2.updateLogic(1 / 60);
		backgroundRain.updateLogic(1 / 60);
		personaje.updateLogic(1 / 60);
		
		score.setValue ( distance++ );
		if (personaje.isMoving()) {
			longPlatform -= personaje.getVelocity();
			for (platform in platforms){
				platform.velocity = personaje.getVelocity();
			}
		}
		if (longPlatform < TOTAL_X_MIN) {
				var width = randWidth();
				var y = newHeight(platforms[platforms.length - 1].getY());
				var jump = newJump();
				var x = jump + longPlatform;
				var suelo = new Plataforma(x, y, width);
				longPlatform += width + jump;
				this.addChild(suelo);
				this.hijos.push(suelo);
				platforms.push(suelo);
				//circle.y = y;
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
	
	private function showFinalScore(){
		for (element in hijos) {
			element.alpha = 0.2;
		}

		var format = new TextFormat();
		format.font = "Bauhaus 93";
		format.size = 40;
		format.color = 0xFFFFFF;
		format.align = TextFormatAlign.CENTER;
		
		var finalScore = new TextField ();
		finalScore.width = Aligner.getInstance().stage.stageWidth;
		finalScore.defaultTextFormat = format;
		finalScore.text = "You weren't good enough." + '\n' + "Your score: " + score.value;
		Persistence.setScore(score.value);
		Aligner.getInstance().centerScreenX(finalScore);
		Aligner.getInstance().centerScreenY(finalScore);
		this.addChild(finalScore);
		
		Timer.delay(goToMenu, 5000);
	}
	
	private function goToMenu(){
		Main.getInstance().setScene('menu');
	}
	
	private function newHeight(y:Float):Float {
		if (y < 2 * MAX_DIF_Y) {
			return y + MIN_DIF_Y + Math.random() * MAX_DIF_Y;
		}
		if (y > 450) {
			return y - MIN_DIF_Y - Math.random() * MAX_DIF_Y;
		}
		
		if (Math.random() < 0.5) {
			return y + MIN_DIF_Y + Math.random() * MAX_DIF_Y;
		} else
			return y - MIN_DIF_Y - Math.random() * MAX_DIF_Y;
	}	
	
	private function newJump():Float {
		if (Math.random() < 0.8) {
			return (1 + Math.random()) * MIN_JUMP;
		}
		else {
			return (1 + Math.random()) * MAX_JUMP;
		}
	}
	
	private function randWidth():Float {
		return MIN_LONG + Math.random() * MAX_LONG;
	}
		
}
