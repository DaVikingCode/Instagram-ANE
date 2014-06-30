//
//  InstagramQueries.h
//  InstagramIosExtension
//
//  Created by Aymeric Lamboley on 30/06/2014.
//  Copyright (c) 2014 DaVikingCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InstagramQueries : NSObject <UIDocumentInteractionControllerDelegate>

extern NSString* const aInstagramAppURLString;
extern NSString* const aInstagramOnlyPhotoFileName;

+ (void) setPhotoFileName:(NSString*)fileName;
+ (NSString*) photoFileName;

+ (BOOL) isAppInstalled;
+ (BOOL) isImageCorrectSize:(UIImage*)image;
+ (void) postImage:(UIImage*)image inView:(UIView*)view;
+ (void) postImage:(UIImage*)image withCaption:(NSString*)caption inView:(UIView*)view;
+ (void) postImage:(UIImage*)image withCaption:(NSString*)caption inView:(UIView*)view delegate:(id<UIDocumentInteractionControllerDelegate>)delegate;

@end
