Instagram-ANE
=============

Based on [Sharkhack](https://github.com/sharkhack) Instagram's ANEs. We wanted to have a default implementation for iOS & Android into the same ANE.

```actionscript3
var instagram:Instagram = new Instagram();

if (instagram.isInstalled())
	instagram.share(new DaVikingCodeLogo().bitmapData, "my caption test");
```

On Android we use directly the bitmapData whereas on iOS we turn it into a ByteArray. You may use a third argument for the compressor. Default is `new JPEGEncoderOptions();`

Also on Android be sure to add this permission (the picture need to be saved on disk):
`<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />`
