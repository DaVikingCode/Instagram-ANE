package com.davikingcode.nativeExtensions.instagram {

	import flash.display.BitmapData;
	import flash.display.JPEGEncoderOptions;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.utils.ByteArray;

	public class Instagram extends EventDispatcher {

		private static var _instance:Instagram;

		public var extensionContext:ExtensionContext;

		public static function getInstance():Instagram {
			return _instance;
		}

		public function Instagram() {

			_instance = this;

			extensionContext = ExtensionContext.createExtensionContext("com.davikingcode.nativeExtensions.Instagram", null);

			if (!extensionContext)
				throw new Error( "Instagram native extension is not supported on this platform." );

			extensionContext.addEventListener(StatusEvent.STATUS, _onStatus);
		}

		private function _onStatus(sEvt:StatusEvent):void {

			switch (sEvt.code) {

				case InstagramEvent.OK:
					dispatchEvent(new InstagramEvent(InstagramEvent.OK));	
					break;
			}

		}

		public function isInstalled():Boolean {
			return extensionContext.call("isInstagramAvailable");
		}

		public function share(bmp:BitmapData, caption:String = "", compressor:Object = null):void {

			if (!compressor)
				compressor = new JPEGEncoderOptions();

			var byte:ByteArray = new ByteArray();
			byte = bmp.encode(bmp.rect, compressor, byte);

			extensionContext.call("shareToInstagram", byte, caption);
		}
	}
}