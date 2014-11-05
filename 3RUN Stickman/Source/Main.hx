package;


import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.events.Event;
import flash.system.System;
import openfl.Assets;
import openfl.text.TextFormatAlign;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;

import utiles.*;

//para castear uso cast(variable, TIPO);

class Main extends GameElement {
	
	private var menu : Menu;
	private var game : Game;
	private var title : Bitmap;
	
	public function new () {
		super ();
		this.addEventListener(Event.ENTER_FRAME, loop);
		InputManager.getInstance().suscribe(stage);
		
		//TITULO
		Aligner.stage = stage;
		
		title = new Bitmap( Assets.getBitmapData ("images/title.png"));
		Aligner.centerScreenX(title);
		//title.x = 25;
		title.y = 25;
		this.addChild(title);
		
		//MENU
		menu =  new Menu( );
		menu.font = "Bauhaus 93";
		menu.size = 75;
		menu.MARGIN_OPTIONS_X = 0;
		menu.MARGIN_OPTIONS_Y = 0.2;
		menu.color = 0xFFFFFF;
		menu.widthh = stage.stageWidth;
		menu.cursor_path = "images/cursor.png";
		menu.sound_item_path = "sounds/punch1.ogg";
		menu.sound_select_path = "sounds/menu_select.ogg";
		menu.add_item("NEW GAME",newGame);
		menu.add_item("MAX SCORES",maxScores);
		menu.add_item("CREDITS",credits);
		menu.add_item("EXIT",exit);
		
		menu.initialize();
		
		this.addChild(menu);
		menu.x = 50;
		menu.y = 175;
		this.hijos.push(menu);
		
		//NOTA COPYRIGHT
		var format = new TextFormat();
		format.font = "Arial Black";
		format.size = 35;
		format.color = 0xFFFFFF;
		format.align = TextFormatAlign.CENTER;
		
		var copy_note = new TextField ();
		copy_note.defaultTextFormat = format;
		copy_note.text = "©2014  ISGAK Software".substring(1,22);
		copy_note.width = stage.stageWidth;
		copy_note.y = 540;
		this.addChild(copy_note);
	}
	
	public function loop(_) {
		updateLogic(0);
	}

	
	public function newGame() {
		game = new Game();
		this.removeChild(menu);
		this.hijos.remove(menu);
		this.addChild(game);
		this.hijos.push(game);

	}
	
	public function maxScores() {
		trace("max scores");
	}
	public function credits() {
		trace("credits");
	}
	public function exit() {
		System.exit(0);
	}
	
}