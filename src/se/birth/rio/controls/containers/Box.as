/** 
 * 	Box: This is the abstract baseclass when creating a layout container component, VBox and HBox extends from this.
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
	import flash.events.Event;
	
	import se.birth.rio.core.BaseComponent;
	import se.birth.rio.core.BaseComponentEvent;
	import se.birth.rio.core.IBaseComponent;
	
	public class Box extends BaseComponent implements IBaseComponent, IBox
	{
		protected var _spacing:Number = 0;
		
		public function Box(parent:DisplayObjectContainer=null)
		{
			super(parent);
		}

		override protected function draw(skipDispatch:Boolean=false) : Boolean
		{
			if( !super.draw(true) )
				return false;
			
			updateDisplayList ();
			
			dispatchEvent( new BaseComponentEvent( BaseComponentEvent.BASE_DRAW ) );
			
			return true;
		}
		
		protected function updateDisplayList () : void
		{
			var i:int;
			var l:int;
			var child:DisplayObject;
			
			for( i=0; i<l; ++i )
			{
				child = container.getChildAt( i );
			}
		}
		
		override public function addChild( child:DisplayObject ) : DisplayObject
		{
			container.addChild( child );
			child.addEventListener( BaseComponentEvent.BASE_DRAW, child_drawHandler, false, 0, true );
			child.addEventListener( BaseComponentEvent.BASE_REMOVE, child_removeHandler, false, 0, true );
			invalidate ();
			
			return child;
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			container.addChildAt( child, index );
			child.addEventListener( BaseComponentEvent.BASE_DRAW, child_drawHandler, false, 0, true );
			child.addEventListener( BaseComponentEvent.BASE_REMOVE, child_removeHandler, false, 0, true );
			invalidate ();
			
			return child;
		}
		
		override public function removeChild( child:DisplayObject ) : DisplayObject
		{
			container.removeChild( child );
			child.removeEventListener( BaseComponentEvent.BASE_DRAW, child_drawHandler );
			invalidate ();
			
			return child;
		}
		
		override public function getChildAt( index:int ) : DisplayObject
		{
			return container.getChildAt( index );
		}
		
		
		
		public override function get numChildren():int
		{
			return container.numChildren;
		}
		
		protected function removeChildren () : void
		{
			var i:int;
			var l:int;
			var child:DisplayObject;
			
			while( container.numChildren )
			{
				child = container.getChildAt( i );
				child.removeEventListener( BaseComponentEvent.BASE_DRAW, child_drawHandler );
				child.removeEventListener( BaseComponentEvent.BASE_REMOVE, child_removeHandler );
				
				if( child is BaseComponent )
					(child as BaseComponent).destroy();
				
				if( child.parent != null )
					container.removeChild( child );
			}
		}
		
		protected function child_drawHandler ( event:Event ) : void
		{
			invalidate ();
		}
		
		protected function child_removeHandler ( event:Event ) : void
		{
			invalidate ();
		}
		
		override public function destroy( removedFromStage:Boolean = false ) : Boolean
		{
			if( _destroyed )
				return false;
			
			removeChildren ();
			
			super.destroy();
			
			return true;
		}

		public function get spacing():Number
		{
			return _spacing;
		}

		public function set spacing(value:Number):void
		{
			_spacing = value;
			invalidate ();
		}

	}
}