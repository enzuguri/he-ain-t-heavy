package com.enzuguri.hah.example.a 
{
	import com.enzuguri.hah.request.ILoadRequest;
	import com.enzuguri.hah.events.HAHEvent;
	import com.enzuguri.hah.request.LoadRequest;
	import com.enzuguri.hah.HAHLoader;
	import flash.display.Sprite;

	/**
	 * @author alex
	 */
	public class ExampleA 
		extends Sprite 
	{
		public function ExampleA()
		{
			var loader:HAHLoader = HAHLoader.getInstance();
			
			var request:LoadRequest = new LoadRequest("http://www.google.com");
			request.addEventListener(HAHEvent.DATA_RECIEVED, request_dataRecieved);
			
			loader.addLoadRequest(request);
			loader.resume();
		}
		
		private function request_dataRecieved(event : HAHEvent) : void
		{
			var request:ILoadRequest = event.target as ILoadRequest;
			trace(request.data);
		}
	}
}
