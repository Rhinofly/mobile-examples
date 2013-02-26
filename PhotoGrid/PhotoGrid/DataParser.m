//
//  DataParser.m
//  PhotoDetail
//
//  Created by Johan Haneveld on 2/22/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "DataParser.h"
#import "ImageModel.h"

// string contants found in the RSS feed
static NSString *urlKey = @"url";
static NSString *captionKey = @"caption";
//static NSString *sizeKey = @"size";
//static NSString *latLngKey = @"latLng";

@implementation DataParser

@synthesize dataForParsing = _dataForParsing;
@synthesize completeHandler = _completeHandler;
@synthesize models = _models;

- (id)initWithData:(NSData *)data completeHandler:(ArrayBlock)handler
{
    self = [super init];
    
    if (self != nil)
    {
        _dataForParsing = data;
        _completeHandler = handler;
    }
    
    return self;
}


- (void)main
{
    _models = [NSMutableArray array];
    
    NSError *error;
    NSArray *data = [NSJSONSerialization JSONObjectWithData:_dataForParsing options:kNilOptions error:&error];
    
    ImageModel *image;
    //NSDictionary *size;
    //NSDictionary *latLng;
    
    for (NSDictionary *item in data)
    {
        image = [ImageModel alloc];
        image.url = [item objectForKey:urlKey];
        image.caption = [item objectForKey:captionKey];
        
        // TODO: implement size and latlng
        
        [_models addObject:image];
    }
    
    if (![self isCancelled])
    {
        // call our completion handler with the result parsing result
        _completeHandler(_models);
    }
    
    _dataForParsing = nil;
    _completeHandler = nil;
}

@end
