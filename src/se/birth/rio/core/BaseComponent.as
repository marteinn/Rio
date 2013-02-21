/** 
 * 	BaseComponent: 	This is the core class for Rio, extend this to gain base functionality 
 * 					(invalidation, draw notification, 
 * 					state management).
 * 
 *  			   	This class replaced the old SimpleComponent (part of the BirthLib).
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	2.3
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.core
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	
	[Event(name="baseDraw", type="se.birth.rio.core.BaseComponentEvent")]
	[Event(name="baseRemove", type="se.birth.rio.core.BaseComponentEvent")]
	
	public class BaseComponent extends Sprite
	{
		protected var _width:Number;
		protected var _height:Number;
		
		protected var _invalidated:Boolean = true;
		protected var _destroyed:Boolean = false;
		protected var _debug:Boolean = false;
		
		protected var _align:String = "";
		protected var _valign:String = "";
		
		protected var _version:String = "v2.3";
		
		protected var _state:uint;
		
		protected var container:Sprite;
		
		public function BaseComponent( parent:DisplayObjectContainer = null )
		{
			if( parent != null )
				parent.addChild( this );
			
			preInit ();
		}
		
		/**
		 * [Private]
		 * Pre initialization of component
		 */
		private function preInit () : void
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
				
			init ();
			preCreateChildren ();
		}
		
		
		
		/**
		 * [Protected]
		 * This method is overriden by extending components for init related code.
		 */
		protected function init () : void {}
		
		
		
		/**
		 * [Private]
		 * Create the necessary display objects for component, before running create children
		 */
		private function preCreateChildren () : void
		{
			container = new Sprite ();
			super.addChild( container );
			
			createChildren ();
			invalidate ();
		}
		
		
		/**
		 * [Protected]
		 * This method is overriden by extending components for createChildren related code.
		 */
		protected function createChildren () : void 
		{
		};

		
		/**
		 * [Private]
		 * Event handler that runs invalidate when component has been added to display list
		 */
		private function addedToStageHandler ( event:Event ) : void
		{
			invalidate ();		
		}

		
		/**
		 * [Private]
		 * Event handler that runs destroy when component has been removed from display list
		 */
		private function removedFromStageHandler ( event:Event ) : void
		{
			destroy (true);
		}
		
		
		protected function draw ( skipDispatch:Boolean = false ) : Boolean
		{
			// check if the component is a part of the display list
			if( parent == null )
				return false;
				
			if( !_invalidated )
				return false;
			
			if( !skipDispatch )
				dispatchEvent( new BaseComponentEvent( BaseComponentEvent.BASE_DRAW ) );
			
			_invalidated = false;
		
			return true;
		}
		
		/**
		 * [Public]
		 * Invalidate tells the component to redraw (call draw) on the next enter frame.
		 */
		public function invalidate () : void
		{	
			_invalidated = true;
			
			addEventListener( Event.ENTER_FRAME, invalidateHandler );
		}
		
		/**
		 * [Public]
		 * InvalidateNow tells the component to redraw (call draw) immediatly.
		 */
		public function invalidateNow () : void
		{
			_invalidated = true;
			
			invalidateHandler ();
		}
		
		/**
		 * [Public]
		 * This method sets the dimensions for the component, any changes will be 
		 * then detected in the draw method in the values _width and _height.
		 * 
		 * @param w
		 * @param h
		 */		
		public function setSize( w:Number, h:Number = 0 ) : void
		{
			_width = w;
			_height = h;
			
			invalidate ();
			
			dispatchEvent( new Event( Event.RESIZE ) );
		}		
		
		/**
		 * [Public] 	
		 * Override and use this method when you want to register a coordinate 
		 * change run a specific function. Like a tween or similar.
		 * 			
		 * @param tX
		 * @param tY
		 * 
		 */
		public function moveTo( tX:Number, tY:Number ) : void
		{
			x = tX;
			y = tY;
		}
		
		
		public function destroy ( removedFromStage:Boolean = false ) : Boolean
		{
			if( _destroyed )
				return false;

			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			removeEventListener( Event.ENTER_FRAME, invalidateHandler );
				
			if( parent != null && !removedFromStage )
				parent.removeChild( this ); 
				
			_destroyed = true;
			
			dispatchEvent( new BaseComponentEvent( BaseComponentEvent.BASE_REMOVE ) );
			
			return true;
		}
		
		
		
		
		
		
		public function setState( state:uint ) : void
		{
			renderState( state );
		}
		
		protected function renderState( state:uint ) : void
		{
			
		}
		
		protected function switchState ( state:uint, state1:uint, state2:uint ) : void
		{
			if ((state & state1) && (_state & state2))
				_state ^= state2;
			
			if ((state & state2) && (_state & state1))
				_state ^= state1;
		}
		
		protected function containState( state:uint ) : Boolean
		{
			return (_state & state) == state;
		}
		
		protected function containActiveState( state:uint, activeState:uint ) : Boolean
		{
			return containState( state ) && state == activeState;
		}
		
		
		
		
		
		
		/**
		 * [Public]
		 * An "monkeypatch" to the eventdispatcher to gain more speed when dispatching non subscribed events
		 * http://www.gskinner.com/blog/archives/2008/12/making_dispatch.html
		 * 
		 * @param event
		*/
		override public function dispatchEvent( event:Event ) : Boolean 
		{
			if (hasEventListener(event.type) || event.bubbles) 
			{
				return super.dispatchEvent(event);
			}
			return true;
		}
		
		
		/**
		 * [Public] 	
		 * Same functionality as addEventListener, but with useWeakReference set to true.
		 * 			
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param priority
		 * @param useWeakReference
		 * 
		 */
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0
												  , useWeakReference:Boolean=true) : void
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		
		
		/**
		 * Handlers
		 */
		
		private function invalidateHandler ( event:Event = null ) : void
		{
			removeEventListener( Event.ENTER_FRAME, invalidateHandler );
			draw ();
		}
		
		
		
		
		/**
		 * Getters & Setters
		 */
		
		/**
		 *
		 */
		public function get version () : String
		{
			return _version;
		}
		
		
		protected function get hasSize() : Boolean
		{
			return !(isNaN(_width) || isNaN(_height));
		}
		
		
		/**
		 *
		 */
		public function set debug ( value:Boolean ) : void
		{
			_debug = value;
			invalidate ();
		}
		
		public function get debug () : Boolean
		{
			return _debug;
		}
		
		
		/**
		 *
		 */
		public function get componentWidth ( ) : Number
		{
			return _width;
		}
		
		public function set componentWidth ( w:Number ) : void
		{
			_width = w;
			invalidate ();
		}

		/**
		 *
		 */
		public function get componentHeight ( ) : Number
		{
			return _height;
		}	
		
		public function set componentHeight ( h:Number ) : void
		{
			_height = h;
			invalidate ();
		}	

		
		/**
		 *
		 */
		public function set align ( value:String ) : void
		{
			_align = value;
			invalidate ();
		}
		
		public function get align () : String
		{
			return _align;
		}
		
		
		/**
		 *
		 */
		public function set valign ( value:String ) : void
		{
			_valign = value;
			invalidate ();
		}
		
		public function get valign () : String
		{
			return _valign;
		}
		
		/**
		 * [Public]
		 * This is the general toString for all components, it generates a string with
		 * class name, width and size.
		 * Note: Thanks http://blog.hexagonstar.com/customizing-tostring/
		 */
		override public function toString():String 
		{
			return "[" + getQualifiedClassName(this).match("[^:]*$")[0]+", width="+_width+", _height="+_height+"]";
		}
			
		
		
	}
}