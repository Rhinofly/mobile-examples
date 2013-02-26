//
//  DataController.h
//  JsonParser
//
//  Created by Johan Haneveld on 1/24/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataParser.h"

@interface DataController : NSObject

@property (nonatomic) NSURLConnection *listConnection;
@property (nonatomic) NSMutableData *retrievedData;
@property (nonatomic) NSOperationQueue *queue;
@property (nonatomic) NSMutableArray *images;

+ (DataController *) instance;

- (void) getImages;

@end