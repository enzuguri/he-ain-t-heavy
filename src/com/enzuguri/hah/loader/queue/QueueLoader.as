package com.enzuguri.hah.loader.queue 
{
	import com.enzuguri.hah.stats.ILoadStats;
	import com.enzuguri.hah.loader.ILoadable;
	import com.enzuguri.hah.loader.ILoadableQueue;

	import flash.events.EventDispatcher;

	/**
	 * @author alex
	 */
	public class QueueLoader 
		extends EventDispatcher 
			implements ILoadableQueue 
	{
		private var _stats : ILoadStats;
		
		public function QueueLoader(...items)
		{
		}
		
		public function addLoader(loader : ILoadable) : void
		{
		}
		
		public function removeLoader(loader : ILoadable) : void
		{
		}
		
		public function clearQueue() : void
		{
		}
		
		public function resume() : void
		{
		}
		
		public function pause() : void
		{
		}
		
		public function stop() : void
		{
		}
		
		public function get content() : *
		{
		}
		
		public function get id() : String
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		public function get numItems() : int
		{
			// TODO: Auto-generated method stub
			return 0;
		}
		
		public function getLoaderByID(id : String) : ILoadable
		{
			// TODO: Auto-generated method stub
			return null;
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
