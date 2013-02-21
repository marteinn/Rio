/** 
 * 	InputField: Extends Label and provides input possibilities. 
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	2
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.controls.text
{
	import flash.display.DisplayObjectContainer;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextFieldType;
	
	import se.birth.rio.core.IBaseComponent;
	
	[Event(name="inputKeyDown", type="se.birth.rio.controls.text.InputKeyEvent")]
	[Event(name="inputFocusIn", type="se.birth.rio.controls.text.InputEvent")]
	[Event(name="inputFocusOut", type="se.birth.rio.controls.text.InputEvent")]

	public class InputField extends Label implements IBaseComponent
	{
		
		public function InputField(parent:DisplayObjectContainer=null)
		{
			super(parent);
		}
		
		override protected function init():void
		{
			super.init();
			
			_text = "";
		}
		
		override protected function createChildren() : void
		{
			super.createChildren();
		}
		
		override protected function draw(skipDispatch:Boolean = false ) : Boolean
		{
			if( !super.draw(skipDispatch) )
				return false;
				
			field.type = TextFieldType.INPUT;
			field.selectable = true;
			
			field.addEventListener( FocusEvent.FOCUS_IN, field_focusInHandler, false, 0, true );
			field.addEventListener( FocusEvent.FOCUS_OUT, field_focusOutHandler, false, 0, true );
			field.addEventListener(KeyboardEvent.KEY_DOWN, field_keyDownHandler, false, 0, true );
			//field.addEventListener(Event.CHANGE, field_changeHandler, false, 0, true );
			//field.addEventListener(
			
			return true;
		}
		
		protected function field_focusInHandler ( event:FocusEvent ) : void
		{
			dispatchEvent( new InputFieldEvent( InputFieldEvents.FOCUS_IN );
			renderState( InputFieldStates.SELECTED );
		}
		
		protected function field_focusOutHandler ( event:FocusEvent ) : void
		{
			_text = field.text;
			dispatchEvent( new InputFieldEvent( InputFieldEvents.FOCUS_OUT ) );
			renderState( InputFieldStates.DESELECTED );
		}
		
		protected function field_keyDownHandler ( event:KeyboardEvent ) : void
		{
			dispatchEvent( 
				new InputFieldKeyEvent(InputFieldEvents.KEY_DOWN, false, false, event.charCode, event.keyCode
				, event.keyLocation, event.ctrlKey, event.altKey, event.shiftKey ) 
			);
		}
		
		override protected function renderState ( state:uint ) : void
		{
			_state |= state;
			
			// if value is already set, switch
			
			switchState( state, InputFieldStates.SELECTED, InputFieldStates.DESELECTED);
			switchState( state, InputFieldStates.ENABLED, InputFieldStates.DISABLED);
			
			/*
			if ((state & InputFieldStates.SELECTED) && (_state & InputFieldStates.DESELECTED))
				_state ^= InputFieldStates.DESELECTED;
			
			if ((state & InputFieldStates.DESELECTED) && (_state & InputFieldStates.SELECTED))
				_state ^= InputFieldStates.SELECTED;
			*/
				
			/*
			if ((state & InputFieldStates.ENABLED) && (_state & InputFieldStates.DISABLED))
				_state ^= InputFieldStates.DISABLED;
				
			if ((state & InputFieldStates.DISABLED) && (_state & InputFieldStates.ENABLED))
				_state ^= InputFieldStates.ENABLED;
			*/
			
			// and draw
			
			if( containActiveState( InputFieldStates.SELECTED, state ) )
			{
				//trace( "SELECTED" );
			}

			if( containActiveState( InputFieldStates.DESELECTED, state ) )
			{
				//trace( "DESELECTED" );
			}

			if( containActiveState( InputFieldStates.ENABLED, state ) )
			{
				//trace( "ENABLED" );
			}
			
			if( containActiveState( InputFieldStates.DISABLED, state ) )
			{
				//trace( "DISABLED" );
			}
			
			if( containActiveState( InputFieldStates.OVER, state ) )
			{
				//trace( "ENABLED" );
			}
			
			if( containActiveState( InputFieldStates.OUT, state ) )
			{
				//trace( "DISABLED" );
			}

			
			/*
			if( (_state & InputFieldStates.SELECTED) == InputFieldStates.SELECTED )
			{
				trace( "SELECTED" );
			}
			*/
			
			/*
			if( (_state & InputFieldStates.DESELECTED) == InputFieldStates.DESELECTED )
			{
				trace( "DESELECTED" );
			}
			
			if( (_state & InputFieldStates.ENABLED) == InputFieldStates.ENABLED )
			{
				trace( "ENABLED" );
			}
				
			if( (_state & InputFieldStates.DISABLED) == InputFieldStates.DISABLED && state == InputFieldStates.DISABLED  )
			{
				trace( "DISABLED" );
			}
			*/
			
			// _state |= state;
		}
		
		public function get currentText () : String
		{
			if( field == null ) return "";
			return field.text;
		}
		
		public function set enabled ( value:Boolean ) : void
		{
			super.renderState( value ? InputFieldStates.ENABLED : InputFieldStates.DISABLED );
		}
		
		override public function destroy( removedFromStage:Boolean = false ) : Boolean
		{
			if( _destroyed )
				return false;
				
			field.removeEventListener( FocusEvent.FOCUS_IN, field_focusInHandler, false );
			field.removeEventListener( FocusEvent.FOCUS_OUT, field_focusOutHandler, false );
			field.removeEventListener( KeyboardEvent.KEY_DOWN, field_keyDownHandler, false );
			
			if( !super.destroy(removedFromStage) )
				return false;
				
			return true;
			
		}
		
	}
}