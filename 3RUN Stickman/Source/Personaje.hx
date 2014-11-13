package ;

import flash.display.Bitmap;
import openfl.Assets;
import utiles.InputManager;
import openfl.geom.Point;


class Personaje extends GameElement{
	
	var quieto:Bitmap;
	var corriendo:Animation;
	private var moving:Bool;
	
	private var acceleration:Float;
	private var velocity:Point;
	private var isOnGround:Bool;
	
	private var characterSize:Int;
	
	public function new () {
		super();
		quieto = new Bitmap( Assets.getBitmapData ("images/Still.png"));
		this.addChild(quieto);
		this.x=50;
		this.y = 300;
		moving = false;
		
		acceleration = 0.9;
		velocity = new Point(0, 0);
		isOnGround = true;
		characterSize = cast(quieto.height, Int);
		
		corriendo = new Animation( Assets.getBitmapData("images/SpriteSuperRun100.png"), 7, 1);
		
		this.addChild(corriendo);
		
		hijos.push(corriendo);		
		
		corriendo.x=0;
		corriendo.y=0;

	}	
	
	override public function updateLogic(time:Float){
		super.updateLogic(time);
		
		// Gravity
        velocity.y += acceleration;
         
        // Movement
        if (isOnGround && InputManager.getInstance().keyPressedByCode(38)) {
            isOnGround = false;
            velocity.y = -14;
        }
        if (InputManager.getInstance().keyPressedByCode(39)) {
            velocity.x = 7;
			quieto.visible = false;
			corriendo.visible = true;
			moving = true;
        }else if (InputManager.getInstance().keyPressedByCode(37)) {
            velocity.x = -7;
        }else {
            velocity.x = 0;
			corriendo.visible = false;
			quieto.visible = true;
			moving = false;
        }
        // Player coordinates on the grid
        var tileCoords:Point = new Point(0, 0);
        var approximateCoords:Point = new Point();
        
        this.y += velocity.y;
        checkBottomCollision(tileCoords, approximateCoords);
        
        this.x += velocity.x;
        
        // Final vertical velocity check
        if (velocity.y != 0) {
            isOnGround = false;
        }
		
	}
	
	private function checkBottomCollision(tileCoords:Point, approximateCoords:Point):Void {
        // Bottom collision
        if (velocity.y >= 0) {
            
            if (this.y > 400) {
                this.y = 400;
                velocity.y = 0;
                isOnGround = true;
            }
            

        }
    }
	
	public function isMoving():Bool {
		return moving;
	}

}
