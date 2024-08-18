import SwiftUI

struct ContentView: View {
    init() {
        requestAccessibilityAccess()
    }
    
    var body: some View {
        NavigationSplitView {
            SidebarView()
                .frame(minWidth: 100)
        } detail: {
            HomeView()
        }
    }
}

#Preview {
    ContentView()
}
