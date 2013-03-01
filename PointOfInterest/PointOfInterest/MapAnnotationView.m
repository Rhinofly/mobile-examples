//
//  MapAnnotationView.m
//  PointOfInterest
//
//  Created by Johan Haneveld on 2/28/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "MapAnnotationView.h"

@implementation MapAnnotationView

@synthesize calloutView = _calloutView;
@synthesize thumbLoader = _thumbLoader;


- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.image = [UIImage imageNamed:@"mapMarker.png"];
        self.centerOffset = CGPointMake(0, -(self.image.size.height / 2 - 3)); // - 3 because the marker image I use contains shadows.
        self.canShowCallout = YES;
        
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
        self.rightCalloutAccessoryView = rightButton;
        
        MapAnnotationModel *model = annotation;
        
        if (model.model.thumb)
        {
            [self setThumb:model.model.thumb];
        } else
        {
            [self setThumb:[UIImage imageNamed:@"ThumbPlaceholder.png"]];
        }
        
    }
    
    return self;
}

- (IBAction)showDetails:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showDetail" object:self.annotation];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    MapAnnotationModel *model = self.annotation;
    
    if(selected && !model.model.thumb && _thumbLoader == nil)
    {
        _thumbLoader = [[ImageLoader alloc] init];
        _thumbLoader.delegate = self;
        [_thumbLoader start:[NSString stringWithFormat:@"%@%@%@", @"http://", model.model.url, @"_thumb_160"]];
    }
}

- (void)imageDidLoad:(UIImage *)image forIndexPath:(NSIndexPath *)indexPath
{
    _thumbLoader = nil;
    
    if (image)
    {
        MapAnnotationModel *model = self.annotation;
        model.model.thumb = image;
        
        
        [self setThumb:image];
    }
}

- (void) setThumb:(UIImage *)image
{
    UIGraphicsBeginImageContext(CGSizeMake(30, 30));
    [image drawInRect:CGRectMake(0,0, 30, 30)];
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (_calloutView)
    {
        _calloutView.image = image;
    } else
    {
        _calloutView = [[UIImageView alloc]initWithImage:resizedImage];
        self.leftCalloutAccessoryView = _calloutView;
    }
}

@end