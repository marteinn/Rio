package se.birth.rio.controls.text
{
	import flash.events.KeyboardEvent;
	
	public class InputFieldKeyEvent extends KeyboardEvent
	{
		public static const KEY_DOWN:String = "inputKeyDown";
		
		public function InputFieldKeyEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false, charCode:uint=0
										   , keyCode:uint=0, keyLocation:uint=0, ctrlKey:Boolean=false, altKey:Boolean=false
											 , shiftKey:Boolean=false)
		{
			super(type, bubbles, cancelable, charCode, keyCode, keyLocation, ctrlKey, altKey, shiftKey);
		}
	}
}