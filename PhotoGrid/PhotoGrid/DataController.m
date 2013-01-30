//
//  DataController.m
//  JsonParser
//
//  Created by Johan Haneveld on 1/24/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "DataController.h"

#define globalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define listURL [NSURL URLWithString: @"http://192.168.124.62:9000/jsonList"]

static DataController *dataController = nil;

@implementation DataController

@synthesize data = _data;

+ (DataController *)instance
{
	@synchronized(self)
	{
        if (dataController == nil)
		{
			dataController = [[super allocWithZone:NULL] init];
		}
	}
    
    return dataController;
}

- (id)init
{
    if (self = [super init])
	{
        //Do init code
	}
    
    return self;
}

- (void)getData
{
    dispatch_async(globalQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:listURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

- (void)fetchedData:(NSData *)responseData
{
    if (responseData == nil)
    {
        NSLog(@"No Data or connection available");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"noData" object:nil];
        return;
    }
    
    NSError *error;
    _data = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    NSLog(@"data: %u", [_data count]);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gotData" object:nil];
}

@end
