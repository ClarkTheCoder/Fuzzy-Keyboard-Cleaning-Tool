//
//  FireBaseLogging.swift
//  Fuzzy
//
//  Created by Carson Clark on 2024-08-27.
//

import Foundation
import FirebaseAnalytics

class FireBaseLogging {
    
    static func logMainButtonClick(){
        Analytics.logEvent("button_click", parameters: [
            "button_name": "Main Button",
            "timestamp": Date().timeIntervalSince1970
        ])
    }
    
    static func log30SecButtonClick(){
        Analytics.logEvent("button_click", parameters: [
            "button_name": "30_Second_Lock",
            "timestamp": Date().timeIntervalSince1970
        ])
    }
    
    static func logUnlockNowButtonClick(){
        Analytics.logEvent("button_click", parameters: [
            "button_name": "Unlock Now",
            "timestamp": Date().timeIntervalSince1970
        ])
    }
    
    static func logScreenView() {
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [
            AnalyticsParameterScreenName: "HomeView",
            AnalyticsParameterScreenClass: "HomeView"
        ])
    }
}

