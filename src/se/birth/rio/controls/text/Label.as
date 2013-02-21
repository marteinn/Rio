/** 
 * 	Label: The main class when working with text in rio.
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	2
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.controls.text
{
	import flash.display.DisplayObjectContainer;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import se.birth.rio.core.BaseComponent;
	import se.birth.rio.core.IBaseComponent;
	import se.birth.rio.utils.PositionUtil;

	public class Label extends BaseComponent implements IBaseComponent
	{
		protected var field:TextField;
		
		protected var _text:String;
		
		protected var _antiAliasType:String;
		protected var _textFormat:TextFormat;
		protected var _multiline:Boolean = false;
		protected var _selectable:Boolean = false;
		protected var _embedFonts:Boolean = false;
		protected var _autoSize:String = TextFieldAutoSize.NONE;
		protected var _wordWrap:Boolean = false;
		
		public function Label(parent:DisplayObjectContainer=null)
		{
			super(parent);
		}
		
		override protected function init () : void
		{
			super.init();
			
			_antiAliasType = AntiAliasType.ADVANCED;
		}
		
		override protected function createChildren () : void
		{
			super.createChildren();
			
			field = new TextField ();
			container.addChild( field );
		}
		
		override protected function draw(skipDispatch:Boolean=false) : Boolean
		{
			if( _text == null )
				return false;
			
			if( !super.draw() )
				return false;
			
			field.width = _width;
			field.height = _height;
			field.antiAliasType = AntiAliasType.ADVANCED;
			field.multiline = _multiline;
			field.selectable = _selectable;
			field.embedFonts = _embedFonts;
			field.autoSize = _autoSize;
			field.wordWrap = _wordWrap;
			
			render ();
			applyText ();
			
			if( !_wordWrap )
			{
				PositionUtil.alignChild( field, _width, _align );
				PositionUtil.valignChild( field, _height, _valign );
			}
			
			if( _debug )
			{
				field.border = true;
				field.selectable = true;
				container.graphics.clear();
				container.graphics.beginFill( 0xFF0000, .5 );
				container.graphics.drawRect( 0,0, _width, _height );
				container.graphics.endFill();
			}
			
			return true;	
		}
		
		protected function applyText () : void
		{
			field.text = _text;
		}
		
		protected function render () : void
		{
			if( _textFormat == null )
				return;
			
			field.defaultTextFormat = _textFormat;
			field.setTextFormat( _textFormat );
		}
		
		override public function destroy ( removedFromStage:Boolean = false ) : Boolean
		{
			if( _destroyed )
				return false;
			
			field = null;
			
			if( !super.destroy(removedFromStage) )
				return false;
				
			return true;
			
		}
		
		/**
		 * Getters & Setters
		 **/		
		
		public function set text ( value:String ) : void
		{
			_text = value;
			invalidate ();
		}
		
		public function get text () : String
		{
			return _text;
		}
		
		public function set antiAliasType ( value:String ) : void
		{
			_antiAliasType = value;
			invalidate ();
		}
		
		public function get antiAliasType () : String
		{
			return _antiAliasType;
		}
		
		public function set textFormat ( value:TextFormat ) : void
		{
			_textFormat = value;
			invalidate ();
		}
		
		public function get textFormat () : TextFormat
		{
			return _textFormat;
		}
		
		public function set multiline ( value:Boolean ) : void
		{
			_multiline = value;
			invalidate ();
		}
		
		public function get multiline () : Boolean
		{
			return _multiline;
		}
		
		public function set selectable ( value:Boolean ) : void
		{
			_selectable = value;
			invalidate ();
		}
		
		public function get selectable () : Boolean
		{
			return _selectable;
		}
		
		public function set embedFonts ( value:Boolean ) : void
		{
			_embedFonts = value;
			invalidate ();
		}
		
		public function get embedFonts () : Boolean
		{
			return _embedFonts;
		}
		
		public function set autoSize ( value:String ) : void
		{
			_autoSize = value;
			invalidate ();
		}
		
		public function get autoSize () : String
		{
			return _autoSize;
		}
		
		public function set wordWrap ( value:Boolean ) : void
		{
			_wordWrap = value;
			invalidate ();
		}
		
		public function get wordWrap () : Boolean
		{
			return _wordWrap;
		}
		
		public function get textWidth () : Number
		{
			return field.textWidth;
		}
		
		public function get textHeight () : Number
		{
			return field.textHeight;
		}
		
	}
}