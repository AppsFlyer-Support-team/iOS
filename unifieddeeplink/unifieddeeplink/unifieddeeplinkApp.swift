//
//  unifieddeeplinkApp.swift
//  unifieddeeplink
//
//  Created by Mark Serrano on 11/23/20.
//

import SwiftUI
import AppsFlyerLib
import AppTrackingTransparency
import os

var showView = ShowingView(showingView: false)


class AppDelegate: NSObject, UIApplicationDelegate, AppsFlyerLibDelegate, DeepLinkDelegate {
    
    
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        
    }
    
    func onConversionDataFail(_ error: Error) {
    
    }
    
    func didResolveDeepLink(_ result: DeepLinkResult) {
        switch result.status {
            case .notFound:
                os_log(.debug, "Deep link not found")
            case .found:
                let deepLinkStr:String = result.deepLink!.toString()
                let otherString = deepLinkStr
               // os_log(.debug, "DeepLink data is: \(otherString)")
                
                os_log(.debug, "DeepLink color is: \(result.deepLink?.clickEvent["deep_link_value"] as! NSObject)")
              
                if( result.deepLink?.isDeferred == true) {
                    os_log(.debug, "This is a deferred deep link")
                } else {
                    os_log(.debug, "This is a direct deep link")
                }
                
                takeDeepLink(deepLinkValue: result.deepLink!)
            
            case .failure:
                print("Error %@", result.error!)
        }
    }
    
    func takeDeepLink(deepLinkValue: DeepLink){
        
        guard let color = deepLinkValue.clickEvent["deep_link_value"] as? String else {
                print("Could not get the deep_link_value")
                return
        }
        
        showView.displayView = true
        showView.color = color
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        AppsFlyerLib.shared()
        AppsFlyerLib.shared().isDebug = true


        AppsFlyerLib.shared().appsFlyerDevKey = "tVH7k3UWZjQpS8x2FNTszn"
        AppsFlyerLib.shared().appleAppID = "1541756613"
        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().deepLinkDelegate = self
        AppsFlyerLib.shared().isDebug = true
//
        
        UNUserNotificationCenter.current()
            //2
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
              //3
              print("Permission granted: \(granted)")
            }
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        print("did become active")
        
        
    }
}



@main
struct unifieddeeplinkApp: App {
    
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView(showingView: showView)
                .onOpenURL(perform: { url in
                    AppsFlyerLib.shared().performOnAppAttribution(with: url)
                })
        }
        .onChange(of: scenePhase){ phase in
    
    
            if phase == .active{
    
                AppsFlyerLib.shared().start()
            }
    
        }
    }
    
}




