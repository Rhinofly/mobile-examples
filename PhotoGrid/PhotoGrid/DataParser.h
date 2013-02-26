//
//  DataParser.h
//  PhotoDetail
//
//  Created by Johan Haneveld on 2/22/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^ArrayBlock)(NSArray *);
typedef void (^ErrorBlock)(NSError *);

@interface DataParser : NSOperation

@property (nonatomic, copy) ArrayBlock completeHandler;
@property (nonatomic, copy) ErrorBlock errorHandler;

@property (nonatomic) NSData *dataForParsing;
@property (nonatomic) NSMutableArray *models;

- (id)initWithData:(NSData *)data completeHandler:(ArrayBlock)handler;

@end
