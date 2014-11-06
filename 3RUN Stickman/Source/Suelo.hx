package ;
import openfl._v2.display.Sprite;
import utiles.InputManager;

/**
 * ...
 * @author Isgak Games
 */
class Suelo extends GameElement {
	
	var line : Sprite;
	var long : Float;

	public function new(x:Float, y:Float, width:Float) {
		super();
		
		line = new Sprite();
		line.graphics.clear();
		line.graphics.beginFill(0x000000);
		line.graphics.drawRect(x,y,width,10);
		line.graphics.endFill();
		
		long = width;
		
		this.addChild(line);
	}
	
	override public function updateLogic(time:Float) {
		//super.updateLogic(time);
		
		if(InputManager.getInstance().keyPressedByCode(39)){
			x--;
		}
	}
	
	public function getEndX() : Float {
		return x + long;
	}
	
	
	
}