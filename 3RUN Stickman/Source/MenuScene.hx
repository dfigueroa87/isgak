package ;

import utiles.*;
import openfl.display.Bitmap;
import openfl.text.TextFormatAlign;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import openfl.Assets;
import openfl.media.Sound;
import utiles.Aligner;
import flash.system.System;

/**
 * ...
 * @author ISGAK Software
 */
class MenuScene extends Scene {
	//private var MARGIN_X = 50;
	//private var MARGIN_Y = 50;
	
	public var MARGIN_OPTIONS_X :Int;
	public var MARGIN_OPTIONS_Y :Float;
	public var font :String;
	public var size :Int;
	public var color:Int;
	public var widthh:Int;
	public var cursor_path:String = "";
	public var sound_item_path:String = "";
	public var sound_select_path:String = "";
	
	//arreglo de items (Strings) y arreglo de funciones que llama cada item
	private var items: Array<String> = new Array<String>();
	private var functions: Array < Void->Void > = new Array < Void->Void > ();
	
	private var options : Array<TextField> = new Array<TextField>();
	
	//el índice actual del cursor
	private var cursor_ind: Int;
	private var cursor:Bitmap;
	private var sound_item: Sound;
	private var sound_select: Sound;
	
	private var title : Bitmap;
	private var copy_note : TextField;
	
	public function new() {
		super();
		
		//TITULO		
		title = new Bitmap( Assets.getBitmapData ("images/title.png"));
		Aligner.getInstance().centerScreenX(title);
		//title.x = 25;
		title.y = 25;
		this.addChild(title);
		
		//MENU
		this.font = "Bauhaus 93";
		this.size = 75;
		this.MARGIN_OPTIONS_X = 0;
		this.MARGIN_OPTIONS_Y = 0.2;
		this.color = 0xFFFFFF;
		this.widthh = Aligner.getInstance().stage.stageWidth;
		this.cursor_path = "images/cursor.png";
		this.sound_item_path = "sounds/punch1.ogg";
		this.sound_select_path = "sounds/menu_select.ogg";
		this.add_item("NEW GAME",newGame);
		this.add_item("MAX SCORES",maxScores);
		this.add_item("CREDITS",credits);
		this.add_item("EXIT",exit);
		
		this.initialize();

		//NOTA COPYRIGHT
		var format = new TextFormat();
		format.font = "Arial Black";
		format.size = 35;
		format.color = 0xFFFFFF;
		format.align = TextFormatAlign.CENTER;
		
		copy_note = new TextField ();
		copy_note.defaultTextFormat = format;
		copy_note.text = "©2014  ISGAK Games".substring(1,22);
		copy_note.width = Aligner.getInstance().stage.stageWidth;
		copy_note.y = 540;
		this.addChild(copy_note);
		
	}
	
	public function initialize() {
		//this.y = MARGIN_Y;
		//this.x = MARGIN_X;
		
		cursor = new Bitmap( Assets.getBitmapData (cursor_path));
		//cursor.scaleX = 0.5;
		//cursor.scaleY = 0.5;
		cursor.x = 50;
		
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
		opcion.y = 80 + (this.numChildren-1) * size*(1+ MARGIN_OPTIONS_Y);
		this.addChild(opcion);
		
		options.push(opcion);
		
		opcion.x = MARGIN_OPTIONS_X;
		
		Aligner.getInstance().centerY(cursor, options[0] );
		
	}
	
	private function validar_ind() {
	//veo si me pase de rango
		if (cursor_ind > items.length)
			cursor_ind = 1;
		if (cursor_ind <1 )
			cursor_ind = items.length;
	}
	
	override public function updateLogic(time:Float) {
		if (InputManager.getInstance().keyPressedByCode(40)) {
			InputManager.getInstance().releaseByCode(40);
			cursor_ind++;
			sound_item.play();
		}
		if (InputManager.getInstance().keyPressedByCode(38)) {
			InputManager.getInstance().releaseByCode(38);
			cursor_ind--;
			sound_item.play();
		}
		if (InputManager.getInstance().keyPressed(' ')) {
			InputManager.getInstance().release(' ');
			sound_select.play();
			functions[cursor_ind-1]();
		}
		validar_ind();
		Aligner.getInstance().centerY(cursor, options[cursor_ind-1] );		
	}
	
	public function newGame() {
		Main.getInstance().restartGame();
		Main.getInstance().setScene('game');
	}
	
	public function maxScores() {
		Main.getInstance().setScene('maxscore');
	}
	public function credits() {
		trace("credits");
	}
	public function exit() {
		System.exit(0);
	}
	
}