/** 
 * 	MenuStates: A wrapper class for Menu states. 
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	1
 * 
 *	Copyright 2010, Birth Art & Development AB
 */

package se.birth.rio.controls.menus
{
	public class MenuStates
	{
		public static const NONE:uint = 0;
		public static const NORMAL:uint = 1<<1;
		public static const UP:uint = 1<<2;
		public static const DOWN:uint = 1<<3;
		public static const ENABLED:uint = 1<<4;
		public static const DISABLED:uint = 1<<5;
		public static const SELECTED:uint = 1<<6;
		public static const DESELECTED:uint = 1<<7;
		public static const MOUSE_WHEEL:uint = 1<<8;
		public static const OVER:uint = 1<<9;
		public static const OUT:uint = 1<<10;
		public static const ACTIVE:uint = 1<<11;
		
	}
}