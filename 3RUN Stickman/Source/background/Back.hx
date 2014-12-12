package background;

import GameElement;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import utiles.*;

/**
La clase representa un fondo repetitivo que se desplaza y no termina nunca
esta compuesta por una o más sprites consecutivos repetidos en un patrón
 */
class Back extends GameElement{
	
	public var collapse_x : Int = 0;
	public var bmp : Bitmap;
	
	public function new() {
		super();
	}
	
	public function fill(bitmap_data:BitmapData ) {
		var count = Math.floor(Aligner.getInstance().stage.stageWidth / bitmap_data.width )+2;
		for (i in 0...count) {
			bmp= new Bitmap(bitmap_data);
			this.addChild( bmp );
			bmp.x = i * (bmp.width - collapse_x);
			trace("se agrega bitmap");
		}
	}
	
	override public function updateLogic(time:Float) {
		super.updateLogic(time);
		this.x-=1;
	}
		if ( -x > bmp.width)
			x = 0;
	
}