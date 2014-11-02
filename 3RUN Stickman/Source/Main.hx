package;


import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.events.Event;

import utiles.*;

//para castear uso cast(variable, TIPO);

class Main extends GameElement {
	
	private var menu : Menu;
	
	public function new () {
		
		super ();
		
		this.addEventListener(Event.ENTER_FRAME, loop);
		InputManager.getInstance().suscribe(stage);

		menu =  new Menu("Bauhaus 93", 100, 0xFFFFFF, stage.stageWidth  ,"images/cursor.png" );
		
		menu.addOption("NEW GAME");
		menu.addOption("MAX SCORES");
		menu.addOption("CREDITS");
		menu.addOption("EXIT");
		
		this.addChild(menu);
		this.hijos.push(menu);
		
	}
	
	public function loop(_) {
		updateLogic(0);
	}
	
	
}