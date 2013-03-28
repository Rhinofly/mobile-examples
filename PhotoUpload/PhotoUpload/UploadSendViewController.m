//
//  UploadSendViewController.m
//  PhotoUpload
//
//  Created by Johan Haneveld on 3/1/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "UploadSendViewController.h"

@interface UploadSendViewController ()

@end

@implementation UploadSendViewController

@synthesize background = _background;
@synthesize imageContainerView = _imageContainerView;
@synthesize image = _image;
@synthesize connection = _connection;
@synthesize imageView = _imageView;
@synthesize captionLabel = _captionLabel;
@synthesize uploadButton = _uploadButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {        
        // Listen to keyboard events. We will use this to show the textinputfield when the keyboard overlaps it.
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    return self;
}

- (IBAction)uploadTouched:(id)sender
{
    // convert image to string, this is so json can tranfer our image.
    NSData *imageData = UIImageJPEGRepresentation(_image, 100);
    NSString *byteArray = [imageData base64EncodedString];
    
    // create data object we convert to a huge ass json string and fill it.
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:byteArray forKey:@"image"];
    [data setObject:_captionLabel.text forKey:@"caption"];
    
    ImageUploader *loader = [[ImageUploader alloc] init];
    loader.delegate = self;
    [loader start:@"http://192.168.124.144:9000/jsonUpload" withData:data];
}

- (void)imageDidUpload:(NSObject *)returnData
{
    NSLog(@"return data: %@", returnData);
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    // this code will make sure the textinput is always shown when the keyboard pops up.
    NSDictionary* info = [aNotification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // get all the requered sizes to determine.
    CGSize viewSize = self.view.frame.size;
    CGPoint captionOrigin = _captionLabel.frame.origin;
    CGSize captionSize = _captionLabel.frame.size;
    
    // check if the keyboard is on top of the textinput.
    if (captionOrigin.y + captionSize.height > viewSize.height - keyboardSize.height)
    {
        // animation settings
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        // create new frame size for the view.
        double offset = viewSize.height - keyboardSize.height - captionOrigin.y - captionSize.height - 20;
        CGRect rect = CGRectMake(0, offset, viewSize.width, viewSize.height);
        self.view.frame = rect;
        
        // start animation.
        [UIView commitAnimations];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    // this code makes sure the view is resize to iets original size.
    
    // animation settings.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    // set the original view size to the view.
    CGSize viewSize = self.view.frame.size;
    CGRect rect = CGRectMake(0, 0, viewSize.width, viewSize.height);
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // use this code if your using the simulator.
    //_image = [UIImage imageNamed:@"photo.jpg"];
    
    _imageView.image = _image;
    
    [_uploadButton.titleLabel setFont:[UIFont fontWithName:@"Adelle Basic" size:24]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
