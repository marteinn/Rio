/** 
 * 	PositionUtil: The perfect class to position DisplayObjects
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
	
	import se.birth.rio.core.ComponentAlign;
	
	public class PositionUtil
	{
		public static function alignChild ( target:DisplayObject, width:Number, align:String ) : void
		{
			switch( align )
			{
				case ComponentAlign.CENTER:
					target.x = width/2-target.width/2;
					break;
				case ComponentAlign.RIGHT:
					target.x = width-target.width;
					break;
				case ComponentAlign.LEFT:
					target.x = 0;
					break;
					
				default:
					break;
			}
		}
		
		public static function valignChild ( target:DisplayObject, height:Number, valign:String ) : void
		{
			
			
			switch( valign )
			{
				case ComponentAlign.MIDDLE:
					target.y = height/2-target.height/2;
					break;
				case ComponentAlign.BOTTOM:
					target.y = height-target.height;
					break;
				case ComponentAlign.TOP:
					target.y = 0;
					break;
					
				default:
					break;
			}

		}

	}
}