package se.birth.rio.controls.video.engine
{
	import flash.display.DisplayObjectContainer;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import se.birth.net.NetStatusConstants;
	import se.birth.rio.controls.video.engine.client.NetStreamClient;
	import se.birth.rio.controls.video.engine.client.NetStreamClientEvent;
	import se.birth.rio.controls.video.engine.events.CuePointEvent;
	import se.birth.rio.controls.video.engine.events.EngineEvent;
	import se.birth.rio.controls.video.engine.events.EngineStatusEvent;
	import se.birth.rio.core.BaseComponent;
	import se.birth.rio.core.IBaseComponent;
	import se.birth.rio.utils.video.BuffertimeUtil;
	import se.birth.utils.DisplayObjectUtil;
	
	public class ProgressiveEngine extends BaseComponent implements IEngine, IBaseComponent
	{
		protected var netConnection:NetConnection;
		protected var netStream:NetStream;
		protected var client:NetStreamClient;
		protected var video:Video;
		
		protected var _hasMetaData:Boolean = false;
		protected var _smoothing:Boolean = true;
		protected var _url:String = "";
		protected var _duration:Number;
		protected var _videoDataRate:Number;
		protected var _bandwidth:Number;
		
		protected var _volume:Number = 1;
		
		public function ProgressiveEngine(parent:DisplayObjectContainer=null)
		{
			super(parent);
		}
		
		override protected function createChildren() : void
		{
			super.createChildren();
			
			client = new NetStreamClient();
			
			netConnection = new NetConnection();
			netConnection.connect( null );
			
			netStream = new NetStream( netConnection );
			netStream.addEventListener( AsyncErrorEvent.ASYNC_ERROR, netStream_asyncErrorHandler, false, 0, true );
			netStream.addEventListener( NetStatusEvent.NET_STATUS, netStream_netStatusHandler, false, 0, true );
			netStream.client = client;
			
			client.addEventListener( NetStreamClientEvent.CUE_POINT, client_cuePointHandler, false, 0, true );
			client.addEventListener( NetStreamClientEvent.META_DATA, client_metaDataHandler, false, 0, true );
			
			// TODO! Find a better way to deal with the flv width/height
			video = new Video( 1024, 768 );
			container.addChild( video );
		}
		
		override protected function draw(skipDispatch:Boolean=false) : Boolean
		{
			if( !super.draw() )
				return false;
			
			if( !hasSize )
				return false;
			
			if( _url == "" )
				return false;
			
			video.width = _width;
			video.height = _height;
			video.smoothing = _smoothing;
			
			return true;
		}
		
		public function load( url:String, autoStart:Boolean = true ) : void
		{
			if( _url == url )
				return;
			
			reset();
			
			_url = url;
			
			video.attachNetStream( netStream );	
			
			if( !isNaN(_duration) && !isNaN(_videoDataRate) && !isNaN(_bandwidth) )
			{
				bufferTime = BuffertimeUtil.calculate( _duration, _videoDataRate, _bandwidth );
			}
			else
			{
				bufferTime = 0;
				netStream.pause();
			}	
			
			netStream.play( url );
			
			if( !autoStart )
				pause ();
		}
		
		public function pause () : void
		{
			netStream.pause();
		}
		
		public function resume () : void
		{
			netStream.resume();
		}
		
		public function seek ( offset:Number ) : void
		{
			netStream.seek( offset ) ;
		}
		
		protected function reportTime ( event:Event ) : void
		{
			dispatchEvent( new EngineStatusEvent( EngineStatusEvent.TIME_UPDATE ) );
		}
		
		
		public function reset () : void
		{
			_url = "";
			
			_hasMetaData = false;
			
			_duration = NaN;
			_videoDataRate = NaN;
			
			netStream.pause();
			netStream.close();
			netConnection.close();
			removeEventListener( Event.ENTER_FRAME, reportTime );
			video.clear();
			container.removeChild( video );
			
			video = new Video( 1024, 768 );
			container.addChild( video );
			
			invalidate ();
		}
		
		override public function destroy( removedFromStage:Boolean = false ) : Boolean
		{
			if( _destroyed )
				return false;
			
			//
			reset ();
			
			netStream.removeEventListener( AsyncErrorEvent.ASYNC_ERROR, netStream_asyncErrorHandler );
			netStream.removeEventListener( NetStatusEvent.NET_STATUS, netStream_netStatusHandler );
			
			client.removeEventListener( NetStreamClientEvent.CUE_POINT, client_cuePointHandler );
			client.removeEventListener( NetStreamClientEvent.META_DATA, client_metaDataHandler );
			
			client = null;
			netConnection = null;
			netStream = null;
			video.clear();
			DisplayObjectUtil.removeAllChildren( container );
			video = null;
			
			if( !super.destroy(removedFromStage) )
				return false;
			
			return true;
		}
		
		
		/**
		 * Handlers
		 */
		
		protected function client_cuePointHandler ( event:NetStreamClientEvent ) : void
		{
			var infoObject:Object;
			
			infoObject = event.arguments[0];
			
			dispatchEvent( 
				new CuePointEvent( CuePointEvent.CUE_POINT, infoObject.name, infoObject.time, infoObject.cuetype )
			);
		}
		
		// TODO! Implement a cue point array (setter & getter)?
		protected function client_metaDataHandler ( event:NetStreamClientEvent ) : void
		{
			var infoObject:Object;
			
			if( event.arguments.length )
				infoObject = event.arguments[0];
			
			_hasMetaData = true;
			
			_duration = infoObject.duration;
			_videoDataRate = infoObject.videodatarate;
		}
		
		protected function netStream_asyncErrorHandler ( event:AsyncErrorEvent ) : void
		{
		}
		
		protected function netStream_netStatusHandler ( event:NetStatusEvent ) : void
		{
			switch( event.info.code )
			{
				case NetStatusConstants.NETSTREAM_PLAY_START:
					// start
					dispatchEvent( new EngineEvent( EngineEvent.START ) );
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
			
			dispatchEvent( new EngineStatusEvent( EngineStatusEvent.STATUS, false, false, event.info.code ) );
		}
		
		
		
		
		/**
		 * Getters & Setters
		 */
		
		public function get url ( ) : String
		{
			return _url;
		}
		
		public function set url ( value:String ) : void
		{
			load( value );
		}
		
		public function set videoSoundTransform ( value:SoundTransform ) : void
		{
			_volume = soundTransform.volume;
			netStream.soundTransform = soundTransform;
		}
		
		public function set volume ( value:Number ) : void
		{
			var soundTransform:SoundTransform = new SoundTransform( value );
			
			_volume = value;
			netStream.soundTransform = soundTransform;
		}
		
		public function get volume () : Number
		{
			return _volume;
		}
		
		public function get time() : Number
		{
			return netStream.time;
		}
		
		public function set bufferTime ( value:Number ) : void
		{
			netStream.bufferTime = value;
		}
		
		public function get bufferTime () : Number
		{
			return netStream.bufferTime;
		}
		
		
		public function get bufferLength () : Number
		{
			return netStream.bufferLength;
		}

		public function get duration():Number
		{
			return isNaN(_duration) ? -1 : _duration;
		}

		public function get videoDataRate():Number
		{
			return _videoDataRate;
		}
		
		public function set bandwidth ( value:Number ) : void
		{
			_bandwidth = value;
		}
		
		public function get bandwidth () : Number
		{
			return _bandwidth;
		}
		
		public function get bytesLoaded () : Number
		{
			return isNaN(netStream.bytesLoaded) ? 0 : netStream.bytesLoaded;
		}
		
		public function get bytesTotal () : Number
		{
			return isNaN(netStream.bytesTotal) ? 0 : netStream.bytesTotal;
		}


	}
}