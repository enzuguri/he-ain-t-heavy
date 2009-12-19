package com.enzuguri.hah.request 
{

	import com.enzuguri.hah.type.HAHLoadType;
	import flash.events.EventDispatcher;
	/**
	 * @author alex
	 */
	public class 
	GroupRequest
		extends EventDispatcher
			implements ILoadRequest 
	{

		public var group : Array;
		
		public function addRequest(request:*):void
		{
			
		}
		
		public function removeRequest(request:*):void
		{
		}
		
		public function get type() : int
		{
			return HAHLoadType.QUEUE;
		}
		
		public function get data() : *
		{
		}
		
		public function set data(value : *) : void
		{
		}
	}
}
