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
	
	private var SPEED_FAST = 15;
	private var SPEED_NORMAL = 8;
	private var SPEED_SLOW = 6;
	private var JUMP_STRENGHT = 17;
	
	private var sound_falling_path = "sounds/falling.ogg";
	private var sound_jump_path = "sounds/jump.ogg";
	private var sound_jump: Sound;
	private var sound_falling: Sound;
	
	public function new (scene:GameScene) {
		super();
		this.scene = scene;
		this.estado = 1;
		
		sound_jump = Assets.getSound(sound_jump_path);
		sound_falling = Assets.getSound(sound_falling_path);
		
		quieto = new Bitmap( Assets.getBitmapData ("images/Still.png"));
		this.addChild(quieto);
		
		Aligner.getInstance().centerScreenX(this);
		Aligner.getInstance().centerScreenY(this);
		
		y -= 100;
		
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
		if (estado == 0) return;
		
		super.updateLogic(time);

		// Gravity
        velocity.y += acceleration;
         
        // Movement
        if (isOnGround && InputManager.getInstance().keyPressedByCode(38)) {
            this.jump();
        }
		this.run();
		//run slow
		if (InputManager.getInstance().keyPressedByCode(37)) {
			this.runSlow();
        }
        if (!movingFast && InputManager.getInstance().keyPressedByCode(39) && fatigue<1) {
			this.runFaster();
        }
        
		if (!isOnGround) {
			this.y += velocity.y;
		}
		
		// Verify if it is on the ground
		for(platform in scene.platforms){
			if (GameScene.detectarColisionPersonaje(this, platform)) {
				y = platform.y - height;
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
		if (velocity.x > SPEED_NORMAL) {
			velocity.x --;
		} else {
			velocity.x = SPEED_NORMAL;
			movingFast = false;
			fatigue--;
		}
		quieto.visible = false;
		corriendo.visible = true;
		moving = true;
	}
	
	private function runSlow() {
		velocity.x = SPEED_SLOW;
	}
	
	private function runFaster() {
		velocity.x += SPEED_FAST;
		quieto.visible = false;
		corriendo.visible = true;
		movingFast = true;
		fatigue = 20;
	}
	
	private function jump()	{
		isOnGround = false;
        velocity.y = -JUMP_STRENGHT;
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
		this.estado = 0;
		sound_falling.play();
	}
	
	public function isMoving():Bool {
		return moving;
	}
	
	public function getVelocity():Float{
		return velocity.x;
	}

}
