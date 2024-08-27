//
//  FuzzyApp.swift
//  Fuzzy
//
//  Created by Carson Clark on 2024-01-29.
//

import SwiftUI
import FirebaseCore
import FirebaseAnalytics

@main
struct FuzzyApp: App {
    
//    init() {
//        FirebaseApp.configure()
//        Analytics.setAnalyticsCollectionEnabled(true)
//    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth:700, idealWidth: 700, maxWidth: 700, minHeight: 420, idealHeight: 420, maxHeight: 420)
                .fixedSize()
        }.windowResizability(.contentSize)
    }
}
