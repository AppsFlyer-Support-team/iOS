//
//  ContentView.swift
//  ios-sample
//
//  Created by Mark Serrano on 2019/10/29.
//  Copyright © 2019 Mark. All rights reserved.
//

import SwiftUI
import AppsFlyerLib
import AppTrackingTransparency




struct ContentView: View {
    var body: some View {

        VStack {
            
            Button(action: {
                print("Start SDK")
                AppsFlyerLib.shared().start()

            }) {
                
                Text("Start SDK")

            }
            Button(action: {
                
                AppsFlyerLib.shared().isDebug = true
                AppsFlyerLib.shared().appsFlyerDevKey = "tVH7k3UWZjQpS8x2FNTszn"
                AppsFlyerLib.shared().appleAppID = "1479369723"
                AppsFlyerLib.shared().customerUserID = "mycuid"
                
                
                print("ContentView object")
                print(AppsFlyerLib.shared())
            
                print("Test Event 1 Pressed")
                
                AppsFlyerLib.shared().logEvent(AFEventPurchase, withValues: [AFEventParamRevenue: 1.00, "item" : "shirt", "store" : "San Francisco"])
                                

            }) {
                Text("Purchase")
            }
            Button(action: {
                print("Event 2 Pressed")
           
                
//                AppsFlyerShareInviteHelper.generateInviteUrl(linkGenerator:
//                 {(_ generator: AppsFlyerLinkGenerator) -> AppsFlyerLinkGenerator in
//                  generator.setChannel("channel_name")
//                  generator.setReferrerName("referrer_name")
//                  generator.addParameterValue("2.5", forKey: "af_cost_value")
//                  // optional - set a brand domain to the user invite link
//        //            generator.brandDomain = "brand.domain.com"
//                  return generator },
//                completionHandler: {(_ url: URL?) -> Void in
//
//                    print("URL: \(url)")
//
//                })
//
//                if #available(iOS 14, *) {
//                    ATTrackingManager.requestTrackingAuthorization { (status) in
//                        NSLog("[DEBUG] [CLIENT] Appsflyer: ATT response status: \(status)")
//                    }
//                } else {
//                    // Fallback on earlier versions
//                }


            }) {
                
                Text("Event 2")
                

            }
            
//            Button(action: {
//
//                print("Send Launch")
//                AppsFlyerLib.shared().isDebug = true
//                AppsFlyerLib.shared().appsFlyerDevKey = "tVH7k3UWZjQpS8x2FNTszn"
//                AppsFlyerLib.shared().appleAppID = "1479369723"
//                AppsFlyerLib.shared().deepLinkDelegate = mydelegate()
//
//
//            }) {
//
//                Text("Purchase")
//
//            }
//            Button(action: {
//
////                print("start")
////                AppsFlyerLib.shared().start()
//
//                        if #available(iOS 14, *) {
//
//                           AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 30)
//
//                            ATTrackingManager.requestTrackingAuthorization { (status) in
//                                NSLog("[DEBUG] [CLIENT] Appsflyer: ATT response status: \(status)")
//                            }
//                        }
//
//
//            }) {
//
//                Text("start")
//
//            }
            
//            Button(action: {
//
//                AppsFlyerLib.shared().customerUserID = "maaark"
//                AppsFlyerLib.shared().start();
//
//
//            }) {
//                Text("Start with cuid")
//            }
//            Button(action: {
//
//
//                // AppsFlyerTracker.shared().trackEvent("secondEvent", withValues: [:])
//                AppsFlyerLib.shared().logEvent("secondEvent", withValues: [:])
//
//            }) {
//                Text("Start without cuid")
//            }
//            Button(action: {
//
//
//                let cuid = AppsFlyerLib.shared().customerUserID
//
//                if ((cuid) != nil){
//                    print("AF cuid: \(AppsFlyerLib.shared().customerUserID)")
//                } else {
//                    print("no cuid")
//                }
//
//
//            }) {
//                Text("Log cuid")
//            }
//            Button(action: {
//
//                AppsFlyerLib.shared().customerUserID = "customer1234"
//            }) {
//                Text("Set cuid")
//            }
//            Button(action: {
//
//                //if let url = URL(string: "https://mrmaakuntest.onelink.me/IeDt/blue"){
//
//                if let url = URL(string: "https://mrmaakuntest.onelink.me/IeDt/blue") {
//                    let userActivity =  NSUserActivity(activityType: NSUserActivityTypeBrowsingWeb)
//                    userActivity.webpageURL = url;
//                    UIApplication.shared.delegate?.application?(UIApplication.shared, continue: userActivity, restorationHandler: { _ in })
//
//
//                }
//
//            }) {
//                Text("Open Universal Link")
//            }
            
//            Button(action: {
//
//                if AppsFlyerLib.shared().isStopped == true {
//
//                    AppsFlyerLib.shared().isStopped = false
//                    print("Toggling Stop Tracking to FALSE")
//
//                } else if AppsFlyerLib.shared().isStopped == false {
//
//                    AppsFlyerLib.shared().isStopped = true
//                    print("Toggling Stop Tracking to TRUE")
//
//
//                }
//
//
//            }) {
//                Text("Toggle Stop Tracking")
//            }
            
//            Button(action: {
//
//                AppsFlyerLib.shared().performOnAppAttribution(with: URL(string: "https://mrmaakuntest.onelink.me/IeDt/blue"))
//
//            }) {
//                Text("performOnAppOpenAttribution")
//            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


