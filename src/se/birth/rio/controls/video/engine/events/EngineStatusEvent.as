package se.birth.rio.controls.video.engine.events
{
	import flash.events.Event;
	
	public class EngineStatusEvent extends Event
	{
		public static const STATUS:String = "status";	
		
		public var status:String = "";
		
		public function EngineStatusEvent(type:String, status:String = "", bubbles:Boolean=false, cancelable:Boolean=false )
		{
			super(type, bubbles, cancelable);
			
			this.status = status;
		}
	}
}