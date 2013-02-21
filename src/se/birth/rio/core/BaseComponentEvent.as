/** 
 * 	BaseComponentEvents: A constant wrapper containing BaseComponent related events
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	1
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.core
{
	import flash.events.Event;

	public class BaseComponentEvent extends Event
	{
		public static const BASE_DRAW:String = "baseDraw";
		public static const BASE_REMOVE:String = "baseRemove";
		
		public function BaseComponentEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
	}
}