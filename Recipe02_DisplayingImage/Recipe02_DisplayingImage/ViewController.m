//
//  ViewController.m
//  Recipe02_DisplayingImage
//
//  Created by LIANG XIN on 3/11/15.
//  Copyright © 2015 Alexander Shishkov & Kirill Kornyakov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"picture"];
    if (image) {
        self.imageView.image = image;
    }
}

@end
