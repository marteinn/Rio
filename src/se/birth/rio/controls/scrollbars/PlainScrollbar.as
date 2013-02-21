/** 
 * 	PlainScrollbar: A straightforward porting of PlainScrollbar from BirthLib. 
 * 					Extends B4aseScrollbar and visualizes a vertical scrollbar.
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	2
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.controls.scrollbars
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import se.birth.rio.core.IBaseComponent;

	public class PlainScrollbar extends BaseScrollbar implements IBaseComponent
	{
		/*
		 * properties
		 *
		 */
		protected var _fillColor:uint = 0xFFFFFF;
		protected var _fillAlpha:Number = 1;
		
		protected var _backgroundColor:uint = 0xFF0000
		protected var _backgroundAlpha:Number = 1;
		
		// instances
		protected var background:Sprite;	
		protected var dragger:Sprite;
		
		protected var dragging:Boolean = false;
		
		
		public function PlainScrollbar(parent:DisplayObjectContainer=null)
		{
			super(parent);
		}
	
		override protected function createChildren () : void
		{
			super.createChildren();
			
			background = new Sprite ();
			container.addChild( background );
			
			dragger = new Sprite ();
			container.addChild( dragger );		
		}
		
		override public function draw() : Boolean
		{
				
			if( !hasSize )
				return false;
			
			if( !super.draw() )
				return false;
				
			background.graphics.clear();
			background.graphics.beginFill( _backgroundColor, _backgroundAlpha );
			background.graphics.drawRect( 0, 0, _width, _height );
			background.graphics.endFill();
			
			dragger.graphics.clear();
			dragger.graphics.beginFill( _fillColor, _fillAlpha );
			dragger.graphics.drawRect( 0, 0, _width, _height*_fill );
			dragger.graphics.endFill();
			
			if( !dragger.hasEventListener( MouseEvent.MOUSE_DOWN ) )
			{
				addListeners ();
			}
			
			updateDraggerPosition ();
				
			return true;
		}
		
		
		/**
		 * Method witch runs all needed listeners. Override this method when adding MOUSE_OVER, MOUSE_OUT 
		 * capabilities to dragger and background 
		 * 
		 */
		protected function addListeners () : void
		{
			dragger.addEventListener( MouseEvent.MOUSE_DOWN, dragger_mouseDownHandler, false, 0, true );
		}
		
		
		/**
		 * Mouse down handler for dragger
		 * @param event
		 * 
		 */
		protected function dragger_mouseDownHandler ( event:MouseEvent ) : void
		{
			var rect:Rectangle = new Rectangle( 0, 0, 0, _height-draggerHeight );
			
			stage.addEventListener( MouseEvent.MOUSE_UP, stage_upHandler );
			
			dragger.startDrag( false, rect );
			dragger.addEventListener( Event.ENTER_FRAME, dragger_enterFrameHandler, false, 0, true );
			
			dragging = true;
		}
		
		/**
		 * Mouse up handler for stage. Gets initialized when dragger has mouse down
		 * @param event
		 * 
		 */
		protected function stage_upHandler ( event:MouseEvent ) : void
		{
			stage.removeEventListener( MouseEvent.MOUSE_UP, stage_upHandler );
			
			dragger.removeEventListener( Event.ENTER_FRAME, dragger_enterFrameHandler );
			dragger.stopDrag ();
			
			dragging = false;
		}
		
		
		/**
		 * Enter Frame handler witch continuously sets position from dragger.y  
		 * @param event
		 * 
		 */
		protected function dragger_enterFrameHandler ( event:Event ) : void
		{
			var value:Number = 1/(_height-draggerHeight)*dragger.y;

			position = value;
		}
		
		
		/**
		 * This method makes sure that the dragger position is sync with the overall position 
		 * 
		 */
		protected function updateDraggerPosition () : void
		{
			if( dragging )
				return;
				
			dragger.y = (_height-draggerHeight)*_position;
		}
		
		
		/**
		 * Dragger size property, calculated with _height * _fill
		 * @return The with of the dragger
		 * 
		 */
		public function get draggerHeight () : Number
		{
			return _height*_fill;
		}

		
		/**
		 * Set/Gets the dragger color  
		 * @return Dragger Color
		 * 
		 */
		public function get fillColor():uint
		{
			return _fillColor;
		}

		public function set fillColor(v:uint):void
		{
			_fillColor = v;
			invalidate ();
		}
		
		/**
		 * Set/Gets the dragger alpha 
		 * @return A number between 0-1
		 * 
		 */
		public function get fillAlpha():Number
		{
			return _fillAlpha;
		}

		public function set fillAlpha(v:Number):void
		{
			_fillAlpha = v;
			invalidate ();
		}


		/**
		 * Set/Gets background color 
		 * @return Background Color
		 * 
		 */
		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}

		public function set backgroundColor(v:uint):void
		{
			_backgroundColor = v;
			invalidate ();
		}


		/**
		 * Set/Get background color 
		 * @return A number between 0-1
		 * 
		 */
		public function get backgroundAlpha():Number
		{
			return _backgroundAlpha;
		}

		public function set backgroundAlpha(v:Number):void
		{
			_backgroundAlpha = v;
			invalidate ();
		}


	}
}