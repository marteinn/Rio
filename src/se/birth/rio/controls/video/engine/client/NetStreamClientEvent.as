package se.birth.rio.controls.video.engine.client
{
	import flash.events.Event;
	
	public class NetStreamClientEvent extends Event
	{
		
		// common calls	
		public static const ON_IMAGE_DATA:String = "onImageData";
		public static const ON_META_DATA:String = "onMetaData";
		public static const ON_PLAY_STATUS:String = "onPlayStatus";
		public static const ON_TEXT_DATA:String = "onTextData";
		public static const ON_X_M_P_DATA:String = "onXMPData";
		public static const ON_CUE_POINT:String = "onCuePoint";
		public static const ON_D_R_M_CONTENT_DATA:String = "onDRMContentData";
		
		// and for the not-so-common
		public static const UNKNOWN_CALL:String = "unknownCall";

		public var name:String;
		public var arguments:Array;
		
		public function NetStreamClientEvent(type:String, arguments:Array, name:String = "" )
		{
			super(type, bubbles, cancelable);
			
			this.name = name;
			this.arguments = arguments;
		}
		
	}
}