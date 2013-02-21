/** 
 * 	PositionUtil: The perfect class to resize DisplayObjects
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	1
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.utils
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	public class RatioUtil
	{
		public static function resizeChild ( child:DisplayObject, width:Number, height:Number ) : void
		{
			var metrics:Rectangle = RatioUtil.resizeMetrics( child.width, child.height, width, height );
			
			child.scaleX = child.scaleX/child.width*metrics.width;
			child.scaleY = child.scaleY/child.height*metrics.height;
		}
		
		
		public static function resizeMetrics ( width:Number, height:Number, mWidth:Number, mHeight:Number ) : Rectangle
		{
			var wScale:Number = 1;
			var hScale:Number = 1;
			
			if( wScale*width>mWidth )
			{
				hScale = wScale = wScale/(wScale*width)*mWidth;
			}
			
			if( hScale*height>mHeight )
			{
				wScale = hScale = hScale/(hScale*height)*mHeight;
			}
			
			return new Rectangle( 0, 0, wScale*width, hScale*height );
		}
	}
}