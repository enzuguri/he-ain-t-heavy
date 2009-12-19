package com.enzuguri.hah.factory 
{
	import com.enzuguri.hah.stats.ILoadStats;
	import com.enzuguri.hah.loader.ILoadable;
	import com.enzuguri.hah.loader.ILoadableQueue;
	import com.enzuguri.hah.loader.net.URLLoaderAdapter;
	import com.enzuguri.hah.loader.queue.QueueLoader;
	import com.enzuguri.hah.request.GroupRequest;
	import com.enzuguri.hah.request.ILoadRequest;
	import com.enzuguri.hah.request.LoadRequest;
	import com.enzuguri.hah.type.HAHLoadType;

	import flash.net.URLLoaderDataFormat;

	/**
	 * @author alex
	 */
	public class LoadFactory 
	{
		
		public var statsClass:Class;
		
		
		public function LoadFactory(defaultStats:Class = null) 
		{
			statsClass = defaultStats;
		}

		private function createStats():ILoadStats
		{
			return new statsClass();
		}

		protected function flattenRequest(request : GroupRequest, loadQueue:ILoadableQueue) : Array
		{
			var queue:Array = request.group;
			
			var length:int = queue.length;
			var item:ILoadRequest;
			for (var i : int = 0; i < length; i++) 
			{
				item = queue[i];
				if(item is GroupRequest)
					queue[queue.length] = createLoader(item, loadQueue, false);
				else
					queue[queue.length] = createLoader(item, loadQueue);	
			}
			
			return queue;
		}




		public function createLoader(request:ILoadRequest, loadQueue:ILoadableQueue, add:Boolean = true) : ILoadable
		{
			var loader:ILoadable;
			
			var singleRequest:LoadRequest = request as LoadRequest;
			var groupRequest:GroupRequest = request as GroupRequest;
			
			switch(request.type)
			{
				case HAHLoadType.QUEUE:
					loader = new QueueLoader(flattenRequest(groupRequest, loadQueue));
					break;
				
				case HAHLoadType.DISPLAY_OBJECT:
				
					break;


				case HAHLoadType.NET_STREAM:
				
					break;


				case HAHLoadType.SOUND:
				
					break;


				case HAHLoadType.BINARY:
					loader = new URLLoaderAdapter(singleRequest.id, singleRequest.request, URLLoaderDataFormat.BINARY);
					break;
					
				default:
					loader = new URLLoaderAdapter(singleRequest.id, singleRequest.request, URLLoaderDataFormat.TEXT);
					break;	
			}
			
			if(loader)
			{
				loader.stats = createStats();
				if(add)
					loadQueue.addLoader(loader);
			}
			
			return loader;
		}
	}
}
