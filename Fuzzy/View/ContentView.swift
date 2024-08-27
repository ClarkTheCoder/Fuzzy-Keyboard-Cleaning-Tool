import SwiftUI
import StoreKit
import Firebase
import FirebaseAnalytics

struct ContentView: View {
    init() {
        requestAccessibilityAccess() 
        FirebaseApp.configure()
        Analytics.setAnalyticsCollectionEnabled(true)
    }
    
    var body: some View {
        NavigationSplitView {
            SidebarView()
        } detail: {
            HomeView()
        }
    }
}

#Preview {
    ContentView()
}
