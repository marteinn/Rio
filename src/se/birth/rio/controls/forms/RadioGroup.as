package se.birth.rio.controls.forms
{
	import flash.events.Event;
	
	import nl.base42.log.Logger;
	
	import se.birth.rio.controls.buttons.ButtonEvent;
	import se.birth.rio.core.BaseComponent;

	public class RadioGroup implements IFormElement
	{
		protected var buttons:Vector.<IRadioButton>;
		protected var _value:* = null;
		protected var _name:String;
		
		public function RadioGroup( name:String )
		{
			_name = name;
			
			buttons = new Vector.<IRadioButton>();
		}
		
		public function add( button:IRadioButton ) : void
		{
			registerButton( button );
		}
		
		public function remove( button:IRadioButton ) : void
		{
			unregisterButton( button );
		}
		
		public function removeAll () : void
		{
			var i:int = buttons.length;
			
			while( i-- )
				unregisterButton( buttons[i] );
		}
		
		protected function getButtonPosition ( button:IRadioButton ) : int
		{
			var i:int = buttons.length;
			
			while( i-- )
				if( buttons[i] == button )
					return i;
			
			return -1;
		}
		
		protected function registerButton ( button:IRadioButton ) : void
		{
			var buttonId:int;
			var baseButton:BaseComponent;
			
			buttonId = getButtonPosition( button );
			
			if( buttonId != -1 )
			{
				throw new Error("Button has already been added");
				return;
			}
			
			buttons.push( button );
			
			baseButton = button as BaseComponent;
			baseButton.addEventListener( ButtonEvent.CLICK, button_clickHandler, false, 0, true );
		}
		
		protected function unregisterButton( button:IRadioButton ) : void
		{
			var buttonId:int;
			
			buttonId = getButtonPosition( button );
			if( buttonId == -1 )
				return;
			
			buttons.splice( buttonId, 1 ); 
		}
		
		protected function setValue ( value:* ) : void
		{
			_value = value;
			toggleButtons ();
		}
		
		protected function toggleButtons () : void
		{
			var i:int = buttons.length;
			
			while( i-- )
			{
				if( buttons[i].value == _value && !buttons[i].selected )
					buttons[i].selected = true;
				else if( buttons[i].value != _value && buttons[i].selected )
					buttons[i].selected = false;
			}
		}
		
		
		/**
		 * Handlers
		 */
		
		protected function button_clickHandler ( event:Event ) : void
		{
			var button:IRadioButton = event.target as IRadioButton;

			setValue( button.value ); 
			
		}
		
		/**
		 * Getters & Setters
		 */
		
		public function set value ( value:* ) : void
		{
			setValue( value ); 
		}
		
		public function get value () : *
		{
			return _value;
		}
		
		
		
		public function set name ( value:String ) : void
		{
			_name = value;
		}
		
		public function get name ( ) : String
		{
			return _name;
		}
		
	}
}