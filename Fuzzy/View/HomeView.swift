import SwiftUI
import StoreKit

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var countdownTimer = CountdownTimer()
    @State var isKeyboardLocked: Bool = false
    @State private var showAlert = false
    @State private var accessGranted = AXIsProcessTrusted() // Check access status initially
    private let appStorePrompts = AppStoreTracker()
    private let keyboardLock = KeyboardLock() // Instance of KeyboardLock
    
    var body: some View {
        ZStack {
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
                    .padding(.bottom, 2)
                
                VStack {
                    Text("Grant accessibility access via System Settings > Privacy & Security > Accessibility")
                    Text("Locate 'Fuzzy' App and enable permissions")
                    Text("Then close the app and reopen")
                        .fontWeight(.bold)
                }
                
                if accessGranted {
                    HStack {
                        Button(isKeyboardLocked ? "Unlock Keyboard" : "Lock Keyboard") {
                            SoundManager.shared.playSound(named: "fuzzy-notification-sound")
                            if isKeyboardLocked {
                                keyboardLock.unlockKeyboard(countdownTimer: countdownTimer, showAlert: &showAlert, isKeyboardLocked: &isKeyboardLocked)
                            } else {
                                keyboardLock.lockKeyboard(countdownTimer: countdownTimer, accessGranted: accessGranted, showAlert: &showAlert, isKeyboardLocked: &isKeyboardLocked)
                            }
                        }
                        .buttonStyle(.bordered)
                        
                        Button("30 Second Lock") {
                            SoundManager.shared.playSound(named: "fuzzy-notification-sound")
                            keyboardLock.lockKeyboard(countdownTimer: countdownTimer, seconds: 30, accessGranted: accessGranted, showAlert: &showAlert, isKeyboardLocked: &isKeyboardLocked)
                        }
                        .buttonStyle(.bordered)
                    } .padding(.top, 20)
                    
                    if isKeyboardLocked {
                        VStack {
                            Text("Your keyboard is locked. Please click 'Unlock Keyboard'")
                                .foregroundColor(.red)
                                .padding(.top, 2)
                        }
                    } else {
                        Text("Your keyboard is unlocked.").padding(.top, 2)
                    }
                }
                Link("How to install Fuzzy", destination: URL(string: "https://www.youtube.com/watch?v=LR598lOSgYE&t=4s")!)
                    .foregroundColor(.blue)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Keyboard Locked"),
                    message: Text(keyboardLock.countdownTimerMessage(countdownTimer: countdownTimer)),
                    dismissButton: .default(Text("Unlock Now"), action: {
                        keyboardLock.unlockKeyboard(countdownTimer: countdownTimer, showAlert: &showAlert, isKeyboardLocked: &isKeyboardLocked)
                    })
                )
            }
            .onReceive(countdownTimer.$countdown) { remainingTime in
                if remainingTime == 0 {
                    keyboardLock.unlockKeyboard(countdownTimer: countdownTimer, showAlert: &showAlert, isKeyboardLocked: &isKeyboardLocked)
                }
            }
            .onAppear {
                accessGranted = AXIsProcessTrusted()
                appStorePrompts.incrementHomepageVisits()
                appStorePrompts.promptReviewIfAppropriate()
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
