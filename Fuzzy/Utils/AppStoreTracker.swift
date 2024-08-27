//
//  AppStorePompts.swift
//  Fuzzy
//
//  Created by Carson Clark on 2024-08-27.
//

import Foundation
import StoreKit

class AppStoreTracker {
    
    private let homepageVisitsKey = "HPVC"
    private let previouslyPromptedKey = "pp"
    
    func incrementHomepageVisits() {
        let currentCount = UserDefaults.standard.integer(forKey: homepageVisitsKey)
        UserDefaults.standard.set(currentCount + 1, forKey: homepageVisitsKey)
    }
    
    func promptReviewIfAppropriate() {
        let currentCount = UserDefaults.standard.integer(forKey: homepageVisitsKey)
        let previouslyPrompted = UserDefaults.standard.bool(forKey: previouslyPromptedKey)
        
        if currentCount >= 2 && !previouslyPrompted {
            SKStoreReviewController.requestReview()
            UserDefaults.standard.set(true, forKey: previouslyPromptedKey)
        }
    }
}
