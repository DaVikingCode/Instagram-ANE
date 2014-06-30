//
//  InstagramIosExtension.h
//  InstagramIosExtension
//
//  Created by Aymeric Lamboley on 30/06/2014.
//  Copyright (c) 2014 DaVikingCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InstagramIosExtension : NSObject <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate, UIAlertViewDelegate>

+ (InstagramIosExtension *)sharedInstance;

- (BOOL) isAvailable;
- (void) shareImage:(UIImage*) image withCaption:(NSString*)caption;

@end