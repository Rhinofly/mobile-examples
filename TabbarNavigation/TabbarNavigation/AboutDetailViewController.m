//
//  AboutDetailViewController.m
//  TabbarNavigation
//
//  Created by Johan Haneveld on 2/26/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "AboutDetailViewController.h"

@interface AboutDetailViewController ()

@end

@implementation AboutDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Custom initialization
    }
    
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    // See PhotoViewController class for animation documentation.
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound)
    {
        CATransition* transition = [CATransition animation];
        transition.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseIn];
        transition.duration = 1.0f;
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromLeft;
        [self.navigationController.view.layer removeAllAnimations];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    }
    
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
