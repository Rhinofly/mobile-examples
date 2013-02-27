//
//  AboutViewController.h
//  TabbarNavigation
//
//  Created by Johan Haneveld on 2/26/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface AboutViewController : UIViewController
{
    IBOutlet UIButton *showButton;
}

- (IBAction)showChildView:(id)sender;

@end
