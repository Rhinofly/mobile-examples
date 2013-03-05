//
//  ViewController.h
//  PhotoUpload
//
//  Created by Johan Haneveld on 3/1/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UploadSendViewController.h"

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property IBOutlet UIButton *cameraButton;

- (IBAction)cameraSelect:(id)sender;

@end
