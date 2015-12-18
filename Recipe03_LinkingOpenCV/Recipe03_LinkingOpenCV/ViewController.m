//
//  ViewController.m
//  Recipe03_LinkingOpenCV
//
//  Created by LIANG XIN on 4/11/15.
//  Copyright © 2015 Alexander Shishkov & Kirill Kornyakov. All rights reserved.
//

#import "ViewController.h"
#import "opencv2/imgcodecs/ios.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"FF7"];
    cv::Mat cvImage;
    
    // Convert UIImage* to cv::Mat
    UIImageToMat(image, cvImage);
    
    if (!cvImage.empty())
    {
        cv::Mat gray;
        
        // Convert the image to grayscale
        cv::cvtColor(cvImage, gray, CV_RGBA2GRAY);
        
        // Apply Gaussian filter to remove small edges
        cv::GaussianBlur(gray, gray, cv::Size(5, 5), 1.2, 1.2);
        
        // Calculate edges with Canny
        cv::Mat edges;
        cv::Canny(gray, edges, 0, 50);
        
        // Fill image with white color
        cvImage.setTo(cv::Scalar::all(255));
        
        // Change color on edges
        cvImage.setTo(cv::Scalar(0, 128, 255, 255), edges);
        
        // Convert cv::Mat to UIImage* and show the resulting image
        self.imageView.image = MatToUIImage(cvImage);
    }
}

@end
