package se.birth.rio.controls.text
{
	import flash.events.Event;
	
	public class InputFieldEvent extends Event
	{
		public static const FOCUS_IN:String = "inputFocusIn";
		public static const FOCUS_OUT:String = "inputFocusOut";
		
		private var _text:String;
		
		public function InputFieldEvent(type:String, text:String = "", bubbles:Boolean=false, cancelable:Boolean=false )
		{
			super(type, bubbles, cancelable);
			
			_text  = text;
		}
		
		
		/**
		 * Getters & Setters
		 */

		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			_text = value;
		}

	}
}