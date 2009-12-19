package com.enzuguri.hah 
{
	import com.enzuguri.hah.stats.LoadStatsBase;
	import com.enzuguri.hah.events.HAHEvent;
	import com.enzuguri.hah.factory.LoadFactory;
	import com.enzuguri.hah.loader.ILoadable;
	import com.enzuguri.hah.loader.ILoadableQueue;
	import com.enzuguri.hah.loader.queue.QueueLoader;
	import com.enzuguri.hah.request.GroupRequest;
	import com.enzuguri.hah.request.ILoadRequest;
	import com.enzuguri.hah.request.LoadRequest;

	import flash.events.EventDispatcher;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;

	/**
	 * @author alex
	 */
	public class HAHLoader 
		extends EventDispatcher 
	{
		protected var itemCache : Dictionary;
		protected var queueLoader:ILoadableQueue;
		protected var factory:LoadFactory;
		
		private static var instance:HAHLoader;
		
		public function HAHLoader(singleTown:Boolean = false) 
		{
			itemCache = new Dictionary();
			factory = new LoadFactory(LoadStatsBase);
			initQueue();
			if (singleTown)
				instance = this;
		}
		
		public static function getInstance():HAHLoader
		{
			return instance || new HAHLoader(true);	
		}

		protected function initQueue() : void
		{
			queueLoader = new QueueLoader();
			queueLoader.addEventListener(HAHEvent.PARTIAL_COMPLETE, loader_partialCompleteHandler);
			queueLoader.addEventListener(HAHEvent.QUEUE_COMPLETE, loader_completeHandler);
		}
		
		private function loader_completeHandler(event : HAHEvent) : void
		{
			dispatchEvent(new HAHEvent(HAHEvent.QUEUE_COMPLETE, queueLoader));
			queueLoader.clearQueue();
			clearNoneCached();
		}
		
		private function clearNoneCached() : void
		{
			
		}

		private function loader_partialCompleteHandler(event : HAHEvent) : void
		{
			var loader:ILoadable = event.loader;
			
			if(loader)
			{
				var request:ILoadRequest = itemCache[loader.id];
				if (request)
					request.data = loader.content;
			}
			dispatchEvent(new HAHEvent(HAHEvent.PARTIAL_COMPLETE, event.loader));
		}

		public function addLoaderToQueue(loader : ILoadable) : void
		{
			queueLoader.addLoader(loader);
		}
		
		public function addLoadRequest(request:LoadRequest):ILoadable
		{
			var loader:ILoadable;
			// if not cached
			if(!itemCache[request.id])
			{
				itemCache[request.id] = request;
				loader = factory.createLoader(request, queueLoader);
			}
			else if(itemCache[request.id])
			{
				var cached:LoadRequest = itemCache[request.id];
				if(cached.cached)
				{
					if(cached.isComplete)
						request.clone(cached); //in this case there is no loader to return, event fires first
					else
						loader = queueLoader.getLoaderByID(cached.id) || factory.createLoader(cached, queueLoader);		
				}
				else
				{
					itemCache[request.id] = request;
					loader = factory.createLoader(request, queueLoader);
				}
			}
			
			
			return loader;
		}
		
		
		public function addURLReturnRequest(url:*, context:LoaderContext, id:String = "", cache:Boolean = true, 
			forceType:int = -1):LoadRequest
		{
			var request:LoadRequest = new LoadRequest(url, context, id, cache, forceType);
			addLoadRequest(request);
			return request;
		}

		public function addGroupRequest(request:GroupRequest):ILoadable
		{
			return factory.createLoader(request, queueLoader, false);
		}
		
		public function resume():void
		{
			queueLoader.resume();
		}
		
		public function stop():void
		{
			queueLoader.stop();
		}
		
		public function pause():void
		{
			queueLoader.pause();
		}
	}
}
