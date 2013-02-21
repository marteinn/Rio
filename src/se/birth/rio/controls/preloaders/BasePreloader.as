/** 
 * 	MenuEvents: Extend BasePreloader when you want to create preloaders.
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	1
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.controls.preloaders
{
	import flash.display.DisplayObjectContainer;
	
	import se.birth.rio.core.BaseComponent;
	import se.birth.rio.core.IBaseComponent;
	
	public class BasePreloader extends BaseComponent implements IBaseComponent
	{
		protected var _progress:Number = 0;
		
		public function BasePreloader(parent:DisplayObjectContainer=null)
		{
			super(parent);
		}
		
		public function set progress ( value:Number ) : void
		{
			_progress = value;
			invalidate ();	
		}
		
		public function get progress ( ) : Number
		{
			return _progress;
		}

	}
}