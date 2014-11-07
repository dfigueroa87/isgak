package ;
import openfl._v2.display.Sprite;
import openfl.display.Bitmap;
import openfl.Assets;
import utiles.InputManager;

/**
 * ...
 * @author Isgak Games
 */

class Plataforma extends GameElement {
	
	static var MAX_DIF_Y = 100;
	static var TOTAL_X_MIN = 1300;
	static var MAX_LONG = 500;
	static var LONG_INI = 1000;
	
	var circleBmp : Bitmap;
	var circle : Sprite;
	
	var long : Float;
	
	public function new() {
		super();
		hijos = new Array<GameElement>();		
		
		circle = new Sprite();
		circle.x = 600;
		circle.y = 350;
 
		circleBmp = new Bitmap( Assets.getBitmapData ("images/magicCircle.png"));
		circleBmp.scaleX = 0.1;
		circleBmp.scaleY = 0.1;
		circleBmp.x = -(circleBmp.width / 2);
		circleBmp.y = -(circleBmp.height / 2);
		circle.addChild(circleBmp);
		
		this.addChild(circle);
		
		long = LONG_INI;
		
		var suelo = new Suelo(0, 380, LONG_INI);
		this.addChild(suelo);
		this.hijos.push(suelo);
	}
	
	override public function updateLogic(time:Float) {
		super.updateLogic(time);
		
		circle.rotation += 30;
		
		
			long--;
			if (long < TOTAL_X_MIN) {
				var width = randWidth();
				var suelo = new Suelo(long, newHeight(hijos[hijos.length - 1].y), width);
				long += width;
				this.addChild(suelo);
				this.hijos.push(suelo);
			}

	}
	
	private function newHeight(y:Float):Float {
		if (Math.random() < 0.5) {
			return y + Math.random() * MAX_DIF_Y;
		} else
			return y - Math.random() * MAX_DIF_Y;
	}
	
	private function randWidth():Float {
		return Math.random() * MAX_LONG;
	}
	
}