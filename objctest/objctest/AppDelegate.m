//
//  AppDelegate.m
//  objctest
//
//  Created by Mark Serrano on 2020/09/22.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)sendLaunch:(UIApplication *)application {
        [[AppsFlyerLib shared] start];
    }


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    /** APPSFLYER INIT **/
    [AppsFlyerLib shared].appsFlyerDevKey = @"tVH7k3UWZjQpS8x2FNTszn";
    [AppsFlyerLib shared].appleAppID = @"id1479369723";
    [AppsFlyerLib shared].delegate = self;
    /* Set isDebug to true to see AppsFlyer debug logs */
    [AppsFlyerLib shared].isDebug = true;

    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(sendLaunch:)
        name:UIApplicationDidBecomeActiveNotification
        object:nil];

    NSLog(@"app did launch");
    
    if (@available(iOS 14, *)) {
        
        [[AppsFlyerLib shared] waitForATTUserAuthorizationWithTimeoutInterval:60];
             //Show the user the Apple IDFA consent dialog
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            //....
        }];
    } else {
        NSLog(@"not iOS 14");
    }
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


-(void)onConversionDataSuccess:(NSDictionary*) installData {
    id status = [installData objectForKey:@"af_status"];
    if([status isEqualToString:@"Non-organic"]) {
        id sourceID = [installData objectForKey:@"media_source"];
        id campaign = [installData objectForKey:@"campaign"];
        NSLog(@"This is a none organic install. Media source: %@  Campaign: %@",sourceID,campaign);
    } else if([status isEqualToString:@"Organic"]) {
        NSLog(@"This is an organic install.");
    }
}
-(void)onConversionDataFail:(NSError *) error {
    NSLog(@"%@",error);
}

@end
