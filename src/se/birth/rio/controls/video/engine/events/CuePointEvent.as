package se.birth.rio.controls.video.engine.events
{
	import flash.events.Event;
	
	public class CuePointEvent extends Event
	{
		public static const CUE_POINT:String = "cuePoint";
		
		public var name:String;
		public var time:Number;
		public var cueType:String;
		
		public function CuePointEvent(type:String, name:String, time:Number, cueType:String )
		{
			super(type, bubbles, cancelable);
			
			this.name = name;
			this.time = time;
			this.cueType = cueType;
		}
	}
}