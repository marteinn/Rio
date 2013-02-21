/** 
 * 	StyleTextBoxEvent: For events dispatched from StyleTextBox 
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
	import flash.events.Event;

	public class StyleTextBoxEvent extends Event
	{
		protected var _text:String;
		
		public static const LINK:String = "styleTextLink";
		
		public function StyleTextBoxEvent(type:String, text:String="", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			_text = text;
		}

		//
		public function get text():String
		{
			return _text;
		}

		public function set text(v:String):void
		{
			_text = v;
		}

	}
}