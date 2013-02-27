//
//  PhotoViewController.m
//  TabbarNavigation
//
//  Created by Johan Haneveld on 2/26/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoDetailViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        self.title = NSLocalizedString(@"Photos", @"Photos");
        self.tabBarItem.image = [UIImage imageNamed:@"photo"];
    }
    
    return self;
}

- (IBAction)showChildView:(id)sender
{
    PhotoDetailViewController *detailView = [[PhotoDetailViewController alloc] initWithNibName:@"PhotoDetailViewController" bundle:nil];
    
    // Simple way to push a new view with basic animation
    [[self navigationController] pushViewController:detailView animated:YES];

    // Animation direction
    //    - fromRight (kCATransitionFromRight)
    //    - fromLeft (kCATransitionFromLeft)
    //    - fromTop (kCATransitionFromTop)
    //    - fromBottom (kCATransitionFromBottom)
    
    // Animation transition type
    //    - cameraIris
    //    - cube
    //    - fade (kCATransitionFade)
    //    - moveIn (kCATransitionMoveIn)
    //    - oglFlip
    //    - pageCurl
    //    - pageUnCurl
    //    - push (kCATransitionPush)
    //    - reveal (kCATransitionReveal)
    //    - rippleEffect
    //    - suckEffect
    //    - genieEffect
    
    // complex transition animation. This allows you to use an extend of animation types
    // see for more documentation: http://iphonedevwiki.net/index.php/CATransition
//    CATransition* transition = [CATransition animation];
//    transition.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseIn];
//    transition.duration = 1.0f;
//    transition.type = @"pageCurl";
//    transition.subtype = kCATransitionFromRight;
//    [self.navigationController.view.layer removeAllAnimations];
//    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//    [self.navigationController pushViewController:detailView animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![self.navigationController isNavigationBarHidden])
    {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
