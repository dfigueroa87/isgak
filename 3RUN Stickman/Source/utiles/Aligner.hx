package utiles ;
//import utiles.GameElement;
import openfl.display.DisplayObject;
import openfl.display.Stage;

/**
 * ...
 * @author ISGAK Software
 */
class Aligner{
	
	public var stage:Stage;
	
	private static var instance:Aligner = null;
	
	public static function getInstance():Aligner{
		if(instance==null){
			instance=new Aligner();
		}
		return instance;
	}
	
	public function suscribe(stage:Stage){
		this.stage = stage;
	}
	
	public function centerY(a:DisplayObject, b:DisplayObject) {
		a.y = b.y + b.height / 2 - a.height / 2 ;
	}
	
	public function centerScreenX(a:DisplayObject) {
		a.x = stage.stageWidth / 2 - a.width / 2;
	}
	
	public function centerScreenY(a:DisplayObject) {
		a.y = stage.stageHeight / 2 - a.height / 2;
	}
	
	private function new() {
		
	}
	
}