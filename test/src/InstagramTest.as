package {

	import com.davikingcode.nativeExtensions.instagram.Instagram;
	import com.davikingcode.nativeExtensions.instagram.InstagramEvent;

	import flash.display.Sprite;

	[SWF(width='320', height='480', frameRate='30', backgroundColor='#000000')]

	public class InstagramTest extends Sprite {
		
		[Embed(source="/../../embed/logo.jpg")]
		private const DaVikingCodeLogo:Class;

		public function InstagramTest() {
			
			var instagram:Instagram = new Instagram();
			instagram.addEventListener(InstagramEvent.OK, _instagramEvt);
			
			if (instagram.isInstalled()) {
				
				instagram.share(new DaVikingCodeLogo().bitmapData, "my caption test");
			}
		}

		private function _instagramEvt(iEvt:InstagramEvent):void {
			
			if (iEvt.type == InstagramEvent.OK)
				trace("shared on instagram");
		}
	}
}