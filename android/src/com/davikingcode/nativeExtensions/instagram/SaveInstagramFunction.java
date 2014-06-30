package com.davikingcode.nativeExtensions.instagram;

import android.graphics.Bitmap;
import android.graphics.Bitmap.Config;

import com.adobe.fre.FREBitmapData;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class SaveInstagramFunction implements FREFunction {
	
	@Override
	public FREObject call(FREContext context, FREObject[] passedArgs) 
	{	
		
		try {

			InstagramExtension.context.inputValue = (FREBitmapData)passedArgs[0];
			InstagramExtension.context.inputValue.acquire();
			int srcWidth = InstagramExtension.context.inputValue.getWidth();
			int srcHeight =InstagramExtension.context.inputValue.getHeight();
			
			InstagramExtension.context.inputValue.release();
			InstagramExtension.context.inputValue.acquire();
			
			if(srcWidth>0){
				InstagramExtension.context.bm = Bitmap.createBitmap(srcWidth, srcHeight, Config.ARGB_8888);
				InstagramExtension.context.bm.copyPixelsFromBuffer( InstagramExtension.context.inputValue.getBits() );
				
				InstagramExtension.context.shareImageInstagram();
			} else {
				
				InstagramExtension.context.cleardata();
			}

		} catch (Exception e) {
			e.printStackTrace();
			InstagramExtension.context.cleardata();
			InstagramExtension.context.dispatchStatusEventAsync("ok", "status");
		}
		catch (Error e){
			
			e.printStackTrace(); 
			InstagramExtension.context.cleardata();
			InstagramExtension.context.dispatchStatusEventAsync("ok", "status");
		}
		finally{
			                       
		}

		
		return null;
	}
}
