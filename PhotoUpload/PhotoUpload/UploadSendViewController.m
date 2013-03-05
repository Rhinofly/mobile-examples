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

@synthesize image = _image;
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
    ImageUploadModel *model = [ImageUploadModel alloc];
    model.caption = _captionLabel.text;
    
    NSLog(@"value: %@", model.caption);
    
    NSData *imageData = UIImageJPEGRepresentation(_image, 100);
    NSUInteger length = [imageData length];
    model.image = (Byte*)malloc(length);
    [imageData  getBytes:model.image length:length];
    
    //NSString *byteArray  = [data base64Encoding];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGSize viewSize = self.view.frame.size;
    CGPoint captionOrigin = _captionLabel.frame.origin;
    CGSize captionSize = _captionLabel.frame.size;
    
    if (captionOrigin.y + captionSize.height > viewSize.height - keyboardSize.height)
    {
        double offset = viewSize.height - keyboardSize.height - captionOrigin.y - captionSize.height - 20;
        CGRect rect = CGRectMake(0, offset, viewSize.width, viewSize.height);
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        self.view.frame = rect;
        
        [UIView commitAnimations];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    CGSize viewSize = self.view.frame.size;
    CGRect rect = CGRectMake(0, 0, viewSize.width, viewSize.height);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
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
    
    _imageView.image = _image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
