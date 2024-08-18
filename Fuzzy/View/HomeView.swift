import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var isKeyboardLocked: Bool = false
    
    var body: some View {
        VStack {
            Image("fuzzkb")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 190)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(strokeColor, lineWidth: 4)
                )
            Text("Fuzzy - Keyboard Cleaning Tool")
                .font(.largeTitle)
                .padding(.bottom, 10)

            VStack {
                Text("*Grant permissions via System Settings > Privacy & Security > Accessibility*")
                    .padding()
                    .font(.title3)
            }
           
            Button(isKeyboardLocked ? "Unlock Keyboard" : "Lock Keyboard") {
                isKeyboardLocked.toggle()
                if isKeyboardLocked {
                    createEventTap()
                } else {
                    disableEventTap()
                }
            }.buttonStyle(.bordered)
                .padding(.top, 40)

            if isKeyboardLocked {
                Text("Your keyboard is locked. Please click 'Unlock Keyboard' button above." )
                    .foregroundColor(.red)
                    .padding(.top, 3)
            } else {
                Text("Your keyboard is unlocked.")
                    .padding(.top, 3)
            }
        }
    }
    
    var strokeColor: Color {
        return colorScheme == .light ? Color.black : Color.white
    }
}

#Preview {
    HomeView()
}
