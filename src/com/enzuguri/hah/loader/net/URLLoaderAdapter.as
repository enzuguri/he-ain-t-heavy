package com.enzuguri.hah.loader.net 
{
	import com.enzuguri.hah.stats.ILoadStats;

	import flash.events.Event;
	import com.enzuguri.hah.loader.ILoadable;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author alex
	 */
	public class URLLoaderAdapter 
		extends URLLoader
			implements ILoadable 
	{
		private var _id : String;
		private var _request : URLRequest;
		private var _stats : ILoadStats;

		public function URLLoaderAdapter(id:String, request : URLRequest, format:String)
		{
			_request = request;
			dataFormat = format;
			_id = id;
			addEventListeners();
		}
		
		private function addEventListeners() : void
		{
			addEventListener(Event.COMPLETE, completeHandler);
			addEventListener(Event.OPEN, openHandler);
		}
		
		private function openHandler(event : Event) : void
		{
		}

		private function completeHandler(event : Event) : void
		{
		}

		public function resume() : void
		{
			load(_request);
		}

		public function pause() : void
		{
			close();
		}
		
		public function stop() : void
		{
			close();
		}
		
		public function get content() : *
		{
			return data;
		}

		public function get id() : String
		{
			return _id;
		}
		
		public function get stats() : ILoadStats
		{
			return _stats;
		}
		
		public function set stats(value : ILoadStats) : void
		{
			_stats = value;
		}
	}
}
