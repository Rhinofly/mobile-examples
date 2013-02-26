//
//  PhotoGridViewController.h
//  PhotoGrid
//
//  Created by Johan Haneveld on 1/29/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageLoader.h"

@interface PhotoGridViewController : UICollectionViewController <UIScrollViewDelegate, ImageLoaderDelegate>

@property (nonatomic) NSArray *data;

@property (nonatomic) NSMutableDictionary *thumbLoaders;

@end
