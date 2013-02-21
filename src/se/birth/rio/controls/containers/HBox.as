/** 
 * 	HBox: Use this container-component when you want to arrange children in x way.
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	2
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.controls.containers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import nl.base42.log.Logger;
	
	import se.birth.rio.core.BaseComponent;
	import se.birth.rio.core.IBaseComponent;
	
	public class HBox extends Box implements IBaseComponent, IBox
	{
		protected var _renderWidth:Number;
		
		public function HBox(parent:DisplayObjectContainer=null)
		{
			super(parent);
		}
		
		override protected function updateDisplayList () : void
		{
			var i:int;
			var l:int = container.numChildren;
			var child:DisplayObject;
			
			_renderWidth = 0;
			
			for( i=0; i<l; ++i )
			{
				child = container.getChildAt( i );
				child.x = _renderWidth;
				
				if( child is BaseComponent )
					_renderWidth += (child as BaseComponent).componentWidth;
				else
					_renderWidth += child.width;
				
				if( i != l-1 )
					_renderWidth += _spacing;
			}
		}
		
		override public function get componentWidth() : Number
		{
			return !isNaN(_renderWidth) ? _renderWidth : 0;
		}
	}
}