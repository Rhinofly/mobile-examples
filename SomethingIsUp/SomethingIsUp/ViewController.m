//
//  ViewController.m
//  SomethingIsUp
//
//  Created by Johan Haneveld on 3/29/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "ViewController.h"
#import "ErrorAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // super simple alertview.
    
    UIAlertView* simpleAlert = [[UIAlertView alloc] initWithTitle:@"Er is iets fout gegaan bij het uploaden"
                                                    message:@"Wellicht zou je dit zo kunnen oplossen?"
                                                   delegate:self
                                          cancelButtonTitle:@"Annuleren"
                                          otherButtonTitles:@"Opnieuw", @"Later", nil];
    [simpleAlert show];
    
    return;
    // A little bit more complex alertview.
    // here we built in basic error object handling.
    // there are also 2 optionbuttons in this alertview.
    // TODO: update code with localized strings.
    static NSString *Domain = @"MyApplicationDomainGoesHere";
    
    NSArray *buttons = [NSArray arrayWithObjects: @"Opnieuw", @"Annuleren", nil];
    
    NSMutableDictionary* details = [NSMutableDictionary dictionary];
    [details setValue:@"Er is iets fout gegaan bij het uploaden" forKey:NSLocalizedDescriptionKey];
    [details setValue:@"En hier ging natuurlijk ook iets fout" forKey:NSLocalizedFailureReasonErrorKey];
    [details setValue:@"Wellicht zou je dit zo kunnen oplossen?" forKey:NSLocalizedRecoverySuggestionErrorKey];
    [details setValue:@"test" forKey:NSRecoveryAttempterErrorKey];
    [details setValue:buttons forKey:NSLocalizedRecoveryOptionsErrorKey];
    
    // populate the error object with the details
    NSError *error = [NSError errorWithDomain:Domain code:41 userInfo:details];
    
    UIAlertView* alert = [ErrorAlertView alertViewWithError:error];
    alert.delegate = self;
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"button index: %ld", (long)buttonIndex);
    
    switch (buttonIndex)
    {
        case 0:
            NSLog(@"Button 'Opnieuw' pressed");
            break;
            
        case 1:
            NSLog(@"Button 'Annuleren' pressed");
            break;
            
        default:
            // do nothing
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
