/** 
 * 	BaseMenu: 	A class ment to be used when creating menus. It extends ModelComponent for 
 * 				model handling and adds addressState when dealing with items.
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	1
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.controls.menus
{
	import flash.display.DisplayObjectContainer;
	
	import se.birth.rio.core.IBaseComponent;
	import se.birth.rio.core.ModelComponent;

	[Event(name="menuClick", type="se.birth.rio.controls.menus.MenuEvent")]
	[Event(name="menuRollOver", type="se.birth.rio.controls.menus.MenuEvent")]
	[Event(name="menuRollOut", type="se.birth.rio.controls.menus.MenuEvent")]
	[Event(name="menuChange", type="se.birth.rio.controls.menus.MenuEvent")]
	
	public class BaseMenu extends ModelComponent implements IBaseComponent
	{
		protected var _addressState:*;
		
		public function BaseMenu(parent:DisplayObjectContainer=null, modelClass:Class = null )
		{
			super(parent, modelClass);
		}
		
		override protected function draw(skipDispatch:Boolean=false) : Boolean
		{
			if( !super.draw(skipDispatch) )
				return false;
		
			return true;
		}
		
		protected function dispatchAddressState( value:* ) : void
		{
			dispatchEvent( new MenuEvent( MenuEvent.MENU_CLICK, value ) );
		}
		
		override public function get model():*
		{
			return _model;
		}
		
		override public function destroy( removedFromStage:Boolean = false ) : Boolean
		{
			if( _destroyed )
				return false;
			
			if( !super.destroy(removedFromStage) )
				return false;
				
			return true;
		}

		public function get addressState():*
		{
			return _addressState;
		}

		public function set addressState(v:*):void
		{
			_addressState = v;
			invalidate ();
		}

		
	}
}