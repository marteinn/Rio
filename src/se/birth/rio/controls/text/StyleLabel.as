/** 
 * 	StyleLabel: For text based on one line with a styleSheet. (Extends Label) 
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	1
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.controls.text
{
	import flash.display.DisplayObjectContainer;
	import flash.text.StyleSheet;
	
	import se.birth.rio.core.IBaseComponent;

	public class StyleLabel extends Label implements IBaseComponent
	{
		protected var _styleSheet:StyleSheet;
		
		public function StyleLabel(parent:DisplayObjectContainer=null)
		{
			super(parent);
		}
		
		override protected function applyText () : void
		{
			field.htmlText = _text;
		}
		
		override protected function render () : void
		{
			if( _styleSheet == null )
				return;
			
			field.styleSheet = _styleSheet;
		}
		
		/**
		 * 
		 * properties
		 * 
		 */		
		
		public function set styleSheet( value:StyleSheet ) : void
		{
			_styleSheet = value;
			invalidate ();
		}
		
		public function get styleSheet () : StyleSheet
		{
			return _styleSheet;
		}
	}
}