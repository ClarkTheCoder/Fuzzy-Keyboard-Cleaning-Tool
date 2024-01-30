//
//  FuzzyApp.swift
//  Fuzzy
//
//  Created by Carson Clark on 2024-01-29.
//

import SwiftUI

@main
struct FuzzyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 1000, idealWidth: 1000, maxWidth: 1000, minHeight: 550, idealHeight: 550, maxHeight: 550)
                .fixedSize()
        }.windowResizability(.contentSize)
    }
}
