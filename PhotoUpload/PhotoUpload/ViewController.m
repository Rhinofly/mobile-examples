//
//  ViewController.m
//  PhotoUpload
//
//  Created by Johan Haneveld on 3/1/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize cameraButton = _cameraButton;
@synthesize libraryButton = _libraryButton;

- (IBAction)cameraSelect:(id)sender
{
    [self mediaTypeSelect:UIImagePickerControllerSourceTypeCamera];
}

- (IBAction)librarySelect:(id)sender
{
    [self mediaTypeSelect:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)mediaTypeSelect:(NSUInteger)sourceType
{
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = sourceType;
    
    // Displays a control that allows the user to choose picture or movie capture, if both are available:
    //cameraUI.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    
    // only make movie or image avaiable: kUTTypeMovie : kUTTypeImage
    mediaUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = YES;
    mediaUI.delegate = self;
    
    // camera interface
    [self presentViewController:mediaUI animated:YES completion:nil];
}

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    // Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo)
    {
        UIImage *imageToSave = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // Save the new image (original or edited) to the Camera Roll
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        {
            UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
        }
        
        UploadSendViewController *uploadView = [[UploadSendViewController alloc] initWithNibName:@"UploadSendViewController" bundle:nil];
        [uploadView setImage:imageToSave];
        [[self navigationController] pushViewController:uploadView animated:NO];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
	[self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    
	[self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // show button only if the device supports camera.
    [_cameraButton.titleLabel setFont:[UIFont fontWithName:@"Adelle Basic" size:24]];
    _cameraButton.hidden = ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    // show button only if the device supports photo library.
    [_libraryButton.titleLabel setFont:[UIFont fontWithName:@"Adelle Basic" size:24]];
    _libraryButton.hidden = ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
