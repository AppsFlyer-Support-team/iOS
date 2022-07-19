//
//  AppDelegate.m
//  cuid_issue_objc
//
//  Created by Mark Serrano on 2020/02/26.
//  Copyright © 2020 Mark. All rights reserved.
//

#import "AppDelegate.h"
#import <AppsFlyerLib/AppsFlyerLib.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    NSLog(@"In Did Finish Launching With Options");

    
    /** APPSFLYER INIT **/
    [AppsFlyerLib shared].isDebug = YES;
    [AppsFlyerLib shared].appsFlyerDevKey = @"tVH7k3UWZjQpS8x2FNTszn";
    [AppsFlyerLib shared].appleAppID = @"1479369723";
    [AppsFlyerLib shared].deepLinkDelegate = self;
    

    AppsFlyerLib.shared.isStopped = YES;
    [[AppsFlyerLib shared] logEventWithEventName:@"testevent" eventValues:nil completionHandler:^(NSDictionary<NSString *,id> * _Nullable dictionary, NSError * _Nullable error) {}];

    
    
    NSLog(@"Test");
    
    /* Set isDebug to true to see AppsFlyer debug logs */
    [[AppsFlyerLib shared] start];
    
    
    
    return YES;
}

-(void)applicationDidBecomeActive:(UIApplication *)application
{
    
    NSLog(@"In Application Did Become Active");
    
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler {
    NSLog(@"Flow: continueUserActivity");
    // Reports app open from a Universal Link for iOS 9 or above
    [[AppsFlyerLib shared] continueUserActivity:userActivity restorationHandler:restorationHandler];
    NSLog(@"%@",@"fdfd");
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation {
    [[AppsFlyerLib shared] handleOpenURL:url sourceApplication:sourceApplication withAnnotation:annotation];
    return YES;
}

- (void) didResolveDeepLink:(AppsFlyerDeepLinkResult *)result {
    NSLog(@"in deep link");
    NSLog(@"%@", result);

    switch ([result status]) {
        case AFSDKDeepLinkResultStatusNotFound:
            NSLog(@"Deep link not found");
        case AFSDKDeepLinkResultStatusFound:
            if([[result deepLink] isDeferred])
                NSLog(@"This is deferred deep link");
            else
                NSLog(@"This is direct deep link");
            break;
        case AFSDKDeepLinkResultStatusFailure:
            NSLog(@"Error in deep link result : %@",[result error]);
    }
}

//- (void)onAppOpenAttribution:(NSDictionary *)attributionData{
//    NSLog(@"%@",attributionData);
//}



@end
