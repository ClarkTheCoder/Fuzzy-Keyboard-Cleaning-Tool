//
//  SoundManager.swift
//  Fuzzy
//
//  Created by Carson Clark on 2024-08-18.
//

import Foundation
import AppKit

class SoundManager {

    // Ensure only one instance throughout the app (Singleton Pattern)
    static let shared = SoundManager()
    
    // Define a function that plays a sound given its name
    func playSound(named soundName: String) {
        if let sound = NSSound(named: soundName) {
            sound.play()
        } else {
            print("Sound file \(soundName) not found.")
        }
    }
}
