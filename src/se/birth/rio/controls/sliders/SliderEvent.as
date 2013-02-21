/** 
 * 	SliderEvent: Use this event with dispatching events from a slider component
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	1
 * 
 *	Copyright 2010, Birth Art & Development AB
 */

package se.birth.rio.controls.sliders
{
	import flash.events.Event;
	
	public class SliderEvent extends Event
	{
		public static const SLIDER_CHANGE:String = "sliderChange";
		
		private var _position:Number;
		
		public function SliderEvent(type:String, position:Number = 0, bubbles:Boolean=false, cancelable:Boolean=false )
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