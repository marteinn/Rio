/** 
 * 	ButtonEvents: Wrapper class for button events.
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	1
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.controls.buttons
{
	import flash.events.Event;

	public class ButtonEvent extends Event
	{
		public static const BUTTON_CLICK:String = "buttonClick";
		public static const BUTTON_UP:String = "buttonUp";
		public static const BUTTON_DOWN:String = "buttonDown";
		public static const BUTTON_OVER:String = "buttonOver";
		public static const BUTTON_OUT:String = "buttonOut";
		
		private var _state:*;
		
		public function ButtonEvent(type:String, state:* = null, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
			
			_state = state;
		}
		
		
		
		/**
		 * Getters & Setters
		 */

		public function get state():*
		{
			return _state;
		}

		public function set state(value:*):void
		{
			_state = value;
		}

	}
}