import SwiftUI

struct SidebarView: View {
    var body: some View {
        List {
            NavigationLink("Home", destination: HomeView())
            NavigationLink("Installation", destination: SupportView())
            NavigationLink("About", destination: AboutView())

        }
        .listStyle(SidebarListStyle())
    }
}

#Preview {
    SidebarView()
}
