//
//  AppDelegate.swift
//  training-project-storyboard
//
//  Created by Mark Serrano on 3/10/21.
//

import UIKit
import AppsFlyerLib



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AppsFlyerLibDelegate {


    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        
        
        print("Conversion Data: \(conversionInfo as AnyObject)")

        let vc = UIApplication.shared.windows.first?.rootViewController as? ViewController
        vc?.installTypeLabel.text = conversionInfo["af_status"] as? String
        
        var firstLaunchFlag = false
        if let firstLaunch = conversionInfo["is_first_launch"]{

            if firstLaunch as! Int == 1 {
                firstLaunchFlag = true
                print("found first launch")
            }
        }
                

        if (conversionInfo["af_status"] as? String == "Non-organic"){
            vc?.mediaSourceLabel.text = conversionInfo["media_source"] as? String
            
            
            
            // GCD Redirection Code
//            if(conversionInfo["is_first_launch"] as! Int == 1){
//
//
//                if firstLaunchFlag {
//                    if let deepLinkValue = conversionInfo["deep_link_value"] {
//                        if ["red", "blue", "green"].contains(deepLinkValue as! String){
//                            openDeepLinkView(color: deepLinkValue as! String)
//
//                        }
//                    }
//                }
//
//            }
            
            
        
            
        }

        if (conversionInfo["campaign"] as? String == "Non-organic"){
            vc?.mediaSourceLabel.text = conversionInfo["media_source"] as? String
        }
        
    }
    func onConversionDataFail(_ error: Error) {
        
        
    }
    
    
    func onAppOpenAttribution(_ attributionData: [AnyHashable : Any]) {
        print ("OAOA Data: \(attributionData as AnyObject)")


//        openDeepLinkView(color: attributionData["deep_link_value"] as! String)
    }
    



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        AppsFlyerLib.shared().appsFlyerDevKey = "tVH7k3UWZjQpS8x2FNTszn"
        AppsFlyerLib.shared().appleAppID = "1479369723"
        AppsFlyerLib.shared().isDebug = true
        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().deepLinkDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendLaunch), name: UIApplication.didBecomeActiveNotification, object: nil)

        
        return true
    }
    
    @objc func sendLaunch() {
        AppsFlyerLib.shared().start()
    }

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
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
      AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
      return true
    }
            
    func openDeepLinkView(color: String){
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let deepLinkViewController = storyBoard.instantiateViewController(withIdentifier: "deeplinkview") as! DeepLinkViewController
        
        deepLinkViewController.viewColor = color
        
        UIApplication.shared.windows.first?.rootViewController?.present(deepLinkViewController, animated: true, completion: nil)

        
                
    }
    
    
    

}

extension AppDelegate: DeepLinkDelegate {
    func didResolveDeepLink(_ result: DeepLinkResult) {
        switch result.status {
        case .notFound:
            print("Deep link not found")
        case .found:
            let deepLinkStr:String = result.deepLink!.toString()
            print("DeepLink data is: \(deepLinkStr)")
            if( result.deepLink?.isDeferred == true) {
                print("This is a deferred deep link")
            } else {
                print("This is a direct deep link")
            }

            if let deepLinkValue = result.deepLink?.deeplinkValue{
                openDeepLinkView(color: deepLinkValue)
            }

        case .failure:
            print("Error %@", result.error!)
        }
    }
}

