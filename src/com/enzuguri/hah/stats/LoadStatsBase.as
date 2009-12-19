package com.enzuguri.hah.stats 
{
	import flash.events.ProgressEvent;
	import flash.events.Event;

	/**
	 * @author alex
	 */
	public class LoadStatsBase 
		implements ILoadStats 
	{
		public var bytesLoaded:Number;
		public var bytesTotal:Number;
		public var percentage: Number;
		
		private var _weight : Number;

		public function LoadStatsBase(weight:Number = 1) 
		{
			_weight = weight;
			bytesLoaded = bytesTotal = percentage;
		}

		public function updateOnEvent(event : Event) : void
		{
			switch(event.type)
			{
				case ProgressEvent.PROGRESS:
					updateProgress(event as ProgressEvent);
					break;

					
				case Event.OPEN:
					updateOpen(event);
					break;	

					
				case Event.COMPLETE:
					updateComplete(event);
					break;	
			}
		}
		
		protected function updateComplete(event : Event) : void
		{
		}

		protected function updateOpen(event : Event) : void
		{
		}

		protected function updateProgress(event : ProgressEvent) : void
		{
			bytesLoaded = event.bytesLoaded;
			bytesTotal = event.bytesTotal;
			percentage = bytesLoaded / bytesTotal;
		}

		public function merge(...stats : *) : void
		{
			var items:Array = [].concat(stats);
			
			bytesLoaded = 0;
			bytesTotal = 0;
			percentage = 0;
			
			var length:int = items.length;
			var item:LoadStatsBase;
			for (var i : int = 0; i < length; i++) 
			{
				item = items[i];
				bytesLoaded += item.bytesLoaded;
				bytesTotal += item.bytesTotal;
				percentage += (item.bytesLoaded / item.bytesTotal) / length;
			}
		}
		
		public function get weight() : Number
		{
			return _weight;
		}
	}
}
