//
//  AppDelegate.h
//  JsonParser
//
//  Created by Johan Haneveld on 1/24/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataController.h"
#import "TableViewController.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TableViewController *viewController;

@property (strong, nonatomic) DataController *dataController;

@end
