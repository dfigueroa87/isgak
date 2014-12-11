package;

import openfl.display.Bitmap;
import openfl.Assets;

class FondoAnimado extends GameElement {

	public var vel:Float;
	public var bitmap1:Bitmap;
	public var bitmap2:Bitmap;
	public var bitmap3:Bitmap;
	public var bitmap4:Bitmap;

	public function new(name:String, velocidad:Float){
		super();
		bitmap1=new Bitmap(Assets.getBitmapData(name));
		bitmap2=new Bitmap(Assets.getBitmapData(name));
		bitmap3=new Bitmap(Assets.getBitmapData(name));
		bitmap4=new Bitmap(Assets.getBitmapData(name));

		addChild(bitmap1);
		addChild(bitmap2);
		addChild(bitmap3);
		addChild(bitmap4);

		bitmap1.x=0;
		bitmap2.x=bitmap1.width;
		bitmap3.x=bitmap1.width*2;
		bitmap4.x=bitmap1.width*3;

		vel=velocidad;
	}

	override function updateLogic(time:Float){
		super.updateLogic(time);

		bitmap1.x-=time*vel;
		bitmap2.x-=time*vel;
		bitmap3.x-=time*vel;
		bitmap4.x-=time*vel;

		if(bitmap1.x<bitmap1.width*-1){
			bitmap1.x+=bitmap1.width;
			bitmap2.x+=bitmap1.width;
			bitmap3.x+=bitmap1.width;
			bitmap4.x+=bitmap1.width;
		}
	}
}