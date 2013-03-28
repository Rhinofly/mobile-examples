//
//  ImageUploader.h
//  PhotoUpload
//
//  Created by Johan Haneveld on 3/6/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageUploaderDelegate;

@interface ImageUploader : NSData
{
    id <ImageUploaderDelegate> delegate;
}

@property (nonatomic) NSString *url;
@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic, assign) id <ImageUploaderDelegate> delegate;

@property (nonatomic) NSData *data;
@property (nonatomic) NSURLConnection *urlConnection;

- (void)start:(NSString *)url withData:(NSObject *)data;
- (void)cancel;

@end

@protocol ImageUploaderDelegate

- (void)imageDidUpload:(NSObject *)returnData;

@end
