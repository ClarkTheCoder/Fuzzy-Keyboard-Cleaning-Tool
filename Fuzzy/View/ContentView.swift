import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var isKeyboardLocked: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Image("fuzzkb")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 230, height: 250)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(strokeColor, lineWidth: 7)
                    )
                Text("Fuzzy - A Keyboard Cleaning tool")
                    .font(.largeTitle)
                    .padding(.bottom, 10)

                VStack {
//                    Text("This application is designed to disable your keyboard temporarily, allowing you to easily clean it without the risk of inadvertently turning on your Mac or generating unintended input. Click 'Lock Keyboard' to begin, and when you're done simply click 'Unlock Keyboard' or exit the app.")
//                        .font(.title2)
                    Text("This application is designed to disable your keyboard temporarily, allowing you to easily clean it without the risk of inadvertently turning on your Mac or generating unintended input. Please grant system permissions first.")
                        .font(.title2)
                    Text("Grant permissions via System Settings > Privacy & Security > Accessibility")
                        .padding()
                        .font(.title3)
                }
                .frame(width: 900)

                Button(isKeyboardLocked ? "Unlock Keyboard" : "Lock Keyboard") {
                    // Action when the button is clicked
                    isKeyboardLocked.toggle()
                    if isKeyboardLocked {
                        createEventTap()
                    } else {
                        disableEventTap()
                    }
                }.buttonStyle(.bordered)

                if isKeyboardLocked {
                    Text("Your keyboard is locked. Please click 'Unlock Keyboard' button above." )
                        .foregroundColor(.red)
                }else {
                    Text("Your keyboard is unlocked.")
                }

                Link("Installation & Troubleshooting", destination: URL(string: "https://carsonclark.dev")!)
                    .padding()
            }
        }
    }
    
    var strokeColor: Color {
        return colorScheme == .light ? Color.black : Color.white
    }
}

