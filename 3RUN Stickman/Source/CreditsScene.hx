package ;

import utiles.Aligner;
import utiles.Persistence;
import openfl.text.TextFormatAlign;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import haxe.Timer;

/**
 * ...
 * @author Isgak Games
 */
class CreditsScene extends Scene {
	
	private var format : TextFormat;
	private var credits : TextField;
	
	public function new() {
		super();
		format = new TextFormat();
		format.font = "Bauhaus 93";
		format.size = 40;
		format.color = 0xFFFFFF;
		format.align = TextFormatAlign.CENTER;
		
		credits = new TextField ();
		credits.width = Aligner.getInstance().stage.stageWidth;
		credits.height = 150;
		credits.defaultTextFormat = format;
		credits.text = "ISGAK Games: \n Lucas De Lio \n David Figueroa";
		Aligner.getInstance().centerScreenX(credits);
		Aligner.getInstance().centerScreenY(credits);
		this.addChild(credits);
	}
	
	override public function show(){
		Timer.delay(goToMenu, 5000);
	}
	
	private function goToMenu(){
		Main.getInstance().setScene('menu');
	}
	
}