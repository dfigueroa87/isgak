package;

import flash.display.Sprite;

class GameElement extends Sprite{
	
	var hijos:Array<GameElement>;
	var estado:Int;
	public static var DIED :Bool = false;
	
	public function new () {
		super();
		estado = 0;
		hijos = new Array<GameElement>();
	}
	
	public function updateLogic(time:Float) {
		if (DIED)
			return;
		var hijo:GameElement;
		for(hijo in hijos){
			hijo.updateLogic(time);
		}
	}
	
	public function removeAllChilds() {
		while(this.numChildren >0) {
			this.removeChild(this.getChildAt(this.numChildren-1));
		}
	}
}
