//
//  PhotoDetailViewController.m
//  PhotoDetail
//
//  Created by Johan Haneveld on 1/30/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "PhotoDetailViewController.h"

@interface PhotoDetailViewController ()

@end

@implementation PhotoDetailViewController

@synthesize model = _model;
@synthesize loader = _loader;
@synthesize imageView = _imageView;
@synthesize textLabel = _textLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // load image with a callback. this is handy when you want to do "stuff" like resizing after download.
    _loader = [[ImageLoader alloc] init];
    _loader.delegate = self;
    [_loader start:[NSString stringWithFormat:@"%@%@", @"http://", _model.url]];
    
    // load image without callback. easy implementation when you dont want to do anything after loading.
    //NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"http://", _image.url]];
	//_imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
    // if a download is deferred or in progress, use a placeholder image
    UIImage *image = [UIImage imageNamed:@"ImagePlaceholder.png"];
    _imageView.image = image;
    
    _textLabel.hidden = !_model.caption.length;
    
    if (!_textLabel.hidden)
    {
        _textLabel.text = _model.caption;
    }
}

- (void)imageDidLoad:(UIImage *)image forIndexPath:(NSIndexPath *)indexPath
{
    _loader = nil;
    
    if (image)
    {
        NSLog(@"got image: %@", image);
        _imageView.image = image;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
	[self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
