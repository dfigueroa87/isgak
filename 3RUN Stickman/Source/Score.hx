package;

import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.text.TextField;

class  Score extends GameElement{
	
	private var SIZE : Int = 30;
	private var value : Int = 0;
	public var font :String = "Bauhaus 93";
	public var size :Int = 30;
	public var color:Int = 0xFFFFFF;
	private var text: TextField;
	private var label: TextField;
	public var LABEL:String = "";
	public var BASE:Int = 0;
	
	
	public function new() {
		super();
		var format = new TextFormat();
		format.font = font;
		format.size = SIZE;
		format.color = color;
		format.align = TextFormatAlign.CENTER;
		
		label = new TextField();
		label.defaultTextFormat = format;
		label.x = 0;
		this.addChild(label);
		
		text = new TextField ();
		text.x = 80;
		text.defaultTextFormat = format;
		//text.width = 300;
		this.addChild(text);
	}
	
	override public function updateLogic(time:Float){
		super.updateLogic(time);
		text.text = "" + value;
		label.text = LABEL;
	}
	/*
	public function setValue(val: Int) {
		this.value = val;
	}
	*/
	public function setValue(val: Float) {
		this.value = Math.round(val)-BASE;
	}
	
}