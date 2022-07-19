//
//  SceneDelegate.swift
//  ios-sample
//
//  Created by Mark Serrano on 2019/10/29.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit
import SwiftUI
import AppsFlyerLib
import os.log
import wrappedaf


class SceneDelegate: UIResponder, UIWindowSceneDelegate, AppsFlyerLibDelegate {
    
    func initSdk(){
        AppsFlyerLib.shared().appsFlyerDevKey = "tVH7k3UWZjQpS8x2FNTszn"
        AppsFlyerLib.shared().appleAppID = "1479369723"
        AppsFlyerLib.shared().customerUserID = "mycuid"
        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().isDebug = true
        
        
    }
    
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        
       
    }
    
    func onConversionDataFail(_ error: Error) {
        
    }
    
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
       // os_log("markdebug: in scene will connect to", type: .debug)
        
        
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        
        
        let dummyRestorationHandler: ([Any]?) -> Void = {_ in
            
        }
        
        
        
        AppsFlyerLib.shared().continue(userActivity, restorationHandler: dummyRestorationHandler)
    }
    
    func scene(_ scene: UIScene,
               openURLContexts URLContexts: Set<UIOpenURLContext>){
        
//        os_log("markdebug: in scene open url contexts", type: .debug)
        
        
        
        if let url = URLContexts.first?.url {
            AppsFlyerLib.shared().handleOpen(url, options: nil)
        }
        
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
        
//        AppsFlyerShareInviteHelper.generateInviteUrl(linkGenerator:
//         {(_ generator: AppsFlyerLinkGenerator) -> AppsFlyerLinkGenerator in
//          generator.setChannel("channel_name")
//          generator.setReferrerName("referrer_name")
//          generator.addParameterValue("2.5", forKey: "af_cost_value")
//          // optional - set a brand domain to the user invite link
////            generator.brandDomain = "brand.domain.com"
//          return generator },
//        completionHandler: {(_ url: URL?) -> Void in
//
//            print("URL: \(url)")
//            
//        })


        
    }
    
    //    func onAppOpenAttribution(_ attributionData: [AnyHashable: Any]) {
    //        //Handle Deep Link Data
    //
    //        guard let attributionLink: String = attributionData["link"] as? String,
    //        let url: URL = URL(string: attributionLink) else { return }
    //
    //        // From here, extract af_dp from 'url' and then perform the logic that directs users.
    //    }
    
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
    
    
}

