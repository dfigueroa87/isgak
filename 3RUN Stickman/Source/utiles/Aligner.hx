package utiles ;
//import utiles.GameElement;
import openfl.display.DisplayObject;
import openfl.display.Stage;

/**
 * ...
 * @author ISGAK Software
 */
class Aligner{
	
	public static var stage:Stage;
	
	public static function centerY(a:DisplayObject, b:DisplayObject) {
		a.y = b.y + b.height / 2 - a.height / 2 ;
	}
	
	public static function centerScreenX(a:DisplayObject) {
		a.x = stage.stageWidth / 2 - a.width / 2;
	}
	
	public static function centerScreenY(a:DisplayObject) {
		a.y = stage.stageHeight / 2 - a.height / 2;
	}
	
	public function new() {
		
	}
	
}