package ;

import flash.display.Bitmap;
import openfl.Assets;
import utiles.*;
import openfl.geom.Point;
import openfl.media.Sound;

class Personaje extends GameElement{
	
	private var quieto:Bitmap;
	private var corriendo:Animation;
	private var moving:Bool;
	private var movingFast:Bool;
	private var fatigue:Int;
	
	private var scene:GameScene;
	
	private var acceleration:Float;
	public var velocity:Point;
	private var isOnGround:Bool;
	
	private var sound_falling_path = "sounds/falling.ogg";
	private var sound_jump_path = "sounds/jump.ogg";
	private var sound_jump: Sound;
	private var sound_falling: Sound;
	
	public function new (scene:GameScene) {
		super();
		this.scene = scene;
		
		sound_jump = Assets.getSound(sound_jump_path);
		sound_falling = Assets.getSound(sound_falling_path);
		
		quieto = new Bitmap( Assets.getBitmapData ("images/Still.png"));
		this.addChild(quieto);
		
		Aligner.getInstance().centerScreenX(this);
		Aligner.getInstance().centerScreenY(this);
		
		moving = false;
		movingFast = false;
		fatigue = 0;
		
		acceleration = 0.9;
		velocity = new Point(0, 0);
		isOnGround = false;
		
		corriendo = new Animation( Assets.getBitmapData("images/SpriteSuperRun100.png"), 7, 1);
		
		this.addChild(corriendo);
		
		hijos.push(corriendo);	
		
		corriendo.x = 0;
		corriendo.y = 0;

	}	
	
	override public function updateLogic(time:Float){
		super.updateLogic(time);

		// Gravity
        velocity.y += acceleration;
         
        // Movement
        if (isOnGround && InputManager.getInstance().keyPressedByCode(38)) {
            this.jump();
        }
		this.run();
        if (!movingFast && InputManager.getInstance().keyPressedByCode(39) && fatigue<1) {
			this.runFaster();
        }
        
		if (!isOnGround) {
			this.y += velocity.y;
		}
		
		// Verify if it is on the ground
		for(platform in scene.platforms){
			if(GameScene.detectarColision(this,platform)){
				velocity.y = 0;
				isOnGround = true;
			}       			
		}
		
        //this.x += velocity.x;
        
        // Final vertical velocity check
        if (velocity.y != 0) {
            isOnGround = false;
        }
		
	}
	
	private function run() {
		if (velocity.x > 7) {
			velocity.x --;
		} else {
			velocity.x = 7;
			movingFast = false;
			fatigue--;
		}
		quieto.visible = false;
		corriendo.visible = true;
		moving = true;
	}
	
	private function runFaster() {
		velocity.x += 10;
		quieto.visible = false;
		corriendo.visible = true;
		movingFast = true;
		fatigue = 20;
	}
	
	private function jump()	{
		isOnGround = false;
        velocity.y = -14;
		sound_jump.play();
	}
	
	private function stop() {
		velocity.x = 0;
		corriendo.visible = false;
		quieto.visible = true;
		moving = false;
	}
	
	public function die() {
		// TODO
		sound_falling.play();
	}
	
	public function isMoving():Bool {
		return moving;
	}
	
	public function getVelocity():Float{
		return velocity.x;
	}

}
