package com.davikingcode.nativeExtensions.instagram;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Environment;

import com.adobe.fre.FREBitmapData;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;

public class InstagramExtensionContext extends FREContext
{

	public Intent shareIntent;
	public Bitmap bm =null;
	public FREBitmapData inputValue = null;

	@Override
	public void dispose()
	{
		cleardata();
		InstagramExtension.context = null;
	}

	@Override
	public Map<String, FREFunction> getFunctions()
	{
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
		functionMap.put("isInstagramAvailable", new IsInstagramAvailableFunction());
		functionMap.put("shareToInstagram", new SaveInstagramFunction());
		return functionMap;
	}

	public boolean isInstagram(){
		boolean installins = false;

		try {
			ApplicationInfo info = getActivity().getPackageManager().getApplicationInfo("com.instagram.android", 0);
			installins = true;
		} catch (NameNotFoundException e) {
			e.printStackTrace();
			installins = false;
		}
		
		return installins;
	}
	
	public void shareImageInstagram(String caption){
		
		String isok = "no";
		
		File fl = getTemporaryImageFile(".jpg");
		OutputStream os_ = null;
		try{
			os_ = new FileOutputStream(fl);
			this.bm.compress(Bitmap.CompressFormat.JPEG, 90, os_);
			os_.flush();
			os_.close();
			isok ="yes";
		} catch (FileNotFoundException e) {
	        e.printStackTrace();
	       
	    }catch (IOException e1) {
	       e1.printStackTrace();
	       
	    } catch (Exception e2){
	        e2.printStackTrace();
	    } finally{
			try {this.inputValue.release();} 
			catch (Exception e) {e.printStackTrace();} 
			catch (Error e) {e.printStackTrace();}
			finally{this.inputValue = null;}
			isok ="yes";
		}
		
		if(isok == "yes"){
			shareIntent = new Intent(android.content.Intent.ACTION_SEND);
			shareIntent.setType("image/*");
			shareIntent.putExtra(Intent.EXTRA_STREAM, Uri.parse("file://"+fl.getPath()));
			shareIntent.putExtra(Intent.EXTRA_TEXT, caption);
			shareIntent.setPackage("com.instagram.android");
	
			getActivity().startActivity(shareIntent);
			
		}
		
		cleardata();

		this.inputValue = null;
		this.bm = null;
		
		dispatchStatusEventAsync("OK", "status");
		
	}
	
	public void cleardata(){
		if(shareIntent!=null){
			try{
				shareIntent.removeExtra(Intent.EXTRA_STREAM);
			} 
			catch(Exception e){}
			catch(Error e){}
			
			try{
				getActivity().stopService(shareIntent);
			}
			catch(Exception e){}
			catch(Error e){}
		}
		shareIntent = null;
	}
	
	
	private File getTemporaryImageFile( String extension )
	{
		// Get or create folder for temp files
		File tempFolder = new File(Environment.getExternalStorageDirectory()+File.separator+"ShareWInstagramTmpFolder");
		if (!tempFolder.exists())
		{
			tempFolder.mkdir();
			try
			{
				new File(tempFolder, ".nomedia").createNewFile();
			}
			catch (Exception e) {}
		}

		return new File(tempFolder, String.valueOf(System.currentTimeMillis())+extension);
	}
}
