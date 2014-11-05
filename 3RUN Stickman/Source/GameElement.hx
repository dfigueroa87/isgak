package;

import flash.display.Sprite;

class GameElement extends Sprite{
	
	var hijos:Array<GameElement>;
	
	public function new () {
		super();		
		hijos=new Array<GameElement>();
	}
	
	public function updateLogic(time:Float){
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
