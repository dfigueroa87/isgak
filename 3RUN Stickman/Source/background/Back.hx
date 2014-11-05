package background;

import GameElement;
import openfl.display.Bitmap;
import openfl.display.BitmapData;

/**
La clase representa un fondo repetitivo que se desplaza y no termina nunca
esta compuesta por una o más sprites consecutivos repetidos en un patrón
 */
class Back extends GameElement{
	
	public var collapse_x : Int = 0;
	
	public function new() {
		super();
	}
	
	public function fill(bitmap_data:BitmapData ) {
		var count = Math.floor(Aligner.stage.stageWidth / bitmap_data.width )+2;
		for (i in 0...count) {
			var bmp = new Bitmap(bitmap_data);
			this.addChild( bmp );
			bmp.x = i * (bmp.width - collapse_x);
			trace("se agrega bitmap");
		}
		
	}
	
}