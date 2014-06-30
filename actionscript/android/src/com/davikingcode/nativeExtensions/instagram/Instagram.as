package com.davikingcode.nativeExtensions.instagram {

	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.geom.Point;

	public class Instagram extends EventDispatcher {

		private static var _instance:Instagram;

		public var extensionContext:ExtensionContext;

		protected var tmp:BitmapData = null;

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

			tmp = new BitmapData(bmp.width, bmp.height, false, 0xFFFFFF);
			tmp.copyChannel(bmp, bmp.rect, new Point(0,0), BitmapDataChannel.BLUE, BitmapDataChannel.RED);
			tmp.copyChannel(bmp, bmp.rect, new Point(0,0), BitmapDataChannel.GREEN, BitmapDataChannel.GREEN);
			tmp.copyChannel(bmp, bmp.rect, new Point(0,0), BitmapDataChannel.RED, BitmapDataChannel.BLUE);

			extensionContext.call("shareToInstagram", tmp);
		}
	}
}