/** 
 * 	VBox: Use this container-component when you want to arrange children in y way.
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
	
	import se.birth.rio.core.BaseComponent;
	import se.birth.rio.core.IBaseComponent;
	
	public class VBox extends Box implements IBaseComponent, IBox
	{
		protected var _renderHeight:Number;
		
		public function VBox(parent:DisplayObjectContainer=null)
		{
			super(parent);
		}
		
		override protected function updateDisplayList () : void
		{
			var i:int;
			var l:int = container.numChildren;
			var child:DisplayObject;
			
			_renderHeight = 0;
			
			for( i=0; i<l; ++i )
			{
				child = container.getChildAt( i );
				child.y = _renderHeight;
				
				// 
				if( child.visible == false )
					continue;
				
				if( child is BaseComponent )
					_renderHeight += (child as BaseComponent).componentHeight;
				else
					_renderHeight += child.height;
				
				if( i != l-1 )
					_renderHeight += _spacing;
			}
		}
		
		override public function get componentHeight() : Number
		{
			return !isNaN(_renderHeight) ? _renderHeight : 0;
		}
	}
}