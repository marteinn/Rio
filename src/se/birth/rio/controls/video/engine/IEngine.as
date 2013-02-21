package se.birth.rio.controls.video.engine
{
	import flash.events.Event;

	public interface IEngine
	{
		/**
		 * Engine specific methods/properties
		 */
		function pause():void;
		function reset():void;
		function load(url:String, autoStart:Boolean = true):void;
		function resume():void;
		function seek(offset:Number):void;
		
		function get url():String;
		function get duration():Number;
		
		function set volume(value:Number):void;
		function get volume():Number;
		
		function get time():Number;
		
		function get bytesLoaded () : Number;
		function get bytesTotal () : Number;
		
		/**
		 * From BaseComponent
		 */
		function setSize (w:Number, h:Number = 0) : void;
		function destroy (removedFromStage:Boolean) : Boolean;
		
		/**
		 * From DisplayObject
		 */
		function set x (value:Number) : void;
		function get x () : Number;
		function set y (value:Number) : void;
		function get y () : Number;
		function set alpha (value:Number) : void;
		function get alpha () : Number;
		
		
		/**
		 * EventDispatcher related
		 */
		function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0
										  , useWeakListener:Boolean = true ) : void;
		function dispatchEvent( event:Event ) : Boolean;
		function hasEventListener( type:String ) : Boolean;
		function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ) : void;
	}
}