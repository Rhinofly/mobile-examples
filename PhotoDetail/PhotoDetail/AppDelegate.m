//
//  AppDelegate.m
//  PhotoGrid
//
//  Created by Johan Haneveld on 1/29/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize dataController = _dataController;
@synthesize viewController = _viewController;
@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _dataController = [DataController instance];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Create view and add data
    _viewController = [[PhotoGridViewController alloc] initWithNibName:@"PhotoGridViewController" bundle:nil];
    [_viewController setData: _dataController.images];
    
    // Create navigationcontroller and this as rootviewvcontroller
    // this will add navigationbar functionality.
    _navigationController = [[UINavigationController alloc]initWithRootViewController:_viewController];
    _navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.window.rootViewController = _navigationController;
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noDataHandler:) name:@"noData" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotDataHandler:) name:@"gotData" object:nil];
    [_dataController getImages];
        
    return YES;
}

- (void)noDataHandler:(NSNotification *)notification
{
    NSLog(@"No data");
}

- (void)gotDataHandler:(NSNotification *)notification
{
    NSLog(@"Got data");    
    
    // reload the data on the collectionview
    [_viewController.collectionView reloadData];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end