//
//  ViewController.h
//  Recipe06_WorkingWithGallery
//
//  Created by LIANG XIN on 3/12/15.
//  Copyright © 2015 Kirill Kornyakov & Alexander Shishkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    UIPopoverController* popoverController;
    UIImage* postcardImage;
    cv::CascadeClassifier faceDetector;
}
@property (nonatomic, strong) UIPopoverController* popoverController;
- (UIImage*)printPostcard:(UIImage*)image;

@end

