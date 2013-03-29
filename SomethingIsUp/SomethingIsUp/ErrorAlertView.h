//
//  ErrorAlertView.h
//  PhotoUpload
//
//  Created by Johan Haneveld on 3/29/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ErrorAlertView : NSObject 

+(UIAlertView*)alertViewWithError:(NSError*)error;

@end
