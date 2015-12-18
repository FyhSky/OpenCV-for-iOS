//
//  ViewController.m
//  Recipe05_PrintingPostcard
//
//  Discuss how to use C++ classes from Objective-C code.
//  The app prints a postcard using the image with a face.
//  We will also learn how to measure the processing time of your methods,
//  so that you can track their effciency.
//
//  Created by LIANG XIN on 3/12/15.
//  Copyright © 2015 Kirill Kornyakov & Alexander Shishkov. All rights reserved.
//

#import "ViewController.h"
#import "PostcardPrinter.hpp"
#import "opencv2/imgcodecs/ios.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PostcardPrinter::Parameters params;
    
    // Load image with face
    UIImage* image = [UIImage imageNamed:@"lena.jpg"];
    UIImageToMat(image, params.face);
    
    // Load image with texture
    image = [UIImage imageNamed:@"texture.jpg"];
    UIImageToMat(image, params.texture);
    cvtColor(params.texture, params.texture, CV_RGBA2RGB);
    
    // Load image with text
    image = [UIImage imageNamed:@"text.png"];
    UIImageToMat(image, params.text, true);
    
    // Create PostcardPrinter class
    PostcardPrinter postcardPrinter(params);
    
    // Print postcard, and measure printing time
    cv::Mat postcard;
    int64 timeStart = cv::getTickCount();
    postcardPrinter.print(postcard);
    int64 timeEnd = cv::getTickCount();
    float durationMs = 1000.f * float(timeEnd - timeStart) / cv::getTickFrequency();
    NSLog(@"Printing time = %.3fms", durationMs);
    
    if (!postcard.empty())
        self.imageView.image = MatToUIImage(postcard);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
