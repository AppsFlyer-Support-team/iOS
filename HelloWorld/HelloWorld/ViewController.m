//
//  ViewController.m
//  HelloWorld
//
//  Created by Khang Huynh on 3/2/21.
//

#import "ViewController.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
#import <AppsFlyerLib/AppsFlyerLib.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (@available(iOS 14, *)) {
      [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
        NSLog(@"Status: %lu", (unsigned long)status);
      }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    }
-(IBAction)showLabel{
    label.text = @"Hello World";
}

@end
