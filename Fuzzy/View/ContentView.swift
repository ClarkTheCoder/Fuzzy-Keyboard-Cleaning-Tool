import SwiftUI
import StoreKit

struct ContentView: View {
    init() {
        requestAccessibilityAccess()
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
