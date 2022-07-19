//
//  AppDelegate.swift
//  ios-sample
//
//  Created by Mark Serrano on 2019/10/29.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit
import AppsFlyerLib
import os.log
import AppTrackingTransparency
import wrappedaf

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AppsFlyerLibDelegate, DeepLinkDelegate {
    
    func initSdk(){
        
        AppsFlyerLib.shared().isDebug = true
        AppsFlyerLib.shared().appsFlyerDevKey = "tVH7k3UWZjQpS8x2FNTszn"
        AppsFlyerLib.shared().appleAppID = "1479369723"
        AppsFlyerLib.shared().delegate = self
        //AppsFlyerLib.shared().deepLinkDelegate = self
        AppsFlyerLib.shared().appInviteOneLinkID = "IeDt"
        
        print("AppDelegate object:")
        print(AppsFlyerLib.shared())
        var mywrapper = Wrapper()

    }
    
    func didResolveDeepLink(_ result: DeepLinkResult) {
        print("In didResolveDeepLink")
        print(result.status)
        print(result.deepLink)
    }
    
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        
        print("CONVERSION INFO: \(conversionInfo as AnyObject)\n")
        
    
    }
    
    func onConversionDataFail(_ error: Error) {
    
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.


        initSdk()
        

        
        
        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("sendLaunch"), name: UIApplication.didBecomeActiveNotification, object: nil)

        
        if #available(iOS 14, *) {

//           AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 30)
 
    //            ATTrackingManager.requestTrackingAuthorization { (status) in
    //                NSLog("[DEBUG] [CLIENT] Appsflyer: ATT response status: \(status)")
    //            }
        }


        
        return true
    }
    
    
    @objc func sendLaunch() {
//        AppsFlyerLib.shared().start(completionHandler: { (dictionary, error) in
//
//            print("start with completion handler")
//
//
//
//        })
        
         
         
         AppsFlyerShareInviteHelper.generateInviteUrl(linkGenerator:
          {(_ generator: AppsFlyerLinkGenerator) -> AppsFlyerLinkGenerator in
           generator.setChannel("channel_name")
           generator.setReferrerName("referrer_name")
           generator.addParameterValue("2.5", forKey: "af_cost_value")
//            optional - set a brand domain to the user invite link
//             generator.brandDomain = "brand.domain.com"
           return generator },
         completionHandler: {(_ url: URL?) -> Void in

             print("URL: \(url)")
             
         })

         
         
        
        }
    
    
    
//    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
//
//        print ("HOST:  \(userActivity.webpageURL?.host)")
//
//        if ((userActivity.webpageURL?.host?.contains("onelink.me")) != nil){
//            print ("ONELINK")
//        }
//
//        AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
//        return true
//    }
//
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        
        
    }
    
    // rest of your code, methods such as applicationWillResignActive, applicationDidEnterBackground etc.

    //get conversion data and deep linking

    func onConversionDataReceived(_ installData: [AnyHashable: Any]) {
      //Handle Conversion Data (Deferred Deep Link)

        print("Get conversion data received app")
        print("GET Conversion Data: \(installData as AnyObject)")


    }

      func onConversionDataRequestFailure(_ error: Error?) {
        //    print("\(error)")
      }

      func onAppOpenAttribution(_ attributionData: [AnyHashable: Any]) {
        //Handle Deep Link Data
        
        os_log("markdebug: in OAOA", type: .debug)


        print("Attribution Data: \(attributionData as AnyObject)")



      }

    func onAppOpenAttributionFailure(_ error: Error) {
        print ("OAOA Error")
    }
    
    
    
    // Reports app open from a Universal Link for iOS 9 or later
    private func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        
        print ("HOST:  \(userActivity.webpageURL?.host)")

        if ((userActivity.webpageURL?.host?.contains("onelink.me")) != nil){
            print ("ONELINK")
        }
        
        return true
      }
    
    

        // Open URI-scheme for iOS 9 and above
        func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
            AppsFlyerLib.shared().handleOpen(url, sourceApplication: sourceApplication, withAnnotation: annotation)
            return true
        }
}
