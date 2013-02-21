package se.birth.rio.controls.images
{
	import flash.events.ProgressEvent;
	
	public class ImageProgressEvent extends ProgressEvent
	{
		public static const LOAD_PROGRESS:String = "loadProgress";
		
		public function ImageProgressEvent(type:String, bytesLoaded:uint=0, bytesTotal:uint=0, bubbles:Boolean=false, cancelable:Boolean=false )
		{
			super(type, bubbles, cancelable, bytesLoaded, bytesTotal);
		}
	}
}