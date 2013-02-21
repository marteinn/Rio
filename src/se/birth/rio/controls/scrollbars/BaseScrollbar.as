/** 
 * 	BaseScrollbar: Extend BaseScrollbar when you want to create simple scrollbars, its an abstract class.
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
	import flash.display.DisplayObjectContainer;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import se.birth.rio.core.BaseComponent;
	import se.birth.rio.core.IBaseComponent;
	
	[Event(name="scrollbarChange", type="se.birth.rio.controls.scrollbars.ScrollbarEvent")]

	public class BaseScrollbar extends BaseComponent implements IBaseComponent
	{
		protected var _fill:Number;
		protected var _position:Number = 0;
		
		public function BaseScrollbar(parent:DisplayObjectContainer=null)
		{
			super(parent);
		}
		
		public function set fill ( value:Number ) : void
		{
			_fill = value;
			invalidate ();
		}
		
		public function get fill () : Number
		{
			return _fill;
		}
		
		public function set position ( value:Number ) : void
		{
			_position = value;
			dispatchEvent( new ScrollbarEvent( ScrollbarEvent.CHANGE, _position ) );
			invalidate ();
		}
		
		public function get position () : Number
		{
			return _position;
		}

	}
}