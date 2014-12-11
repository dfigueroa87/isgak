package ;

/**
 * ...
 * @author Isgak Games
 */
class FondoLluvia extends FondoAnimado
{

	public function new(name:String, velocidad:Float) 
	{
		super(name, velocidad);
		bitmap3.x = 0;
		bitmap4.x = bitmap2.x;
		bitmap3.y = bitmap1.y - bitmap3.height;
		bitmap4.y = bitmap1.y - bitmap4.height;
	}
	
	override function updateLogic(time:Float){
		super.updateLogic(time);

		bitmap1.y+=time*vel;
		bitmap2.y+=time*vel;
		bitmap3.y+=time*vel;
		bitmap4.y+=time*vel;

		if(bitmap1.y>bitmap1.height){
			bitmap1.y-=bitmap1.height;
			bitmap2.y-=bitmap1.height;
			bitmap3.y-=bitmap1.height;
			bitmap4.y-=bitmap1.height;
		}
	}
	
}