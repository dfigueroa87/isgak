package ;

import utiles.*;
import openfl.display.Bitmap;
import openfl.text.TextFormatAlign;
import utiles.GameElement;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import openfl.Assets;
/**
 * ...
 * @author ISGAK Software
 */
class Menu extends GameElement
{
	private var MARGIN_X = 50;
	private var MARGIN_Y = 50;
	private var MARGIN_OPTIONS_X = 10;
	private var MARGIN_OPTIONS_Y = 0.3;
	
	private var font :String;
	private var size :Int;
	private var color:Int;
	private var widthh:Int;
	private var cursor:Bitmap;
	//el índice actual del cursor
	private var cursor_ind: Int;
	
	public function new(font:String, size:Int,color:Int,widthh:Int,cursor_path:String) {
		super();
		
		this.y = MARGIN_Y;
		this.x = MARGIN_X;
		
		this.font = font;
		this.size = size;
		this.color = color;
		this.widthh = widthh;
		
		cursor = new Bitmap( Assets.getBitmapData (cursor_path));
		//cursor.scaleX = 0.5;
		//cursor.scaleY = 0.5;
		cursor.x = 0;
		
		this.addChild(cursor);
		cursor_ind = 1;
	}
	
	public function addOption(texto: String){
		var format = new TextFormat();
		format.font = font;
		format.size = size;
		format.color = color;
		format.align = TextFormatAlign.CENTER;
		
		var opcion = new TextField ();
		opcion.defaultTextFormat = format;
		opcion.text = texto;
		opcion.width = widthh;
		opcion.y = (this.numChildren-1) * size*(1+ MARGIN_OPTIONS_Y);
		this.addChild(opcion);
		
		opcion.x = MARGIN_OPTIONS_X;
		
		Aligner.centerY(cursor, this.getChildAt(1) );
		
	}
	
	private function validar_ind() {
	//veo si me pase de rango
		if (cursor_ind >= this.numChildren)
			cursor_ind = 1;
		if (cursor_ind <1 )
			cursor_ind = this.numChildren-1;
	}
	
	override public function updateLogic(time:Float) {
		if (InputManager.getInstance().keyPressed('S')) {
			InputManager.getInstance().release('S');
			cursor_ind++;
		}
		if (InputManager.getInstance().keyPressed('W')) {
			InputManager.getInstance().release('W');
			cursor_ind--;
		}
		validar_ind();
		Aligner.centerY(cursor, this.getChildAt(cursor_ind) );		
	}
	
}