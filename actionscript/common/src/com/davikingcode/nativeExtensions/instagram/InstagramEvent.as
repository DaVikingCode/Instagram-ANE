package com.davikingcode.nativeExtensions.instagram {

	import flash.events.Event;

	public class InstagramEvent extends Event {

		static public const OK:String = "OK";

		public function InstagramEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
	}
}
