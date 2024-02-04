//
//  Access.swift
//  Fuzzy
//
//  Created by Carson Clark on 2024-02-04.
//

import Foundation
import Cocoa

func requestAccessibilityAccess() {
    let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
    let accessEnabled = AXIsProcessTrustedWithOptions(options)

    if !accessEnabled {
        // The process is not trusted for accessibility access.
        // Prompt the user to grant accessibility access.
        let alert = NSAlert()
        alert.messageText = "Accessibility Access Required"
        alert.informativeText = "Please grant accessibility access to enable all features of this application."
        alert.addButton(withTitle: "Open System Preferences")
        alert.addButton(withTitle: "Cancel")

        let modalResult = alert.runModal()
        if modalResult == .alertFirstButtonReturn {
            if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility") {
                NSWorkspace.shared.open(url)
            }
        }
    }
}
