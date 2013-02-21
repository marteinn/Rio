/** 
 * 	LoaderUtil: Work in progress class for loader functions. Right now its focused on resetting and closing a loader.
 *   
 *	@author 	Martin Sandström
 * 	@company 	Birth Art & Development AB
 * 	@link 		http://www.birth.se
 * 	@version 	1.1
 * 
 *	Copyright 2009, Birth Art & Development AB
 */

package se.birth.rio.utils
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	
	public class LoaderUtil
	{
		public static function resetLoader ( loader:Loader ) : void
		{
			closeLoader ( loader );
			unloadLoader ( loader );
		}
		
		public static function closeLoader ( loader:Loader ) : void
		{
			try
			{
				loader.close();
			}
			catch (e:Error ) {};
		}
		
		public static function unloadLoader ( loader:Loader ) : void
		{
			var loaderInfo:LoaderInfo;
			
			if( loader != null )
			{					
				if( loader.content != null )
				{
					loaderInfo = loader.contentLoaderInfo;
					
					if( loaderInfo.childAllowsParent && loaderInfo.content is Bitmap )
					{
						(loaderInfo.content as Bitmap).bitmapData.dispose();
					}
					loader.unloadAndStop();
				}
			}
		}

		

	}
}