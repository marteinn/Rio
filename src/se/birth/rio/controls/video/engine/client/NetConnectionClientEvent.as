package se.birth.rio.controls.video.engine.client
{
	import flash.events.Event;
	
	import org.osmf.net.NetClient;
	
	public class NetConnectionClientEvent extends Event
	{
		// common calls	
		public static const ON_B_W_DONE:String = "onBWDone";
		
		// and for the not-so-common
		public static const UNKNOWN_CALL:String = "unknownCall";
		
		public var name:String;
		public var arguments:Array;
		
		public function NetConnectionClientEvent(type:String, arguments:Array, name:String = "" )
		{
			super(type, bubbles, cancelable);
			
			this.name = name;
			this.arguments = arguments;
		}
	}
}