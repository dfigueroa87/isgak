package ;
import openfl._v2.display.Sprite;

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
	
	private var line : Sprite;
	private var long : Float;
	private var altura : Float;
	
	public function new(x:Float, y:Float, width:Float) {
		super();
		
		this.x = x;
		this.y = y;
		
		line = new Sprite();
		line.graphics.clear();
		line.graphics.beginFill(0x000000);
		line.graphics.drawRect(0,0,width,10);
		line.graphics.endFill();
		
		
		
		long = width;
		
		this.addChild(line);
		this.altura = y;
	}
	
	override public function updateLogic(time:Float) {
		super.updateLogic(time);
		if (GameElement.DIED)
			return;
		if(InputManager.getInstance().keyPressedByCode(39)){
			x-=5;
		}
		if (InputManager.getInstance().keyPressedByCode(37)) {
			x+=5;
		}

	}
	
	public function move() {
		x--;
	}
	
	public function getY() : Float {
		return this.altura;
	}
	
	
	
}