package se.birth.rio.controls.forms
{
	public interface IRadioButton
	{
		function set value( value:* ) : void;
		function get value() : *;
		
		function set selected ( value:Boolean ) : void;
		function get selected () : Boolean;
	}
}