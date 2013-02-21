/** 
 * 	MenuEvent: 	Use this event when dispatching events from menu event.
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	1
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.controls.menus
{
	import flash.events.Event;
	
	public class MenuEvent extends Event
	{
		public static const MENU_CLICK:String = "menuClick";
		public static const MENU_ROLL_OVER:String = "menuRollOver";
		public static const MENU_ROLL_OUT:String = "menuRollOut";
		public static const MENU_CHANGE:String = "menuChange";
		
		private var _state:*;
		
		public function MenuEvent(type:String, state:* = null, bubbles:Boolean=false, cancelable:Boolean=false )
		{
			super(type, bubbles, cancelable);
			
			_state = state;
		}

		public function get state():*
		{
			return _state;
		}

		public function set state(v:*):void
		{
			_state = v;
		}

	}
}