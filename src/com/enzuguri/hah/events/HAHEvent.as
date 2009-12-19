package com.enzuguri.hah.events 
{
	import com.enzuguri.hah.loader.ILoadable;
	import flash.events.Event;

	/**
	 * @author alex
	 */
	public class HAHEvent 
		extends Event 
	{
		public static const PARTIAL_COMPLETE:String = "partialComplete";
		public static const QUEUE_COMPLETE:String = "queueComplete";
		public static const DATA_RECIEVED : String = "dataRecieved";
		
		
		public var loader : ILoadable;

		
		public function HAHEvent(type : String, loader:ILoadable = null)
		{
			this.loader = loader;
			super(type);
		}

		override public function clone() : Event
		{
			return new HAHEvent(type, loader);
		}
	}
}
