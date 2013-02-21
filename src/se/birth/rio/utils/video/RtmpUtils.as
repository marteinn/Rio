package se.birth.rio.utils.video
{
	import nl.base42.log.Logger;

	public class RtmpUtils
	{
		public static function parseUrl( value:String ) : Vector.<String>
		{
			var parsed:Vector.<String> = new Vector.<String>();
			var urlRegExp:RegExp = /^(.*?)\/_definst_\/(.*?).flv/;
			var data:Array;
			
			data = value.match( urlRegExp );
			
			parsed[0] = data[1]+"/_definst_/";
			parsed[1] = data[2];
			
			return parsed; 
		}
	}
}