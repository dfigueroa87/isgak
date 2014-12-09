package;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.Assets;

import utiles.*;

//para castear uso cast(variable, TIPO);

class Main extends SceneManager {
	
	private static var instance:SceneManager = null;
	public static function getInstance():SceneManager {
		return instance;
	}
	
	public function new () {
		super();
		instance=this;
		stage.addEventListener(Event.ENTER_FRAME, loop);
		InputManager.getInstance().suscribe(stage);
		Aligner.getInstance().suscribe(stage);
		
		sceneMap.set('game', new GameScene());
		sceneMap.set('menu', new MenuScene());
		
		setScene('menu');
	}
	
	public function loop(_) {
		updateLogic(0);
	}
	
	public function onResize(_){
		var s:Float=Math.min(stage.stageWidth/800,stage.stageHeight/600);
		this.scaleX=this.scaleY=s;
		this.x=(stage.stageWidth-800*s)/2;
		this.y=(stage.stageHeight-600*s)/2;
	}
	
}