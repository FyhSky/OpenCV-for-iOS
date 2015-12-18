//
//  ViewController.h
//  Recipe07_ApplyingRetroEffect
//
//  Created by LIANG XIN on 17/12/15.
//  Copyright © 2015 Kirill Kornyakov & Alexander Shishkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RetroFilter.hpp"

@interface ViewController :
UIViewController<UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UIPopoverControllerDelegate>
{
    UIPopoverController* popoverController;
    UIImage* image;
    RetroFilter::Parameters params;
}

- (UIImage*)applyFilter:(UIImage*)image;


@end

