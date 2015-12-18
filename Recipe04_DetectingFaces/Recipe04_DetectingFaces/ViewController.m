//
//  ViewController.m
//  Recipe04_DetectingFaces
//
//  Detect faces using the cv::CascadeClassifier class from OpenCV.
//  In order to do that, we will load an XML file with a trained classifier, use it to detect faces,
//  and then draw a rectangle over the detected face.
//
//  Created by LIANG XIN on 3/12/15.
//  Copyright © 2015 Kirill Kornyakov & Alexander Shishkov. All rights reserved.
//

#import "ViewController.h"
#import "opencv2/imgcodecs/ios.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load cascade classifier from the XML file
    NSString* cascadePath = [[NSBundle mainBundle]
                             pathForResource:@"haarcascade_frontalface_alt2"
                             ofType:@"xml"];
    faceDetector.load([cascadePath UTF8String]);
    
    //Load image with face
    UIImage* image = [UIImage imageNamed:@"lena.png"];
    cv::Mat faceImage;
    UIImageToMat(image, faceImage);
    
    // Convert to grayscale
    cv::Mat gray;
    cvtColor(faceImage, gray, CV_BGR2GRAY);
    
    // Detect faces
    std::vector<cv::Rect> faces;
    faceDetector.detectMultiScale(gray, faces, 1.1,
                                  2, 0|CV_HAAR_SCALE_IMAGE, cv::Size(30, 30));
    
    // Draw all detected faces
    for(unsigned int i = 0; i < faces.size(); i++)
    {
        const cv::Rect& face = faces[i];
        // Get top-left and bottom-right corner points
        cv::Point tl(face.x, face.y);
        cv::Point br = tl + cv::Point(face.width, face.height);
        
        // Draw rectangle around the face
        cv::Scalar magenta = cv::Scalar(255, 0, 255);
        cv::rectangle(faceImage, tl, br, magenta, 4, 8, 0);
    }
    
    // Show resulting image
    self.imageView.image = MatToUIImage(faceImage);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
