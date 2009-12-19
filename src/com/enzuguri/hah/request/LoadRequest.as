package com.enzuguri.hah.request 
{
	import com.enzuguri.hah.process.IProcess;
	import com.enzuguri.hah.events.HAHEvent;
	import com.enzuguri.hah.type.HAHLoadType;

	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	/**
	 * @author alex
	 */
	public class LoadRequest 
		extends EventDispatcher
			implements ILoadRequest 
	{
		private var _request : URLRequest;
		private var _context : LoaderContext;
		private var _cached : Boolean;
		private var _id : String;
		private var _type : int;
		
		public var isComplete : Boolean;
		public var process:IProcess;
		
		private var _data : *;
		
		
		public function LoadRequest(url : *, context : LoaderContext = null, id : String = "", cached : Boolean = true, 
			type : int = -1)
		{
			_id = id;
			if(url is URLRequest)
				_request = url as URLRequest;
			else
				_request = new URLRequest(url);
				
			_context = context;
			_cached = cached;
			_id = id == "" ? _request.url : id;
			_type = type == -1 ? determineType(_request.url) : type;
		}
		
		public function clone(cached : LoadRequest) : void
		{
			_data = cached._data;
			if(_data)
				raiseRecievedEvent();
		}

		private function determineType(url : String) : int
		{
			var guess : int = HAHLoadType.STRING;
			
			if (/\.(jpg|jpeg|png|swf)/i.test(url))
				guess = HAHLoadType.DISPLAY_OBJECT;
			else if (/\.(flv)/.test(url))
				guess = HAHLoadType.NET_STREAM;
			else if (/\.(wav|mp3)/.test(url))		
				guess = HAHLoadType.SOUND;
				
			return guess;
		}

		public function get id() : String
		{
			return _id;
		}

		public function get type() : int
		{
			return _type;
		}

		public function get cached() : Boolean
		{
			return _cached;
		}

		public function get context() : LoaderContext
		{
			return _context;
		}

		public function get request() : URLRequest
		{
			return _request;
		}
		
		public function get data() : *
		{
			return _data;
		}
		
		public function set data(value : *) : void
		{
			_data = process ? process.process(value) : value;
			raiseRecievedEvent();
		}
		
		private function raiseRecievedEvent() : void
		{
			dispatchEvent(new HAHEvent(HAHEvent.DATA_RECIEVED));
		}
	}
}
