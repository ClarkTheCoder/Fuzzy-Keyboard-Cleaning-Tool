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
                .frame(minWidth:770, idealWidth: 770, maxWidth: 770, minHeight: 450, idealHeight: 450, maxHeight: 450)
                .fixedSize()
        }.windowResizability(.contentSize)
    }
}
