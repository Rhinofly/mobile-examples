//
//  MapViewController.m
//  PointOfInterest
//
//  Created by Johan Haneveld on 2/27/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "MapViewController.h"
#import "MapAnnotationModel.h"
#import "ImageModel.h"

@interface MapViewController ()

@property (nonatomic) IBOutlet MKMapView *map;

@property (nonatomic) NSMutableArray *annotations;

@end

@implementation MapViewController

@synthesize data = _data;
@synthesize map = _map;
@synthesize annotations = _annotations;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetail:) name:@"showDetail" object:nil];
    
    _annotations = [NSMutableArray array];
    
    // start at the city Utrecht
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 52.0901422;
    newRegion.center.longitude = 5.1096649;
    newRegion.span.latitudeDelta = 0.112872;
    newRegion.span.longitudeDelta = 0.109863;
    [_map setRegion:newRegion animated:YES];
}

- (void)reloadData
{
    MapAnnotationModel *annotation;
    
    for (ImageModel *model in _data)
    {
        annotation = [[MapAnnotationModel alloc] initWithModel:model];
        [_annotations addObject:annotation];
    }
    
    [_map addAnnotations:_annotations];
}

// create custom markers
- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MapAnnotationModel class]])
    {
        static NSString *MapAnnotationModelIdentifier = @"MapAnnotationModelIdentifier";
        
        MapAnnotationView *annotationView = (MapAnnotationView *)[_map dequeueReusableAnnotationViewWithIdentifier:MapAnnotationModelIdentifier];
        
        if (annotationView)
        {
            annotationView.annotation = annotation;
        } else
        {
            annotationView = [[MapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:MapAnnotationModelIdentifier];
        }
        
        return annotationView;
    }
    
    return nil;
}

- (void)showDetail:(NSNotification *)notification
{
    MapAnnotationModel *model = notification.object;
    
    PhotoDetailViewController *detailView = [[PhotoDetailViewController alloc] initWithNibName:@"PhotoDetailViewController" bundle:nil];
    [detailView setModel: model.model];
    [[self navigationController] pushViewController:detailView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
