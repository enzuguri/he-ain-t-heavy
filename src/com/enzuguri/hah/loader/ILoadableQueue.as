package com.enzuguri.hah.loader 
{
	import com.enzuguri.hah.loader.ILoadable;
	
	/**
	 * @author alex
	 */
	public interface ILoadableQueue 
		extends ILoadable 
	{

		function getLoaderByID(id : String) : ILoadable;
		
		function addLoader(loader:ILoadable):void;
		
		function removeLoader(loader:ILoadable):void;
		
		function clearQueue():void;
		
		function get numItems():int;
	}
}
