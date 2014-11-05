package;


import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.events.Event;
import flash.system.System;

import utiles.*;

//para castear uso cast(variable, TIPO);

class Main extends GameElement {
	
	private var menu : Menu;
	private var game : Game;
	
	public function new () {
		
		super ();
		
		this.addEventListener(Event.ENTER_FRAME, loop);
		InputManager.getInstance().suscribe(stage);

		menu =  new Menu( );
		menu.font = "Bauhaus 93";
		menu.size = 100;
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
		this.hijos.push(menu);
		
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