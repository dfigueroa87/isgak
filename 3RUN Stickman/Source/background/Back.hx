package background;

import utiles.GameElement;
import openfl.display.Bitmap;

/**
La clase representa un fondo repetitivo que se desplaza y no termina nunca
esta compuesta por una o más sprites consecutivos repetidos en un patrón
 */
class Back extends GameElement{

	private var sprites = new Array<Bitmap>();
	public function new() {
		super();
		
	}
	
}