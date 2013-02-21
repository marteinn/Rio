/** 
 * 	BaseImage: The best way to load and add interactivity to images.
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	2
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.controls.images
{
	import flash.display.Bitmap;
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
	import se.birth.rio.core.ComponentAlign;
	import se.birth.rio.core.ComponentScaleMode;
	import se.birth.rio.core.IBaseComponent;
	import se.birth.rio.utils.LoaderUtil;
	import se.birth.rio.utils.PositionUtil;
	import se.birth.rio.utils.RatioUtil;
	
	[Event(name="loadComplete", type="se.birth.rio.controls.images.ImageEvent")]
	[Event(name="loadInit", type="se.birth.rio.controls.images.ImageEvent")]
	[Event(name="imageIOError", type="se.birth.rio.controls.images.ImageEvent")]
	[Event(name="loadProgress", type="se.birth.rio.controls.images.ImageProgressEvent")]

	public class BaseImage extends BaseComponent implements IBaseComponent
	{

		protected var _url:String = "";
		
		protected var _useMask:Boolean = true;
		protected var _smoothing:Boolean = true;
		protected var _scaleMode:String = "";
		protected var _backgroundColor:uint = 0;
		protected var _backgroundAlpha:Number = 1;
		
		protected var _open:Boolean = false;
		protected var _loaded:Boolean = false;
		
		
		protected var loaderMask:Shape;
		protected var loaderContainer:Sprite;
		protected var loader:Loader;
		protected var loaderInf:LoaderInfo;
		protected var background:Shape;
		
		public function BaseImage(parent:DisplayObjectContainer=null)
		{
			super(parent);
		}

		override protected function init () : void
		{
			super.init();
			
			align = ComponentAlign.CENTER;
			valign = ComponentAlign.MIDDLE
		}
		
		override protected function createChildren () : void
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
			
			loaderInf = loader.contentLoaderInfo;

			loaderInf.addEventListener ( Event.OPEN, loader_openHandler, false, 0, true );
			loaderInf.addEventListener ( Event.INIT, loader_initHandler, false, 0, true );
			loaderInf.addEventListener ( ProgressEvent.PROGRESS, loader_progressHandler, false, 0, true );
			loaderInf.addEventListener ( Event.COMPLETE, loader_completeHandler, false, 0, true );
			loaderInf.addEventListener ( IOErrorEvent.IO_ERROR, loader_ioErrorHandler, false, 0, true );
		}
		
		override protected function draw(skipDispatch:Boolean=false) : Boolean
		{
			/*
			if( !hasSize )
				return false;
			*/
			
			if( !super.draw(skipDispatch) )
				return false;
				
			if( _useMask && hasSize )
			{
				loaderContainer.mask = loaderMask;
				updateMask ();
			}
			else
				loaderContainer.mask = null;
			// 
			
			if( hasSize )
				updateBackground ();
			
			if( _url.length && !_open && !_loaded )
				load( _url );
				
			if( _loaded )
			{
				updateSmoothing ();
				adjustImage ();
			}
			
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
		
		protected function load( url:String ) : void
		{
			loadRequest( new URLRequest( url ) );
		}
		
		protected function loadRequest ( urlRequest:URLRequest ) : void
		{
			if( !hasSize )
				return;
			
			// var loaderInfo:LoaderInfo;
			var loaderContex:LoaderContext;
			
			loaderContex = new LoaderContext( true );
			
			loader.load( urlRequest, loaderContex );
			
			_open = true;
		}
		
		protected function loader_openHandler( event:Event ) : void
		{
			dispatchEvent( new ImageEvent( ImageEvent.LOAD_INIT ) );
			
			// _open = true;
		}
		
		protected function loader_initHandler ( event:Event ) : void {}
		
		protected function loader_progressHandler ( event:ProgressEvent ) : void
		{
			dispatchEvent( 
				new ImageProgressEvent( 
					ImageProgressEvent.LOAD_PROGRESS, event.bytesLoaded, event.bytesTotal, false, false 
				) 
			);
		}
		
		protected function loader_completeHandler ( event:Event ) : void
		{			
			_open = false;
			_loaded = true;
			
			adjustImage ();
			updateSmoothing ();
			
			dispatchEvent( new ImageEvent( ImageEvent.LOAD_COMPLETE, false, false ) );
		}
		
		protected function adjustImage () : void
		{
			loaderContainer.scaleX =
			loaderContainer.scaleY = 1;
			
			// scale
			switch( _scaleMode )
			{
				case ComponentScaleMode.NO_SCALE:
					break;
					
				case ComponentScaleMode.STRETCH:
					loaderContainer.scaleX = 1/loaderContainer.width*_width;
					loaderContainer.scaleY = 1/loaderContainer.height*_height;
					break;
				
				case ComponentScaleMode.PROPORTIONAL_SCRETCH:
					loaderContainer.scaleX = 1/loaderContainer.width*_width;
					loaderContainer.scaleY = 1/loaderContainer.height*_height;
					
					if( loaderContainer.scaleX>loaderContainer.scaleY )
						loaderContainer.scaleY = loaderContainer.scaleX;
					else
						loaderContainer.scaleX = loaderContainer.scaleY	;
					break;
					
				case ComponentScaleMode.RATIO:
				default:				
					RatioUtil.resizeChild( loaderContainer, _width, _height );
					break;
			}
			
			PositionUtil.alignChild( loaderContainer, _width, _align );
			PositionUtil.valignChild( loaderContainer, _height, _valign );
			
			// position
		}
		
		protected function updateSmoothing ( ) : void
		{
			var loaderInfo:LoaderInfo;
			var imageBitmap:Bitmap;
			
			if( loader != null )
			{					
				if( loader.content != null )
				{
					loaderInfo = loader.contentLoaderInfo;
					
					if( loaderInfo.childAllowsParent && loaderInfo.content is Bitmap )
					{
						imageBitmap = loaderInfo.content as Bitmap
						imageBitmap.smoothing = _smoothing;
					}
				}
			}
		}
		
		protected function loader_ioErrorHandler ( event:IOErrorEvent ) : void
		{
			dispatchEvent( new ImageEvent( ImageEvent.IO_ERROR ) ); 
			
		}
		
		public function reset () : void
		{
			LoaderUtil.resetLoader( loader );

			loader.unloadAndStop();
			
			_open = false;
			_loaded = false;
			_url = "";
		}
		
		override public function destroy( removedFromStage:Boolean = false ) : Boolean
		{
			if( _destroyed )
				return false;
			
			reset ();
			
			loaderInf.removeEventListener ( Event.OPEN, loader_openHandler, false );
			loaderInf.removeEventListener ( Event.INIT, loader_initHandler, false );
			loaderInf.removeEventListener ( ProgressEvent.PROGRESS, loader_progressHandler );
			loaderInf.removeEventListener ( Event.COMPLETE, loader_completeHandler, false );
			loaderInf.removeEventListener ( IOErrorEvent.IO_ERROR, loader_ioErrorHandler );
			
			while( container.numChildren )
				container.removeChildAt( 0 );
				
			loaderInf = null;
			
			if( !super.destroy(removedFromStage) )
				return false;
				
			return true;
		}
		
		
		
		
		/*
		 * Getters & Setters
		 */
		
		public function set url ( value:String ) : void
		{
			if( value == _url )
				return;
			
			reset ();
			
			_url = value;
			invalidate ();
		}
		
		public function get url () : String
		{
			return _url;
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
		
		public function set smoothing ( value:Boolean ) : void
		{
			_smoothing = value;
			invalidate ();
		}
		
		public function get smoothing () : Boolean
		{
			return _smoothing;
		}
		
		public function set scaleMode ( value:String ) : void
		{
			_scaleMode = value;
			invalidate ();
		}
		
		public function get scaleMode () : String
		{
			return _scaleMode;
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


		public function get loaded():Boolean
		{
			return _loaded;
		}

		public function set loaded(value:Boolean):void
		{
			_loaded = value;
		}

		
		public function get open():Boolean
		{
			return _open;
		}
		
		public function set open(value:Boolean):void
		{
			_open = value;
		}
		
	}
}