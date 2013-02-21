/** 
 * 	BuffertimeUtil: This class provides functions to calculate buffertime based on size, bitrate and bandwith for video.
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	1
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.utils.video
{
	public class BuffertimeUtil
	{
		public static function calculate( flvLength:Number, flvBitrate:Number, bandwidth:Number ) : Number 
		{	
			var bufferTime:Number;
			
			if( flvBitrate > bandwidth ) 
				bufferTime = Math.ceil(flvLength-flvLength/(flvBitrate/bandwidth));
			else
				bufferTime = 0;
			
			bufferTime += 3;
			
			return bufferTime;
		}
	}
}