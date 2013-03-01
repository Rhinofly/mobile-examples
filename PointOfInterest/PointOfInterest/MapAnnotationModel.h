//
//  MapAnnotationModel.h
//  PointOfInterest
//
//  Created by Johan Haneveld on 2/27/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ImageModel.h"

@interface MapAnnotationModel : NSObject <MKAnnotation>

@property ImageModel *model;

- (id)initWithModel:(ImageModel *)model;

@end
