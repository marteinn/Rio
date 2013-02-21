/** 
 * 	TextBox: Used for text with multiple lines, extends Label. 
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
	import flash.events.Event;
	
	import se.birth.rio.core.IBaseComponent;

	public class TextBox extends Label implements IBaseComponent
	{	
		public function TextBox(parent:DisplayObjectContainer=null)
		{
			super(parent);
		}

		override protected function draw(skipDispatch:Boolean=false) : Boolean
		{
			if( !hasSize )
				return false;
			
			if( !super.draw(skipDispatch) )
				return false;		

			field.multiline = true;
			field.wordWrap = true;
			field.addEventListener( Event.SCROLL, field_scrollHandler, false, 0, true );
			
			return true;	
		}
		
		protected function field_scrollHandler ( event:Event ) : void
		{
			dispatchEvent( new Event( Event.SCROLL ) );
		}
		
		override public function destroy( removedFromStage:Boolean = false ) : Boolean
		{
			if( _destroyed )
				return false;
			
			field.removeEventListener( Event.SCROLL, field_scrollHandler, false );
			
			if( !super.destroy(removedFromStage) )
				return false;
				
			return true;
			
		}
		
	}
}