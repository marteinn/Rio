package se.birth.rio.controls.external
{
	import flash.events.ProgressEvent;
	
	public class ExternalSWFProgressEvent extends ProgressEvent
	{
		public static const LOAD_PROGRESS:String = "loadProgress";
		
		public function ExternalSWFProgressEvent(type:String, bytesLoaded:uint=0, bytesTotal:uint=0, bubbles:Boolean=false, cancelable:Boolean=false )
		{
			super(type, bubbles, cancelable, bytesLoaded, bytesTotal);
		}
	}
}