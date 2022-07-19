//
//  Wrapper.swift
//  wrappedaf
//
//  Created by Mark Serrano on 8/5/21.
//

import Foundation
import AppsFlyerLib

public class Wrapper {
    
    public init(){
        
        AppsFlyerLib.shared().isDebug = true
        let myInstance = AppsFlyerLib.shared()

        print("module instance:")
        print(myInstance)
        
        print("wrapped inited")
    }
    
}
