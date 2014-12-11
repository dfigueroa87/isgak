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
	public var long : Float;
	private var altura : Float;
	
	public var velocity : Float;
	
	public function new(x:Float, y:Float, width:Float) {
		super();
		
		this.x = x;
		this.y = y;
		this.velocity = 0;
		
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
		x -= velocity;
	}
	
	public function getY() : Float {
		return this.altura;
	}
}