package ;

import flash.display.Bitmap;
import openfl.Assets;
import utiles.InputManager;


class Personaje extends GameElement{
	
	var quieto:Bitmap;
	var corriendo:Animation;
	//var explotando://;
	
	public function new () {
		super();
		quieto = new Bitmap( Assets.getBitmapData ("images/Still.png"));
		this.addChild(quieto);
		this.x=50;
		this.y=300;
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
		}else{
			corriendo.visible = false;
			quieto.visible = true;
		}
	}

}
