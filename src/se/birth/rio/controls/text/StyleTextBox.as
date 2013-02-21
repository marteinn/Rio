/** 
 * 	StyleTextBox: For text based on multiple lines with a styleSheet. (Extends Label) 
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
	import flash.events.TextEvent;
	import flash.text.StyleSheet;
	
	import nl.base42.log.Logger;
	
	import se.birth.rio.core.IBaseComponent;
	
	[Event(name="styleTextLink", type="se.birth.rio.controls.text.StyleTextBoxEvent")]

	public class StyleTextBox extends TextBox implements IBaseComponent
	{
		protected var _styleSheet:StyleSheet;
		
		public function StyleTextBox(parent:DisplayObjectContainer=null)
		{
			super(parent);
		}
		
		override protected function draw(skipDispatch:Boolean=false) : Boolean
		{
			if( !super.draw(skipDispatch) )
				return false;
				
			if( !field.hasEventListener( TextEvent.LINK ) )
			{
				field.addEventListener(TextEvent.LINK, field_linkHandler, false, 0, true );
			}
			
			return true;
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
		
		protected function field_linkHandler ( event:TextEvent ) : void
		{
			var styleTextBoxEvent:StyleTextBoxEvent = new StyleTextBoxEvent( 
				StyleTextBoxEvent.LINK, event.text, false, false );
			
			dispatchEvent( styleTextBoxEvent );
		}
		
		
		override public function destroy( removedFromStage:Boolean = false ) : Boolean
		{
			if( _destroyed )
				return false;
				
			field.removeEventListener(TextEvent.LINK, field_linkHandler );
			
			if( !super.destroy(removedFromStage) )
				return false;
				
			return true;
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