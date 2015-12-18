//
//  ViewController.h
//  Recipe08_TakingPhotosFromCamera
//
//  Created by LIANG XIN on 18/12/15.
//  Copyright © 2015 Kirill Kornyakov & Alexander Shishkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "opencv2/imgcodecs/ios.h"
#import "opencv2/videoio/cap_ios.h"
#import "RetroFilter.hpp"

@interface ViewController : UIViewController <CvPhotoCameraDelegate>
{
    CvPhotoCamera* photoCamera;
    UIImageView* resultView;
    RetroFilter::Parameters params;
}
- (UIImage*)applyEffect:(UIImage*)image;
@end

