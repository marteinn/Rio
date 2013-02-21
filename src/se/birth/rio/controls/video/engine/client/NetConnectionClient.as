package se.birth.rio.controls.video.engine.client
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import nl.base42.log.Logger;
	
	[Event(name="onBWDone", type="se.birth.rio.controls.video.engine.client.NetConnectionClientEvent")]
	[Event(name="unknownCall", type="se.birth.rio.controls.video.engine.client.NetConnectionClientEvent")]
	
	dynamic public class NetConnectionClient extends Proxy implements IEventDispatcher
	{	
		protected var dispatcher:EventDispatcher;
		
		public function NetConnectionClient ( ) : void
		{
			dispatcher = new EventDispatcher(this);
		}
		
		// this is a catch-all method witch dispatches events
		flash_proxy override function callProperty( name:*, ...args ):*
		{
			var qName:QName = name as QName;
			
			switch( qName.localName )
			{
				case NetConnectionClientEvent.ON_B_W_DONE:
					dispatchEvent( new NetConnectionClientEvent( qName.localName, args, qName.localName ) );
					break;
				
				default:
					dispatchEvent( 
						new NetConnectionClientEvent( NetConnectionClientEvent.UNKNOWN_CALL, args, qName.localName ) );
					break;
			}
		}
		
		// TODO! This needs to be reworked, anonymous functions are never nice. 
		// And they are always a memory hog.
		flash_proxy override function getProperty(name:*) : *
		{
			var qName:QName = name as QName;
			
			return function ( ...args ) : void
			{
				flash_proxy::callProperty( qName, args[0] );
			}
		}
		
		// inherited methods for EventDispatcher
		public function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0
										  , useWeakListener:Boolean = true ) : void
		{
			dispatcher.addEventListener( type, listener, useCapture, priority, useWeakListener );
		}
		
		public function dispatchEvent( event:Event ) : Boolean
		{
			return dispatcher.dispatchEvent( event );
		}
		
		public function hasEventListener( type:String ) : Boolean
		{
			return dispatcher.hasEventListener( type );
		}
		
		public function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ) : void
		{
			dispatcher.removeEventListener( type, listener, useCapture );
		}
		
		public function willTrigger( type:String ) : Boolean
		{
			return dispatcher.willTrigger( type );
		}
		
	}
}