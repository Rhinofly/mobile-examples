//
//  AppDelegate.h
//  PointOfInterest
//
//  Created by Johan Haneveld on 2/27/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataController.h"

@class MapViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MapViewController *viewController;
@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) DataController *dataController;

@end
