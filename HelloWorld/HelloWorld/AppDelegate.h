//
//  AppDelegate.h
//  HelloWorld
//
//  Created by Khang Huynh on 3/2/21.
//

#import <UIKit/UIKit.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AppsFlyerLib/AppsFlyerLib.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, AppsFlyerLibDelegate, AppsFlyerDeepLinkDelegate>
@property (strong, nonatomic) UIWindow *window;
@end
