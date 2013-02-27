//
//  UploadViewController.m
//  TabbarNavigation
//
//  Created by Johan Haneveld on 2/26/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "UploadViewController.h"
#import "UploadDetailViewController.h"

@interface UploadViewController ()

@end

@implementation UploadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        self.title = NSLocalizedString(@"Upload", @"Upload");
        self.tabBarItem.image = [UIImage imageNamed:@"upload"];
    }
    
    return self;
}

- (IBAction)showChildView:(id)sender
{
    UploadDetailViewController *detailView = [[UploadDetailViewController alloc] initWithNibName:@"UploadDetailViewController" bundle:nil];
    
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
    
    // complex transition animation. This allows you to use an extend of animation types
    // see for more documentation: http://iphonedevwiki.net/index.php/CATransition
    CATransition* transition = [CATransition animation];
    transition.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.duration = 1.0f;
    transition.type = @"oglFlip";
    transition.subtype = kCATransitionFromRight;
    [self.navigationController.view.layer removeAllAnimations];
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:detailView animated:YES];
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
