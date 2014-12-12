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
class MaxScoreScene extends Scene
{

	private var format : TextFormat;
	private var maxScore : TextField;
	
	public function new() 
	{
		super();
		format = new TextFormat();
		format.font = "Bauhaus 93";
		format.size = 40;
		format.color = 0xFFFFFF;
		format.align = TextFormatAlign.CENTER;
		
		maxScore = new TextField ();
		maxScore.width = Aligner.getInstance().stage.stageWidth;
		maxScore.defaultTextFormat = format;
		Aligner.getInstance().centerScreenX(maxScore);
		Aligner.getInstance().centerScreenY(maxScore);
		this.addChild(maxScore);
	}
	
	override public function show(){
		maxScore.text = "THE Max Score: " + Persistence.getScore();
		Timer.delay(goToMenu, 5000);
	}
	
	private function goToMenu(){
		Main.getInstance().setScene('menu');
	}
}