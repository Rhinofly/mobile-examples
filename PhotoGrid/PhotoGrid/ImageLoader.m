//
//  ImageLoader.m
//  PhotoDetail
//
//  Created by Johan Haneveld on 2/25/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "ImageLoader.h"

@implementation ImageLoader

@synthesize url = _url;
@synthesize indexPath = _indexPath;
@synthesize data = _data;
@synthesize urlConnection = _urlConnection;
@synthesize delegate = _delegate;

-(void)start:(NSString *)url
{
    _url = url;
    
    _urlConnection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]] delegate:self];
}

- (void)cancel
{
    [_urlConnection cancel];
    _urlConnection = nil;
    _url = nil;
    _data = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    _data = [NSMutableData dataWithData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	// Clear the activeDownload property to allow later attempts
    _data = nil;
    
    // Release the connection now that it's finished
    _urlConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Set appIcon and clear temporary data/image
    UIImage *image = [[UIImage alloc] initWithData:_data];
    
    // Clear the activeDownload property to allow later attempts
    _data = nil;
    
    // Release the connection now that it's finished
    _urlConnection = nil;
    
    // call our delegate and return image. Return indexpath, this can be nil if not set
    [_delegate imageDidLoad:image forIndexPath:_indexPath];
}


@end
