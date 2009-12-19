package com.enzuguri.hah.request 
{

	import flash.events.IEventDispatcher;
	/**
	 * @author alex
	 */
	public interface ILoadRequest
		extends IEventDispatcher 
	{
		
		function get type() : int;
		
		function get data():*;
		
		function set data(value:*):void;
	}
}
