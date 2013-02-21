package se.birth.rio.controls.video.engine
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import nl.base42.log.Logger;
	
	import org.osmf.net.NetConnectionCodes;
	
	import se.birth.net.NetStatusConstants;
	import se.birth.rio.controls.video.engine.client.NetConnectionClient;
	import se.birth.rio.controls.video.engine.client.NetConnectionClientEvent;
	import se.birth.rio.controls.video.engine.client.NetStreamClient;
	import se.birth.rio.controls.video.engine.client.NetStreamClientEvent;
	import se.birth.rio.controls.video.engine.events.EngineEvent;
	import se.birth.rio.controls.video.engine.events.EngineStatusEvent;
	import se.birth.rio.core.BaseComponent;
	import se.birth.rio.utils.video.RtmpUtils;
	
	public class StreamingEngine extends BaseComponent implements IEngine
	{
		protected var netConnection:NetConnection;
		protected var connectionClient:NetConnectionClient;
		protected var netStream:NetStream;
		protected var streamClient:NetStreamClient;
		protected var video:Video;
		protected var videoContainer:Sprite;
		
		protected var _smoothing:Boolean = true;
		protected var _url:String = "";
		protected var _duration:Number = -1;
		protected var _volume:Number = 1;
		
		public function StreamingEngine(parent:DisplayObjectContainer=null)
		{
			super(parent);
		}
		
		override protected function createChildren() : void
		{
			super.createChildren();
			
			connectionClient = new NetConnectionClient();
			
			netConnection = new NetConnection();
			netConnection.client = connectionClient;
			
			streamClient = new NetStreamClient();
			
			videoContainer = new Sprite();
			container.addChild( videoContainer );
			
			// TODO! Find a better way to deal with the flv width/height
			video = new Video( 1024, 768 );
			videoContainer.addChild( video );
		}
		
		override protected function draw(skipDispatch:Boolean=false) : Boolean
		{			
			if( !hasSize )
				return false;
			
			if( !super.draw(skipDispatch) )
				return false;

			
			container.graphics.clear();
			container.graphics.beginFill( 0x000000, 1 );
			container.graphics.drawRect( 0, 0, _width, _height );
			container.graphics.endFill();
			
			if( !netConnection.hasEventListener( NetStatusEvent.NET_STATUS ) )
			{
				netConnection.addEventListener( NetStatusEvent.NET_STATUS, netConnection_netStatusHandler, false, 0, true );
				netConnection.addEventListener( IOErrorEvent.IO_ERROR, netConnection_ioErrorHandler, false, 0, true );
				
				connectionClient.addEventListener(NetConnectionClientEvent.ON_B_W_DONE, connectionClient_onBWDone, false, 0, true );
				
				streamClient.addEventListener(NetStreamClientEvent.ON_META_DATA, streamClient_onMetaData, false ,0, true );
				streamClient.addEventListener(NetStreamClientEvent.ON_PLAY_STATUS, streamClient_onPlayStatus, false, 0, true );
			}
			
			video.width = _width;
			video.height = _height;
			video.smoothing = _smoothing;
			
			return true;
		}
		
		public function load(url:String, autoStart:Boolean=true):void
		{
			if( _url == url )
				return;
			
			var urlData:Vector.<String>;
			
			reset();
			
			_url = url;
			
			urlData = RtmpUtils.parseUrl( url );
			
			netConnection.connect( urlData[0] );
		}
		
		
		public function reset():void
		{
			
			if( netStream != null )
			{
				netStream.pause();
				netStream.close();
				netStream = null;
				netConnection.close();
			}
			
			_duration = -1;
			
			video.clear();   
			videoContainer.removeChild( video );
			
			var soundTransform:SoundTransform = new SoundTransform( _volume );
			
			if( netStream != null )
			{
				netStream.soundTransform = soundTransform;
				netStream.close();
			}
			
			video = new Video( _width, _height );
			videoContainer.addChild( video );
		}
		
		protected function initNetStream () : void
		{	
			var urlData:Vector.<String>;
			
			urlData = RtmpUtils.parseUrl( _url );
			
			netStream = new NetStream( netConnection );
			netStream.bufferTime = 5;
			netStream.client = streamClient; 
			netStream.addEventListener(NetStatusEvent.NET_STATUS, netStream_netStatusHandler, false, 0, true );
			
			video.smoothing = true;
			video.attachNetStream( netStream );
			
			volume = _volume;
			
			netStream.play( urlData[1] );
		}
		
		public function pause():void
		{
			if( netStream != null )
				netStream.pause();
		}
		
		public function resume():void
		{
			if( netStream != null )
				netStream.resume();
		}
		
		public function seek(offset:Number):void
		{	
			if( netStream != null )
				netStream.seek( offset ) ;
		}
		
		protected function reportTime ( event:Event ) : void
		{
			dispatchEvent( new EngineEvent( EngineEvent.TIME_UPDATE ) );
		}
		
		override public function destroy( removedFromStage:Boolean = false ) : Boolean
		{
			if( _destroyed )
				return false;
			
			reset ();
			
			netConnection.removeEventListener( NetStatusEvent.NET_STATUS, netConnection_netStatusHandler );
			netConnection.removeEventListener( IOErrorEvent.IO_ERROR, netConnection_ioErrorHandler );
			
			connectionClient.removeEventListener(NetConnectionClientEvent.ON_B_W_DONE, connectionClient_onBWDone );
			
			streamClient.removeEventListener(NetStreamClientEvent.ON_META_DATA, streamClient_onMetaData );
			streamClient.removeEventListener(NetStreamClientEvent.ON_PLAY_STATUS, streamClient_onPlayStatus );
			
			removeEventListener( Event.ENTER_FRAME, reportTime );
			
			if( video != null )
				video.clear();
			
			netConnection = null;
			connectionClient = null;
			netStream = null;
			streamClient = null;
			
			container.removeChild( videoContainer );
			videoContainer = null;
			
			if( !super.destroy(removedFromStage) )
				return false;
			
			return true;
		}
		
		
		/**
		 * Handlers
		 */
		
		protected function connectionClient_onBWDone ( event:NetConnectionClientEvent ) : void
		{
			//Logger.debug( event );
		}
		
		
		protected function netConnection_netStatusHandler ( event:NetStatusEvent ) : void
		{	
			switch( event.info.code )
			{
				case NetStatusConstants.NETCONNECTION_CONNECT_SUCCESS:
					initNetStream ();
					break;
				
				case NetStatusConstants.NETCONNECTION_CONNECT_FAILED:
				case NetStatusConstants.NETCONNECTION_CONNECT_REJECTED:
					throw new Error( "StreamingEngine connection request was rejected." );
					break;
			}
		}
		
		protected function netConnection_ioErrorHandler ( event:IOErrorEvent ) : void
		{
			//Logger.debug( event );
		}
		
		protected function netStream_netStatusHandler ( event:NetStatusEvent ) : void
		{
			//Logger.debug( event );

			switch( event.info.code )
			{
				case NetStatusConstants.NETSTREAM_PLAY_START:
					// start
					dispatchEvent( new EngineEvent( EngineEvent.START ) );
					// Logger.critical( EngineEvent.START );
					break;
				
				case NetStatusConstants.NETSTREAM_BUFFER_FULL:
					dispatchEvent( new EngineEvent( EngineEvent.BUFFERT_START ) );
					
					addEventListener( Event.ENTER_FRAME, reportTime );
					break;
				
				case NetStatusConstants.NETSTREAM_BUFFER_EMPTY:
					dispatchEvent( new EngineEvent( EngineEvent.BUFFERT_STOP ) );
					
					removeEventListener( Event.ENTER_FRAME, reportTime );
					break;
			}
			
			dispatchEvent( new EngineStatusEvent( EngineStatusEvent.STATUS, event.info.code ) );
		}
		
		protected function streamClient_onPlayStatus ( event:NetStreamClientEvent ) : void
		{
			dispatchEvent( new EngineStatusEvent( EngineStatusEvent.STATUS, event.arguments[0].code ) );
		}
		
		protected function streamClient_onMetaData ( event:NetStreamClientEvent ) : void
		{
			// Logger.debug( event.arguments[0] );
			
			_duration = Math.floor(event.arguments[0].duration);
		}
		
		
		/**
		 * Getters & Setters
		 */
		
		public function get url():String
		{
			return _url;
		}
		
		public function get duration():Number
		{
			return _duration;
		}
		
		public function set volume(value:Number):void
		{
			var soundTransform:SoundTransform = new SoundTransform( value );
			
			_volume = value;
			if( netStream != null )
				netStream.soundTransform = soundTransform;
		}
		
		public function get volume():Number
		{
			if( netStream != null )
				return _volume;
			return -1;
		}
		
		public function get time() : Number
		{
			if( netStream != null )
				return netStream.time;
			return -1;
		}
		
		public function get bytesLoaded():Number
		{
			return 0;
		}
		
		public function get bytesTotal():Number
		{
			return 0;
		}
	}
}