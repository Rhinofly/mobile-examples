//
//  ErrorAlertView.m
//  PhotoUpload
//
//  Created by Johan Haneveld on 3/29/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "ErrorAlertView.h"

@implementation ErrorAlertView

+(UIAlertView*)alertViewWithError:(NSError*)error;
{
	if(error == nil)
    {
		return nil;
	}
    
    BOOL recoveryAttempt = [[error localizedRecoveryOptions] count] > 0;
    NSString* cancelButton = recoveryAttempt ? nil : NSLocalizedString(@"OK", nil);
    NSString* message = [error localizedFailureReason];
    
    if ([error localizedRecoverySuggestion])
    {
    	message = [message stringByAppendingFormat:@"\n%@", [error localizedRecoverySuggestion]];
    }
    
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                     message:message
                                                    delegate:nil
                                           cancelButtonTitle:cancelButton
                                           otherButtonTitles:nil];
    if (recoveryAttempt)
    {
        for (NSString* recoveryOption in [error localizedRecoveryOptions])
        {
        	[alert addButtonWithTitle:recoveryOption];
        }
        
        alert.cancelButtonIndex = [[error localizedRecoveryOptions] count] - 1;
    }
    
    return alert;
}

@end