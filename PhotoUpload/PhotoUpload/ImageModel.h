//
//  ImageModel.h
//  PhotoDetail
//
//  Created by Johan Haneveld on 2/22/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface ImageModel : NSObject

// data from the database
@property (nonatomic) NSString *url;
@property (nonatomic) NSString *caption;
@property (nonatomic) CGSize *size;
@property (nonatomic) CLLocationCoordinate2D *location;

// data from application
@property (nonatomic) UIImage *thumb;
@property (nonatomic) UIImage *image;

@end
