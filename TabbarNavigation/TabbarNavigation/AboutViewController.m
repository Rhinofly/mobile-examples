//
//  AboutViewController.m
//  TabbarNavigation
//
//  Created by Johan Haneveld on 2/26/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutDetailViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        self.title = NSLocalizedString(@"About", @"About");
        self.tabBarItem.image = [UIImage imageNamed:@"about"];
    }
    
    return self;
}

- (IBAction)showChildView:(id)sender
{
    AboutDetailViewController *detailView = [[AboutDetailViewController alloc] initWithNibName:@"AboutDetailViewController" bundle:nil];

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
    // CIFilter* filter = [CIFilter filterWithName:@"suckEffect"];
    // [filter setValue:[NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)] forKey:@"inputPosition"];
    
    CATransition* transition = [CATransition animation];
    transition.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.duration = 1.0f;
    //transition.filter = filter;
    transition.type = kCATransitionMoveIn;
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
