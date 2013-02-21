package se.birth.rio.controls.containers
{
	import flash.display.DisplayObject;
	
	public interface IBox
	{
		function addChild( child:DisplayObject ) : DisplayObject
		function addChildAt(child:DisplayObject, index:int):DisplayObject
		function removeChild( child:DisplayObject ) : DisplayObject
		function get numChildren():int
		function destroy () : Boolean;
		function set spacing ( value:Number ) : void;
		function get spacing() : Number;
	}
}