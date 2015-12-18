//
//  ViewController.m
//  Recipe07_ApplyingRetroEffect
//
//  Created by LIANG XIN on 17/12/15.
//  Copyright © 2015 Kirill Kornyakov & Alexander Shishkov. All rights reserved.
//

#import "ViewController.h"
#import "opencv2/imgcodecs/ios.h"

@interface ViewController ()
@property (nonatomic, strong) IBOutlet UIImageView* imageView;
@property (nonatomic, strong) UIPopoverController* popoverController;
@property (nonatomic, weak) IBOutlet UIBarButtonItem* loadButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem* saveButton;

-(IBAction)loadButtonPressed:(id)sender;
-(IBAction)saveButtonPressed:(id)sender;
@end

@implementation ViewController

@synthesize popoverController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load images
    UIImage* resImage = [UIImage imageNamed:@"scratches.png"];
    UIImageToMat(resImage, params.scratches);
    
    resImage = [UIImage imageNamed:@"fuzzyBorder.png"];
    UIImageToMat(resImage, params.fuzzyBorder);
    
    [self.saveButton setEnabled:NO];
}

- (UIImage*)applyFilter:(UIImage*)inputImage;
{
    cv::Mat frame;
    UIImageToMat(inputImage, frame);
    
    params.frameSize = frame.size();
    RetroFilter retroFilter(params);
    
    cv::Mat finalFrame;
    retroFilter.applyToPhoto(frame, finalFrame);
    
    return MatToUIImage(finalFrame);
}

- (void)imagePickerController: (UIImagePickerController*)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] ==
        UIUserInterfaceIdiomPad)
    {
        [popoverController dismissPopoverAnimated:YES];
    }
    else
    {
        [picker dismissViewControllerAnimated:YES
                                   completion:nil];
    }
    
    UIImage* temp =
    [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    image = [self applyFilter:temp];
    self.imageView.image = image;
    
    [self.saveButton setEnabled:YES];
}

-(void)imagePickerControllerDidCancel:
(UIImagePickerController *)picker
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] ==
        UIUserInterfaceIdiomPad)
    {
        [popoverController dismissPopoverAnimated:YES];
    }
    else
    {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)loadButtonPressed:(id)sender {
    if (![UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypePhotoLibrary])
        return;
    
    UIImagePickerController* picker =
    [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    picker.sourceType =
    UIImagePickerControllerSourceTypePhotoLibrary;
    
    // iPad
    if ([[UIDevice currentDevice] userInterfaceIdiom] ==
        UIUserInterfaceIdiomPad)
    {
        if ([self.popoverController isPopoverVisible])
        {
            [self.popoverController dismissPopoverAnimated:YES];
        }
        else
        {
            self.popoverController =
            [[UIPopoverController alloc]
             initWithContentViewController:picker];
            
            popoverController.delegate = self;
            
            [self.popoverController
             presentPopoverFromBarButtonItem:sender
             permittedArrowDirections:UIPopoverArrowDirectionDown
             animated:YES];
        }
    }
    // iPhone
    else
    {
        [self presentViewController:picker
                           animated:YES
                         completion:nil];
    }
}

- (IBAction)saveButtonPressed:(id)sender {
    if (image != nil)
    {
        UIImageWriteToSavedPhotosAlbum(image, self, nil, NULL);
        
        //Alert window
        UIAlertView *alert = [UIAlertView alloc];
        alert = [alert initWithTitle:@"Status"
                             message:@"Saved to the Gallery!"
                            delegate:nil
                   cancelButtonTitle:@"Continue"
                   otherButtonTitles:nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
