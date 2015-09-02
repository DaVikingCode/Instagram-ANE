//
//  InstagramIosExtension.m
//  InstagramIosExtension
//
//  Created by Aymeric Lamboley on 30/06/2014.
//  Copyright (c) 2014 DaVikingCode. All rights reserved.
//

#import "FlashRuntimeExtensions.h"
#import "InstagramIosExtension.h"
#import "InstagramQueries.h"

#define DEFINE_ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
#define MAP_FUNCTION(fn, data) { (const uint8_t*)(#fn), (data), &(fn) }

FREContext InstagramCtx = nil;

@implementation InstagramIosExtension

static InstagramIosExtension *sharedInstance = nil;

+ (InstagramIosExtension *)sharedInstance
{
    if (sharedInstance == nil)
    {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [InstagramIosExtension sharedInstance];
}

- (id)copy
{
    return self;
}

- (UIAlertView*) notInstalledAlert
{
    return [[UIAlertView alloc] initWithTitle:@"Instagram Not Installed!" message:@"Instagram must be installed on the device in order to post images" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
}

- (BOOL) isAvailable{
    return [InstagramQueries isAppInstalled];
}
- (void) shareImage:(UIImage*) image withCaption:(NSString *)caption
{
    
    if ([InstagramQueries isAppInstalled]){
        UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        [InstagramQueries postImage:image withCaption:caption inView:rootViewController.view];
        
        FREDispatchStatusEventAsync(InstagramCtx, (const uint8_t *)"OK", (const uint8_t *)"");
    }
    else{
        [self.notInstalledAlert show];
    }
}

@end

NSData *toNSDataByteArray(FREObject *ba)
{
    FREByteArray byteArray;
    FREAcquireByteArray(ba, &byteArray);
    
    NSData *d = [NSData dataWithBytes:(void *)byteArray.bytes length:(NSUInteger)byteArray.length];
    FREReleaseByteArray(ba);
    
    return d;
}

FREObject toBOOLToFREObject(BOOL boolean)
{
    FREObject result;
    FRENewObjectFromBool(boolean, &result);
    return result;
}
NSString * toFREObjectToNSString(FREObject object)
{
    uint32_t stringLength;
    const uint8_t *string;
    FREGetObjectAsUTF8(object, &stringLength, &string);
    return [NSString stringWithUTF8String:(char*)string];
}

DEFINE_ANE_FUNCTION(isInstagramAvailable) {
    
    return toBOOLToFREObject([[InstagramIosExtension sharedInstance] isAvailable]);
}

DEFINE_ANE_FUNCTION(shareToInstagram) {
    
    NSData *d = toNSDataByteArray(argv[0]);
    UIImage *image=[UIImage imageWithData:d];
    NSString *caption = toFREObjectToNSString(argv[1]);
    [[InstagramIosExtension sharedInstance] shareImage:image withCaption:caption];
    
    return nil;
}

void InstagramContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        MAP_FUNCTION(isInstagramAvailable, NULL ),
        MAP_FUNCTION(shareToInstagram, NULL )
    };
    
    *numFunctionsToSet = sizeof( functionMap ) / sizeof( FRENamedFunction );
    *functionsToSet = functionMap;
    
    InstagramCtx = ctx;
}

void InstagramContextFinalizer(FREContext ctx) {
    InstagramCtx = nil;
    return;
}

void InstagramExtensionInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
    
    extDataToSet = NULL; // This example does not use any extension data.
    *ctxInitializerToSet = &InstagramContextInitializer;
    *ctxFinalizerToSet = &InstagramContextFinalizer;
}

void InstagramExtensionFinalizer() {
    return;
}
