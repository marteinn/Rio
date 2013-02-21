/** 
 * 	ModelComponent: This class extends the BaseComponent class, and is used when working with model data. (Like menus etc).
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	1.1
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.core
{
	import flash.display.DisplayObjectContainer;

	public class ModelComponent extends BaseComponent
	{
		protected var _model:Object;
		protected var _modelClass:Class;
		
		public function ModelComponent(parent:DisplayObjectContainer=null, modelClass:Class = null )
		{
			super(parent);
			
			_modelClass = modelClass;
		}
		
		public function set model ( value:* ) : void
		{
			if( _modelClass !== null )
				if( value !== null && !(value is _modelClass) )
					throw new ArgumentError("Model value "+value+" is not an instance of "+_modelClass );
			
			_model = value;
			invalidate ();
		}
		
		public function get model ( ) : *
		{
			return _model;
		}
		

		override public function destroy( removedFromStage:Boolean = false ) : Boolean
		{
			if( _destroyed )
				return false;
			
			if( !super.destroy(removedFromStage) )
				return false;

			_model = null;

			return true;
		}
	}
}