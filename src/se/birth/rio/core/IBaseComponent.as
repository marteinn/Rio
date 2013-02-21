/** 
 * 	IBaseComponent: A interface for Rio components, makes typing functions faster and more loose ways to deal with components.
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	1
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.core
{
	public interface IBaseComponent
	{
		function setSize (w:Number,h:Number=0) : void;
		function destroy (removedFromStage:Boolean = false) : Boolean;
		function invalidateNow () : void;
		function invalidate () : void;
	}
}