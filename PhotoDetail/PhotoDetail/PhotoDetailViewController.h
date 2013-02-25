//
//  PhotoDetailViewController.h
//  PhotoDetail
//
//  Created by Johan Haneveld on 1/30/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"
#import "ImageLoader.h"

@interface PhotoDetailViewController : UIViewController <UINavigationBarDelegate, ImageLoaderDelegate>

@property (nonatomic) ImageModel *model;
@property (nonatomic) ImageLoader *loader;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel *textLabel;

@end
