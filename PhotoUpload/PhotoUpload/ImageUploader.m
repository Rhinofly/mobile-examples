//
//  ImageUploader.m
//  PhotoUpload
//
//  Created by Johan Haneveld on 3/6/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "ImageUploader.h"

@implementation ImageUploader

@synthesize url = _url;
@synthesize indexPath = _indexPath;
@synthesize data = _data;
@synthesize urlConnection = _urlConnection;
@synthesize delegate = _delegate;

- (void)start:(NSString *)url withData:(NSObject *)data;
{
    NSLog(@"start");
    
    _url = url;
    
    // check if object is valid for json serialization.
    if ([NSJSONSerialization isValidJSONObject:data])
    {
        // serialize object to json object
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
        
        // initialize request
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.124.144:9000/jsonUpload"]];
        // set it to POST value for upload, see http post / get documentation for more information about this
        [request setHTTPMethod:@"POST"];
        // set body of the request
        [request setHTTPBody:jsonData];
        // set content-type, this is handy for the receiving server. in my case play webframework
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        // set content length
        [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
        
        _urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    } else
    {
        //error
    }
}

- (void)cancel
{
    NSLog(@"cancel");
    
    [_urlConnection cancel];
    _urlConnection = nil;
    _url = nil;
    _data = nil;
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

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData");
    // save data for returning.
    _data = data;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError");
    
	// Clear the activeDownload property to allow later attempts
    _data = nil;
    
    // Release the connection now that it's finished
    _urlConnection = nil;
    
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
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
    // Release the connection now that it's finished
    _urlConnection = nil;
    
    // call our delegate
    [_delegate imageDidUpload:_data];
}


@end
