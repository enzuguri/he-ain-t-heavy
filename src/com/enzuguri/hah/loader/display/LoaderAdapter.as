package com.enzuguri.hah.loader.display 
{
	import com.enzuguri.hah.stats.ILoadStats;

	import flash.system.LoaderContext;
	import flash.net.URLRequest;
	import com.enzuguri.hah.loader.ILoadable;
	import flash.display.Loader;

	/**
	 * @author alex
	 */
	public class LoaderAdapter 
		extends Loader
			implements ILoadable 
	{
		private var _id : String;
		private var _request : URLRequest;
		private var _context : LoaderContext;
		private var _stats : ILoadStats;

		public function LoaderAdapter(id:String, request:URLRequest, context:LoaderContext)
		{
			_context = context;
			_request = request;
			_id = id;
		}

		public function resume() : void
		{
			load(_request, _context);
		}

		public function pause() : void
		{
			close();
		}
		
		public function stop() : void
		{
			close();
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
