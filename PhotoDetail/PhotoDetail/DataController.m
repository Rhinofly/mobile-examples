//
//  DataController.m
//  JsonParser
//
//  Created by Johan Haneveld on 1/24/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "DataController.h"
#import "DataParser.h"

#define imagesURL [NSURL URLWithString: @"http://192.168.124.144:9000/jsonList"]

static DataController *dataController = nil;

@implementation DataController

@synthesize listConnection = _listConnection;
@synthesize retrievedData = _retrievedData;
@synthesize queue = _queue;
@synthesize images = _images;

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
       _images = [NSMutableArray array];
	}
    
    return self;
}

- (void)getImages
{
    // show network activity indicator
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // Create connection
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:imagesURL];
    _listConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    
    // quick check if the connection is instantiated. If the value is nil, the probability of a malformatted URL is high.
    NSAssert(_listConnection != nil, @"Failure to create URL connection.");
}


- (void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Fout opgetreden"
														message:errorMessage
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
    [alertView show];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // start with new data, out with the old.
    [_images removeAllObjects];
    _retrievedData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // save incoming data.    
    [_retrievedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if ([error code] == kCFURLErrorNotConnectedToInternet)
	{
        // if we can identify the error, we can present a more precise message to the user.
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Geen verbinding"
															 forKey:NSLocalizedDescriptionKey];
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
														 code:kCFURLErrorNotConnectedToInternet
													 userInfo:userInfo];
        [self handleError:noConnectionError];
    }
	else
	{
        // otherwise handle the error generically
        [self handleError:error];
    }
    
    // release connection.
    _listConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{    
    // release connection.
    _listConnection = nil;
    
    // hide network activity indicator
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // create the queue to run our ParseOperation
    _queue = [[NSOperationQueue alloc] init];
    

    DataParser *parser = [[DataParser alloc] initWithData:_retrievedData
                                                completeHandler:^(NSArray *parsedImages) {
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        
                                                        [self handleParsedImages:parsedImages];
                                                        
                                                    });
                                                    
                                                    // When the cue is done, clear the reference
                                                    self.queue = nil;
                                                }];
    
    parser.errorHandler = ^(NSError *parseError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self handleError:parseError];
            
        });
    };
    
    //start dataParser
    [_queue addOperation:parser];
     
    // clear temporary data.
    _retrievedData = nil;
}

- (void) handleParsedImages:(NSArray *)parsedImages
{
    [_images addObjectsFromArray:parsedImages];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gotData" object:nil];
}

@end
