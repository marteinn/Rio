package se.birth.rio.controls.external
{
	public interface IExternalSWF
	{
		function start () : void;
		function pause () : void;
		function setSize ( width:Number, height:Number = 0 ) : void;
		// function setValue ( value:* ) : void;
		function destroy (removedFromStage:Boolean = false ) : Boolean;
	}
}