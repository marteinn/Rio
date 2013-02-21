/** 
 * 	ImageEvents: Wrapper class for Image events
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	1
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.controls.images
{
	import flash.events.Event;

	public class ImageEvent extends Event
	{
		public static const LOAD_COMPLETE:String = "loadComplete";
		public static const LOAD_INIT:String = "loadInit";
		public static const IO_ERROR:String = "imageIOError";

		public function ImageEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
	}
}