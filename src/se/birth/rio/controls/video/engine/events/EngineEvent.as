package se.birth.rio.controls.video.engine.events
{
	import flash.events.Event;
	
	public class EngineEvent extends Event
	{
		public static const START:String = "start";
		public static const BUFFERT_START:String = "buffertStart";
		public static const BUFFERT_STOP:String = "buffertStop";
		public static const TIME_UPDATE:String = "timeUpdate";
		
		public function EngineEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}