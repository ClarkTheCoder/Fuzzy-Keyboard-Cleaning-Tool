import SwiftUI

struct SidebarView: View {
    var body: some View {
        List {
            NavigationLink("Home", destination: HomeView())
            NavigationLink("About", destination: AboutView())
            NavigationLink("Support", destination: SupportView())
        }
        .listStyle(SidebarListStyle())
    }
}

#Preview {
    SidebarView()
}
