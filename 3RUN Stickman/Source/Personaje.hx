package ;

import flash.display.Bitmap;
import openfl.Assets;
import utiles.InputManager;


class Personaje extends GameElement{
	
	var quieto:Bitmap;
	var corriendo:Animation;
	var moving:Bool;
	
	public function new () {
		super();
		quieto = new Bitmap( Assets.getBitmapData ("images/Still.png"));
		this.addChild(quieto);
		this.x=50;
		this.y = 300;
		moving = false;
		
		corriendo = new Animation( Assets.getBitmapData("images/SpriteSuperRun100.png"), 7, 1);
		
		this.addChild(corriendo);
		
		hijos.push(corriendo);		
		
		corriendo.x=0;
		corriendo.y=0;

	}	
	
	override public function updateLogic(time:Float){
		super.updateLogic(time);
		
		if(InputManager.getInstance().keyPressedByCode(39)){
			quieto.visible = false;
			corriendo.visible = true;
			x++;
			moving = true;
		}else{
			corriendo.visible = false;
			quieto.visible = true;
			moving = false;
		}
	}
	
	public function isMoving():Bool {
		return moving;
	}

}
