//
//  CountDownTimer.swift
//  Fuzzy
//
//  Created by Carson Clark on 2024-08-18.
//

import Foundation
import SwiftUI

class CountdownTimer: ObservableObject {
    @Published var countdown: Int?
    private var timer: Timer?

    func start(seconds: Int) {
        countdown = seconds
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateCountdown()
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        countdown = nil
    }

    private func updateCountdown() {
        if let currentCount = countdown, currentCount > 0 {
            countdown = currentCount - 1
        } else {
            stop()
        }
    }
}

