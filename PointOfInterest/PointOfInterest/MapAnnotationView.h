//
//  MapAnnotationView.h
//  PointOfInterest
//
//  Created by Johan Haneveld on 2/28/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapAnnotationModel.h"
#import "ImageLoader.h"

@interface MapAnnotationView : MKAnnotationView <ImageLoaderDelegate>

@property (nonatomic) UIImageView *calloutView;
@property (nonatomic) ImageLoader *thumbLoader;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (void)imageDidLoad:(UIImage *)image forIndexPath:(NSIndexPath *)indexPath;

@end
