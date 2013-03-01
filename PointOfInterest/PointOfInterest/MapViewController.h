//
//  MapViewController.h
//  PointOfInterest
//
//  Created by Johan Haneveld on 2/27/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapAnnotationView.h"
#import "PhotoDetailViewController.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic) NSMutableArray *data;
@property(nonatomic, retain)CLLocationManager *locationManager;

- (void)reloadData;

@end
