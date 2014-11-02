package ;

import utiles.*;
import openfl.display.Bitmap;
import openfl.text.TextFormatAlign;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import openfl.Assets;
import openfl.media.Sound;
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
	
	public var font :String;
	public var size :Int;
	public var color:Int;
	public var widthh:Int;
	public var cursor_path:String = "";
	public var sound_item_path:String = "";
	public var sound_select_path:String = "";
	
	//arreglo de items (Strings) y arreglo de funciones que llama cada item
	private var     items: Array<String> = new Array<String>();
	private var functions: Array<Void->Void> = new Array<Void->Void>();
	
	//el índice actual del cursor
	private var cursor_ind: Int;
	private var cursor:Bitmap;
	private var sound_item: Sound;
	private var sound_select: Sound;	
	
	public function new() {
		super();
	}
	
	public function initialize() {
		this.y = MARGIN_Y;
		this.x = MARGIN_X;
		
		cursor = new Bitmap( Assets.getBitmapData (cursor_path));
		//cursor.scaleX = 0.5;
		//cursor.scaleY = 0.5;
		cursor.x = 0;
		
		this.addChild(cursor);
		cursor_ind = 1;
		sound_item = Assets.getSound (sound_item_path);
		sound_select = Assets.getSound (sound_select_path);
		for ( i in 0...items.length) {
			addOption( items[i] );
		}
	}
	
	public function add_item(item:String, func:Void->Void) {
		items.push(item);
		functions.push(func);
	}
	
	private function addOption(texto: String){
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
			sound_item.play();
		}
		if (InputManager.getInstance().keyPressed('W')) {
			InputManager.getInstance().release('W');
			cursor_ind--;
			sound_item.play();
		}
		if (InputManager.getInstance().keyPressed(' ')) {
			InputManager.getInstance().release(' ');
			sound_select.play();
			functions[cursor_ind-1]();
		}
		validar_ind();
		Aligner.centerY(cursor, this.getChildAt(cursor_ind) );		
	}
	
}