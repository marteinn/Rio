package se.birth.rio.controls.external
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	import se.birth.rio.core.BaseComponent;
	import se.birth.rio.core.IBaseComponent;
	import se.birth.rio.utils.LoaderUtil;
	import se.birth.utils.DisplayObjectUtil;
	
	[Event(name="loadComplete", type="se.birth.rio.controls.external.ExternalSWFEvent")]
	[Event(name="loadInit", type="se.birth.rio.controls.external.ExternalSWFEvent")]
	[Event(name="loadProgress", type="se.birth.rio.controls.external.ExternalSWFProgressEvent")]
	[Event(name="externalSWFIOError", type="se.birth.rio.controls.external.ExternalSWFEvent")]
	
	public class ExternalSWF extends BaseComponent implements IBaseComponent
	{

		protected var _url:String;
		protected var _open:Boolean = false;
		protected var _useMask:Boolean = true;
		protected var _loaded:Boolean = false;
		protected var _backgroundColor:uint = 0;
		protected var _backgroundAlpha:Number = 1;
		
		protected var loaderMask:Shape;
		protected var loaderContainer:Sprite;
		protected var loader:Loader;
		protected var loaderInf:LoaderInfo;
		protected var background:Shape;
		protected var externalContent:IExternalSWF;
		
		public function ExternalSWF(parent:DisplayObjectContainer=null)
		{
			super(parent);
		}
		
		override protected function createChildren() : void
		{
			super.createChildren();
			
			background = new Shape ();
			container.addChild( background );
			
			loaderContainer = new Sprite ();
			container.addChild( loaderContainer );
			
			loaderMask = new Shape ();
			container.addChild( loaderMask );
			
			loader = new Loader( );
			loaderContainer.addChild( loader );
		}
		
		override protected function draw(skipDispatch:Boolean=false) : Boolean
		{
			var loaderInf:LoaderInfo;
			
			if( !hasSize )
				return false;
			
			if( !super.draw( skipDispatch ) )
				return false;
			
			if( !loader.loaderInfo.hasEventListener( Event.OPEN ) )
			{
				loaderInf = loader.contentLoaderInfo;
				
				loaderInf.addEventListener ( Event.OPEN, loader_openHandler, false, 0, true );
				loaderInf.addEventListener ( Event.INIT, loader_initHandler, false, 0, true );
				loaderInf.addEventListener ( ProgressEvent.PROGRESS, loader_progressHandler, false, 0, true );
				loaderInf.addEventListener ( Event.COMPLETE, loader_completeHandler, false, 0, true );
				loaderInf.addEventListener ( IOErrorEvent.IO_ERROR, loader_ioErrorHandler, false, 0, true );
			}
			
			if( _useMask )
			{
				loaderContainer.mask = loaderMask;
				updateMask ();
			}
			else
				loaderContainer.mask = null;
			// 
			
			updateBackground ();
			
			if( _url.length && !_open && !_loaded )
				load( _url );
			
			return true;
		}
		
		protected function updateMask () : void
		{
			loaderContainer.mask = loaderMask;
			
			loaderMask.graphics.clear ();	
			loaderMask.graphics.beginFill( 0, 1 );
			loaderMask.graphics.drawRect( 0, 0, _width, _height );
			loaderMask.graphics.endFill ();
		}
		
		protected function updateBackground () : void
		{
			background.graphics.clear ();	
			background.graphics.beginFill( _backgroundColor, _backgroundAlpha );
			background.graphics.drawRect( 0, 0, _width, _height );
			background.graphics.endFill ();
		}
		
		public function set url ( value:String ) : void
		{
			if( value == _url )
				return;
			
			reset ();
			
			_url = value;
			invalidate ();
		}
		
		protected function load( url:String ) : void
		{
			loadRequest( new URLRequest( url ) );
		}
		
		protected function loadRequest ( urlRequest:URLRequest ) : void
		{
			if( !hasSize )
				return;
			
			var loaderContex:LoaderContext;
			
			externalContent = null;

			loaderContex = new LoaderContext( true ); 
			loader.load( urlRequest, null );
			
			_open = true;
		}
		
		protected function loader_openHandler( event:Event ) : void
		{
			dispatchEvent( new ExternalSWFEvent( ExternalSWFEvent.LOAD_INIT ) );
		}
		
		protected function loader_initHandler ( event:Event ) : void 
		{
		}
		
		protected function loader_progressHandler ( event:ProgressEvent ) : void
		{
			dispatchEvent( new ExternalSWFProgressEvent( ExternalSWFProgressEvent.LOAD_PROGRESS
				, event.bytesLoaded, event.bytesTotal ) );
		}
		
		protected function loader_completeHandler ( event:Event ) : void
		{			
			_open = false;
			_loaded = true;
			
			if( loader.content is IExternalSWF )
			{
				externalContent = loader.content as IExternalSWF;
				externalContent.setSize( _width, _height );
				externalContent.start();
			}
			
			dispatchEvent( new ExternalSWFEvent( ExternalSWFEvent.LOAD_COMPLETE, false, false ) );
		}
		
		protected function loader_ioErrorHandler ( event:IOErrorEvent ) : void
		{
			dispatchEvent( new ExternalSWFEvent( ExternalSWFEvent.IO_ERROR ) ); 
		}
		
		protected function reset () : void
		{
			LoaderUtil.resetLoader( loader );
			
			_open = false;
			_loaded = false;
		}
		
		override public function destroy( removedFromStage:Boolean = false ) : Boolean
		{
			if( _destroyed )
				return false;
			
			reset ();
			
			if( externalContent != null )
				externalContent.destroy();
			
			var loaderInf:LoaderInfo;
			
			loaderInf = loader.contentLoaderInfo;
			
			loaderInf.removeEventListener ( Event.OPEN, loader_openHandler, false );
			loaderInf.removeEventListener ( Event.INIT, loader_initHandler, false );
			loaderInf.removeEventListener ( ProgressEvent.PROGRESS, loader_progressHandler );
			loaderInf.removeEventListener ( Event.COMPLETE, loader_completeHandler, false );
			loaderInf.removeEventListener ( IOErrorEvent.IO_ERROR, loader_ioErrorHandler );
			
			DisplayObjectUtil.removeAllChildren( container );
			
			loaderInf = null;
			externalContent = null;
			
			if( !super.destroy(removedFromStage) )
				return false;
			
			return true;
		}
		
		public function set useMask ( value:Boolean ) : void
		{
			_useMask = value;
			invalidate ();
		}
		
		public function get useMask () : Boolean
		{
			return _useMask;
		}
		
		public function set backgroundColor ( value:uint ) : void
		{
			_backgroundColor = value;
			invalidate ();
		}
		
		public function get backgroundColor () : uint
		{
			return _backgroundColor;
		}
		
		public function set backgroundAlpha ( value:Number ) : void
		{
			_backgroundAlpha = value;
			invalidate ();
		}
		
		public function get backgroundAlpha () : Number
		{
			return _backgroundAlpha;
		}
	}
}