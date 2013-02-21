package se.birth.rio.controls.external
{
	import flash.events.Event;

	public class ExternalSWFEvent extends Event
	{
		public static const LOAD_COMPLETE:String = "loadComplete";
		public static const LOAD_INIT:String = "loadInit";
		public static const IO_ERROR:String = "externalSWFIOError";
		
		public function ExternalSWFEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
	}
}