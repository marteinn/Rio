/** 
 * 	AbstractButton: Use this class when making buttons with a non-text base (when dealing with text, use LabelButton)
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	1.1
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.controls.buttons
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import se.birth.rio.core.BaseComponent;
	import se.birth.rio.core.IBaseComponent;
	
	[Event(name="buttonClick", type="se.birth.rio.controls.buttons.ButtonEvent")]
	[Event(name="buttonUp", type="se.birth.rio.controls.buttons.ButtonEvent")]
	[Event(name="buttonDown", type="se.birth.rio.controls.buttons.ButtonEvent")]
	[Event(name="buttonOver", type="se.birth.rio.controls.buttons.ButtonEvent")]
	[Event(name="buttonOut", type="se.birth.rio.controls.buttons.ButtonEvent")]
	
	public class AbstractButton extends BaseComponent implements IBaseComponent
	{
		
		public function AbstractButton(parent:DisplayObjectContainer=null)
		{
			super(parent);
		}
		
		override protected function draw(skipDispatch:Boolean=false) : Boolean
		{
			if( !super.draw(skipDispatch) )
				return false;
			
			buttonMode = true;
			
			if( !container.hasEventListener( MouseEvent.CLICK ) )
			{
				container.addEventListener( MouseEvent.CLICK, container_clickHandler, false, 0, true );
				container.addEventListener( MouseEvent.MOUSE_DOWN, container_downHandler, false, 0, true );
				container.addEventListener( MouseEvent.MOUSE_UP, container_upHandler, false, 0, true );
				container.addEventListener( MouseEvent.ROLL_OVER, container_overHandler, false, 0, true );
				container.addEventListener( MouseEvent.ROLL_OUT, container_outHandler, false, 0, true );
			}
			
			return true;
		}
		
		
		
		protected function container_clickHandler ( event:MouseEvent ) : void
		{
			dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_CLICK ) );
			renderState( ButtonStates.CLICK );
		}
		
		protected function container_downHandler ( event:MouseEvent ) : void
		{
			dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_DOWN ) );
			renderState( ButtonStates.DOWN );
		}
		
		protected function container_upHandler ( event:MouseEvent ) : void
		{
			dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_UP ) );
			renderState( ButtonStates.UP );
		}
		
		protected function container_overHandler ( event:MouseEvent ) : void
		{
			dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_OVER ) );
			renderState( ButtonStates.OVER );
		}
		
		protected function container_outHandler ( event:MouseEvent ) : void
		{
			dispatchEvent( new ButtonEvent( ButtonEvent.BUTTON_OUT) );
			renderState( ButtonStates.OUT );
		}
		
		override public function setState( state:uint ) : void
		{
			renderState( state );
		}
		
		override protected function renderState ( state:uint ) : void
		{		
			_state |= state;
			
			switchState( state, ButtonStates.OVER, ButtonStates.OUT );
			
			if( containActiveState( ButtonStates.CLICK, state ) )
			{
			}
			
			if( containActiveState( ButtonStates.DOWN, state ) )
			{
			}
			
			if( containActiveState( ButtonStates.UP, state ) )
			{
			}
			
			if( containActiveState( ButtonStates.OVER, state ) )
			{
			}
			
			if( containActiveState( ButtonStates.OUT, state ) )
			{
			}

		}
		
		override public function destroy( removedFromStage:Boolean = false ) : Boolean
		{
			if( _destroyed )
				return false;
				
			container.removeEventListener( MouseEvent.CLICK, container_clickHandler, false );
			container.removeEventListener( MouseEvent.MOUSE_DOWN, container_downHandler, false );
			container.removeEventListener( MouseEvent.MOUSE_UP, container_upHandler, false );
			container.removeEventListener( MouseEvent.ROLL_OVER, container_overHandler, false );
			container.removeEventListener( MouseEvent.ROLL_OUT, container_outHandler, false );
			
			if( !super.destroy(removedFromStage) )
				return false;
				
			return true;
			
		}
		
		
		/**
		 * Getters & Setters
		 */
		
		public function set select ( value:Boolean ) : void
		{
			setState( value ? ButtonStates.SELECTED : ButtonStates.NORMAL );
		}
		
		public function set enabled ( value:Boolean ) : void
		{
			renderState( value ? ButtonStates.ENABLED : ButtonStates.DISABLED );
		}
		
	}
}