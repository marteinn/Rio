package se.birth.rio.controls.forms
{
	public interface IFormElement
	{
		function set value( value:* ) : void;
		function get value( ) : *;
		
		function set name ( value:String ) : void;
		function get name () : String;
	}
}