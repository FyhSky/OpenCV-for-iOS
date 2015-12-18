//
//  ViewController.m
//  Recipe01_HelloWorld
//
//  Created by LIANG XIN on 3/11/15.
//  Copyright © 2015 Alexander Shishkov & Kirill Kornyakov. All rights reserved.
//
//  Add a logging to the console and show an alert window

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Console output
    NSLog(@"Hello World!");
    
    // Alert window
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hey there!"
                                                                    message:@"Welcom to openCV on iOS development community"
                                                             preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *continueAction = [UIAlertAction actionWithTitle:@"Continue"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              [alert dismissViewControllerAnimated:YES completion:nil];
                                                          }];
    [alert addAction:continueAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
