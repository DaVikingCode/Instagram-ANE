package com.davikingcode.nativeExtensions.instagram;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class InstagramExtension implements FREExtension
{

	public static InstagramExtensionContext context;

	@Override
	public FREContext createContext( String label )
	{
		return context = new InstagramExtensionContext();
	}

	@Override
	public void dispose()
	{
	}

	@Override
	public void initialize()
	{
	}
}
