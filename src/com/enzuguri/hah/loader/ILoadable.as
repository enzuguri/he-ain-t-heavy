package com.enzuguri.hah.loader 
{

	import com.enzuguri.hah.stats.ILoadStats;
	import flash.events.IEventDispatcher;
	/**
	 * @author alex
	 */
	public interface ILoadable
		extends IEventDispatcher 
	{
		function get stats() : ILoadStats;
		function set stats(value: ILoadStats):void;
		
		function resume():void;
		
		function pause():void;
		
		function stop():void;
		
		function get content():*;
		
		function get id():String;
	}
}
