/** 
 * 	BaseScrollbar: Extend BaseSlider when you want to create simple slider, its an abstract class.
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
	import flash.display.DisplayObjectContainer;
	
	import se.birth.rio.core.BaseComponent;
	import se.birth.rio.core.IBaseComponent;
	
	[Event(name="sliderChange", type="se.birth.rio.controls.sliders.SliderEvent")]
	
	public class BaseSlider extends BaseComponent implements IBaseComponent
	{
		protected var _fill:Number = 0;
		protected var _position:Number = 0;
		
		public function BaseSlider(parent:DisplayObjectContainer=null)
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
			dispatchEvent( new SliderEvent( SliderEvent.SLIDER_CHANGE, _position ) );
			invalidate ();
		}
		
		public function get position () : Number
		{
			return _position;
		}
		
	}
}