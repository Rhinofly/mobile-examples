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
