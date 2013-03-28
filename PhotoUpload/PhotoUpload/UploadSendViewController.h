//
//  UploadSendViewController.h
//  PhotoUpload
//
//  Created by Johan Haneveld on 3/1/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageUploadModel.h"
#import "Base64.h"
#import "ImageUploader.h"

@interface UploadSendViewController : UIViewController <ImageUploaderDelegate>

@property (nonatomic) UIImage *image;
@property  (nonatomic) NSURLConnection *connection;

@property (nonatomic) IBOutlet UIImageView *background;
@property (nonatomic) IBOutlet UIImageView *imageContainerView;
@property (nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) IBOutlet UITextField *captionLabel;
@property (nonatomic) IBOutlet UIButton *uploadButton;

- (IBAction)uploadTouched:(id)sender;

@end
