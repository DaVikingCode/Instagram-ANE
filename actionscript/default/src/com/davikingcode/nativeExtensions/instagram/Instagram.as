package com.davikingcode.nativeExtensions.instagram {

	import flash.display.BitmapData;
	import flash.events.EventDispatcher;

	public class Instagram extends EventDispatcher {

		private static var _instance:Instagram;

		public static function getInstance():Instagram {
			return _instance;
		}

		public function Instagram() {

			_instance = this;
		}

		public function isInstalled():Boolean {
			return false;
		}

		public function share(bmp:BitmapData, caption:String = "", compressor:Object = null):void {
		}
	}
}