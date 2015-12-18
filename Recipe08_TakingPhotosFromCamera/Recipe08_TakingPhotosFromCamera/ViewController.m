//
//  ViewController.m
//  Recipe08_TakingPhotosFromCamera
//
//  Created by LIANG XIN on 18/12/15.
//  Copyright © 2015 Kirill Kornyakov & Alexander Shishkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CvPhotoCamera* photoCamera;
@property (nonatomic, strong) IBOutlet UIImageView* imageView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem* takePhotoButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem* startCaptureButton;
@end

@implementation ViewController

@synthesize photoCamera;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize camera
    photoCamera = [[CvPhotoCamera alloc]
                   initWithParentView:self.imageView];
    photoCamera.delegate = self;
    photoCamera.defaultAVCaptureDevicePosition =
    AVCaptureDevicePositionBack;
    photoCamera.defaultAVCaptureSessionPreset =
    AVCaptureSessionPresetPhoto;
    photoCamera.defaultAVCaptureVideoOrientation =
    AVCaptureVideoOrientationPortrait;
    
    // Load images
    UIImage* resImage = [UIImage imageNamed:@"scratches.png"];
    UIImageToMat(resImage, params.scratches);
    
    resImage = [UIImage imageNamed:@"fuzzy_border.png"];
    UIImageToMat(resImage, params.fuzzyBorder);
    
    [self.takePhotoButton setEnabled:NO];
}

- (IBAction)takePhotoButtonPressed:(id)sender {
    [photoCamera takePicture];
}

- (IBAction)startCaptureButtonPressed:(id)sender {
    [photoCamera start];
//    [self.view addSubview:self.imageView];
    [self.takePhotoButton setEnabled:YES];
    [self.startCaptureButton setEnabled:NO];
}

- (UIImage*)applyEffect:(UIImage*)image;
{
    cv::Mat frame;
    UIImageToMat(image, frame);
    
    params.frameSize = frame.size();
    RetroFilter retroFilter(params);
    
    cv::Mat finalFrame;
    retroFilter.applyToPhoto(frame, finalFrame);
    
    UIImage* result = MatToUIImage(finalFrame);
    return [UIImage imageWithCGImage:[result CGImage]
                               scale:1.0
                         orientation:UIImageOrientationLeftMirrored];
}

- (void)photoCamera:(CvPhotoCamera*)camera
      capturedImage:(UIImage *)image;
{
    [camera stop];
    resultView = [[UIImageView alloc]
                  initWithFrame:self.imageView.bounds];
    
    UIImage* result = [self applyEffect:image];
    
    [resultView setImage:result];
//    [resultView setNeedsLayout];
//    [resultView layoutIfNeeded];
    [self.imageView addSubview:resultView];
    
    [self.takePhotoButton setEnabled:NO];
    [self.startCaptureButton setEnabled:YES];
}

- (void)photoCameraCancel:(CvPhotoCamera*)camera;
{
}

- (void)viewDidDisappear:(BOOL)animated
{
    [photoCamera stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    photoCamera.delegate = nil;
}

@end
