package se.birth.rio.controls.video.engine.client
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	[Event(name="onXMPData", type="se.birth.rio.controls.video.engine.client.NetStreamClientEvent")]
	[Event(name="onMetaData", type="se.birth.rio.controls.video.engine.client.NetStreamClientEvent")]
	[Event(name="onCuePoint", type="se.birth.rio.controls.video.engine.client.NetStreamClientEvent")]
	[Event(name="onImageData", type="se.birth.rio.controls.video.engine.client.NetStreamClientEvent")]
	[Event(name="onTextData", type="se.birth.rio.controls.video.engine.client.NetStreamClientEvent")]
	[Event(name="onDRMContentData", type="se.birth.rio.controls.video.engine.client.NetStreamClientEvent")]
	[Event(name="onPlayStatus", type="se.birth.rio.controls.video.engine.client.NetStreamClientEvent")]
	[Event(name="unknownCall", type="se.birth.rio.controls.video.engine.client.NetStreamClientEvent")]
	
	dynamic public class NetStreamClient extends Proxy implements IEventDispatcher
	{	
		protected var dispatcher:EventDispatcher;
		
		public function NetStreamClient ( ) : void
		{
			dispatcher = new EventDispatcher(this);
		}
		
		// this is a catch-all method witch dispatches events
		flash_proxy override function callProperty( name:*, ...args ):*
		{
			var qName:QName = name as QName;
			
			switch( qName.localName )
			{
				case NetStreamClientEvent.ON_X_M_P_DATA:
				case NetStreamClientEvent.ON_META_DATA:
				case NetStreamClientEvent.ON_CUE_POINT:
				case NetStreamClientEvent.ON_IMAGE_DATA:
				case NetStreamClientEvent.ON_TEXT_DATA:
				case NetStreamClientEvent.ON_D_R_M_CONTENT_DATA:
				case NetStreamClientEvent.ON_PLAY_STATUS:
					dispatchEvent( new NetStreamClientEvent( qName.localName, args, qName.localName ) );
					break;
				
				default:
					dispatchEvent( 
						new NetStreamClientEvent( NetStreamClientEvent.UNKNOWN_CALL, args, qName.localName ) );
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