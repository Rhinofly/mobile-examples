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
    [[self navigationController] pushViewController:detailView animated:YES];
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
