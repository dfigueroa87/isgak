package ;

import openfl.display.Bitmap;
import openfl.Assets;

/**
 * ...
 * @author Isgak Games
 */
class MagicCircle extends GameElement {
	
	var circleBmp : Bitmap;
	
	public function new() {
		super();
		circleBmp = new Bitmap( Assets.getBitmapData ("images/magicCircle.png"));
		circleBmp.scaleX = 0.1;
		circleBmp.scaleY = 0.1;
		circleBmp.x = -(circleBmp.width / 2);
		circleBmp.y = -(circleBmp.height / 2);
		this.addChild(circleBmp);
		
	}
	
	override public function updateLogic(time:Float) {		
		super.updateLogic(time);
		if (GameElement.DIED)
			return;
		this.rotation += 30;
	}
	
}