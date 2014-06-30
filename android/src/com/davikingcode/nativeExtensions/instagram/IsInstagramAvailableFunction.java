package com.davikingcode.nativeExtensions.instagram;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

public class IsInstagramAvailableFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext context, FREObject[] args)
    {
            try
            {
                 return FREObject.newObject(InstagramExtension.context.isInstagram());
            }
            catch (FREWrongThreadException e)
            {
            	e.printStackTrace();
            	return null;
            }
    }
}
