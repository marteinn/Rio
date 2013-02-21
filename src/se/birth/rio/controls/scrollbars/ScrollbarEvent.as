/** 
 * 	ScrollbarEvent: Use this event with dispatching events from a rio-scrollbar.
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	1
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.controls.scrollbars
{
	import flash.events.Event;
	
	public class ScrollbarEvent extends Event
	{
		private var _position:Number;
		
		public static const CHANGE:String = "scrollbarChange";
		
		public function ScrollbarEvent(type:String, position:Number = 0, bubbles:Boolean=false, cancelable:Boolean=false )
		{
			super(type, bubbles, cancelable);
			
			_position = position;
		}

		public function get position():*
		{
			return _position;
		}

		public function set position(value:Number):void
		{
			_position = value;
		}

	}
}