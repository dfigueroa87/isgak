package ;
//import utiles.GameElement;
import openfl.display.DisplayObject;

/**
 * ...
 * @author ISGAK Software
 */
class Aligner{
	
	
	public static function centerY(a:DisplayObject, b:DisplayObject) {
		a.y = b.y + b.height / 2 - a.height / 2 ;
	}
	
	public function new() {
		
	}
	
}