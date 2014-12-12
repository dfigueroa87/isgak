package;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.Assets;

import utiles.*;

//para castear uso cast(variable, TIPO);

class Main extends SceneManager {
	
	private static var instance:Main = null;
	public static function getInstance():Main {
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
		sceneMap.set('maxscore', new MaxScoreScene());
		
		setScene('menu');
		
		stage.addEventListener(openfl.events.Event.RESIZE,onResize);
	}
	
	public function loop(_) {
		updateLogic(0);
	}
	
	public function restartGame() {
		sceneMap.set('game', new GameScene());
	}
	
	public function restartMaxScore() {
		sceneMap.set('maxscore', new MaxScoreScene());
	}
	
	public function onResize(_){
		var s:Float=Math.min(stage.stageWidth/800,stage.stageHeight/600);
		this.scaleX=this.scaleY=s;
		this.x=(stage.stageWidth-800*s)/2;
		this.y=(stage.stageHeight-600*s)/2;
	}
	
}