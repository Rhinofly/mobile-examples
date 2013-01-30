//
//  DataController.h
//  JsonParser
//
//  Created by Johan Haneveld on 1/24/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataController : NSObject

@property (nonatomic) NSArray *data;

+ (DataController *) instance;

- (void) getData;

@end