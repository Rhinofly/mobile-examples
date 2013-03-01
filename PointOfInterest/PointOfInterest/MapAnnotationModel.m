//
//  MapAnnotationModel.m
//  PointOfInterest
//
//  Created by Johan Haneveld on 2/27/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "MapAnnotationModel.h"

@implementation MapAnnotationModel

@synthesize model = _model;

- (id)initWithModel:(ImageModel *)model
{
    self = [super init];
    
    if (self != nil)
    {
        _model = model;
    }
    
    return self;
}

- (CLLocationCoordinate2D)coordinate;
{
    return _model.location;
}

- (NSString *)title
{
    return _model.caption;
}

@end
