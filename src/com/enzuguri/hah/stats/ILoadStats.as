package com.enzuguri.hah.stats 
{

	import flash.events.Event;
	/**
	 * @author alex
	 */
	public interface ILoadStats 
	{
		function updateOnEvent(event:Event):void;
		
		function merge(...stats):void;
		
		function get weight() : Number;
	}
}
