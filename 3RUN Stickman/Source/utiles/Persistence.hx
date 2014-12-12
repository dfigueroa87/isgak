package utiles;

class Persistence {

	private static var data:openfl.net.SharedObject=null;

	public static function setScore(score:Int){
		if(getScore()>=score) return;
		data.data.score=score;
		try{
			data.flush();
		}catch(e:Dynamic){
			trace("ERROR AL PERSISTIR PUNTAJE: "+e);
		}
	}

	public static function getScore():Int{
		if(data==null) data=openfl.net.SharedObject.getLocal('storage');
		if(data.data==null) return 0;
		if(data.data.score==null) return 0;
		return data.data.score;
	}

}