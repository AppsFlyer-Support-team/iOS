//
//  AppDelegate.m
//  HelloWorld
//
//  Created by Khang Huynh on 3/2/21.
//

#import "AppDelegate.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
#import <AppsFlyerLib/AppsFlyerLib.h>
#import <UserNotifications/UserNotifications.h>
#import <StoreKit/StoreKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

// Start the AppsFlyer SDK
- (void)sendLaunch:(UIApplication *)application {
    [[AppsFlyerLib shared] start];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /* Set isDebug to true to see AppsFlyer debug logs */
    [[AppsFlyerLib shared] waitForATTUserAuthorizationWithTimeoutInterval:60];
    [AppsFlyerLib shared].isDebug = true;
    [[AppsFlyerLib shared] setAdditionalData:@{@"UUID" : @"userId"}];
    /** APPSFLYER INIT **/
    [AppsFlyerLib shared].appsFlyerDevKey = @"oXMoU2E4NuWh45cN5hcLFk";
    [AppsFlyerLib shared].appleAppID = @"1557291432";
    [AppsFlyerLib shared].delegate = self;
    [AppsFlyerLib shared].useUninstallSandbox = true;
    [AppsFlyerLib shared].deepLinkDelegate = self;
    // Use UIApplicationDidBecomeActiveNotification to start the SDK
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sendLaunch:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
    }];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    if (@available(iOS 10, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        }];
    } else {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    return YES;
}

-(void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"In Application Did Become Active");
    [[AppsFlyerLib shared] start];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[AppsFlyerLib shared] registerUninstall:deviceToken];
}

- (void)MyUninstallTracker:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
}

// Report Push Notification attribution data for re-engagements
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[AppsFlyerLib shared] handlePushNotification:userInfo];
}

// AppsFlyerLib implementation
//Handle Conversion Data (Deferred Deep Link)
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

-(void) onConversionDataFail:(NSError *) error {
    NSLog(@"%@",error);
}

//Handle Direct Deep Link
- (void) onAppOpenAttribution:(NSDictionary*) attributionData {
    NSLog(@"%@",attributionData);
}

- (void) onAppOpenAttributionFailure:(NSError *)error {
    NSLog(@"%@",error);
}

// Reports app open from a Universal Link for iOS 9 or above
- (BOOL) application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *_Nullable))restorationHandler {
    [[AppsFlyerLib shared] continueUserActivity:userActivity restorationHandler:restorationHandler];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation {
    [[AppsFlyerLib shared] handleOpenURL:url sourceApplication:sourceApplication withAnnotation:annotation];
    return YES;
}

- (void) didResolveDeepLink:(AppsFlyerDeepLinkResult *)result {
    NSLog(@"%@", result);
    NSLog(@"%@", [result deepLink]);
    switch ([result status]) {
        case AFSDKDeepLinkResultStatusNotFound:
            NSLog(@"Deep link not found");
            break;
        case AFSDKDeepLinkResultStatusFound:
            if([[result deepLink] isDeferred])
                NSLog(@"This is a deferred deep link: %@",[[result deepLink] deeplinkValue]);
            else
                NSLog(@"This is a direct deep link: %@",[[result deepLink] deeplinkValue]);
            break;
        case AFSDKDeepLinkResultStatusFailure:
            NSLog(@"Error in deep link result: %@",[result error]);
            break;
    }
}

- (void) openStoreKit:(NSString*) appID
       viewController: (UIViewController*) viewController
{
    SKStoreProductViewController *storeController = [[ SKStoreProductViewController alloc ] init ];
    NSDictionary *productParameters = @{ SKStoreProductParameterITunesItemIdentifier : appID };
    [ storeController loadProductWithParameters: productParameters completionBlock:^( BOOL result, NSError *error )
     {
        if ( result )
        {
            [viewController presentViewController:storeController animated:YES completion:nil];
        }
        
    }];
}

// support for scene delegate
#pragma mark - UISceneSession lifecycle
- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options API_AVAILABLE(ios(13)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

@end
