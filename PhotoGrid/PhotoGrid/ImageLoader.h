//
//  ImageLoader.h
//  PhotoDetail
//
//  Created by Johan Haneveld on 2/25/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PhotoGridViewController;

@protocol ImageLoaderDelegate;

@interface ImageLoader : NSObject
{
    id <ImageLoaderDelegate> delegate;
}

@property (nonatomic) NSString *url;
@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic, assign) id <ImageLoaderDelegate> delegate;

@property (nonatomic) NSMutableData *data;
@property (nonatomic) NSURLConnection *urlConnection;

- (void)start:(NSString *)url;
- (void)cancel;

@end

@protocol ImageLoaderDelegate

- (void)imageDidLoad:(UIImage *)image forIndexPath:(NSIndexPath *)indexPath;

@end
