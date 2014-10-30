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

		menu =  new Menu("Arial", 50, 0x00BB00, stage.stageWidth , "images/avion.png" );
		
		menu.addOption("Iniciar Partida");
		menu.addOption("Creditos");
		menu.addOption("Salir");
		
		this.addChild(menu);
		this.hijos.push(menu);
		
	}
	
	public function loop(_) {
		updateLogic(0);
	}
	
	
}