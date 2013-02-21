/** 
 * 	ButtonStates: Wrapper class for button states.
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	1
 * 
 *	Copyright 2009, Birth Art & Development AB
 */


package se.birth.rio.controls.buttons
{
	public class ButtonStates
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
		public static const CLICK:uint = 1<<11;
		public static const ACTIVE:uint = 1<<12;

		public function getStateString ( state:uint ) : String
		{
			var stateString:String = "";
			
			if( state & NONE ) stateString += "NONE;";
			if( state & NORMAL ) stateString += "NORMAL;";
			if( state & UP ) stateString += "UP;";
			if( state & DOWN ) stateString += "DOWN;";
			if( state & ENABLED ) stateString += "ENABLED;";
			if( state & DISABLED ) stateString += "DISABLED;";
			if( state & SELECTED ) stateString += "SELECTED;";
			if( state & DESELECTED ) stateString += "DESELECTED;";
			if( state & MOUSE_WHEEL ) stateString += "MOUSE_WHEEL;";
			if( state & OVER ) stateString += "OVER;";
			if( state & OUT ) stateString += "OUT;";
			if( state & CLICK ) stateString += "CLICK;";
			
			return stateString;
		}
		
	}
}