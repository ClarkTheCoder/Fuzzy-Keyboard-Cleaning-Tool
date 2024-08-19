import SwiftUI
import StoreKit

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var countdownTimer = CountdownTimer()
    @State var isKeyboardLocked: Bool = false
    @State private var showAlert = false
    @State private var accessGranted = AXIsProcessTrusted() // Check access status initially
    
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
                                unlockKeyboard()
                            } else {
                                lockKeyboard()
                            }
                        }
                        .buttonStyle(.bordered)
                        
                        Button("30 Second Lock") {
                                SoundManager.shared.playSound(named: "fuzzy-notification-sound")
                            lockKeyboard(countdown: 30)
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
                    message: Text(countdownTimerMessage),
                    dismissButton: .default(Text("Unlock Now"), action: {
                        unlockKeyboard()
                    })
                )
            }
            .onReceive(countdownTimer.$countdown) { remainingTime in
                if remainingTime == 0 {
                    unlockKeyboard()
                }
            }
            .onAppear {
                accessGranted = AXIsProcessTrusted()
                incrementHomepageVisits()
                promptReviewIfAppropriate()
            }
        }
    }
    
    // MARK: Helper methods
    private func lockKeyboard(countdown seconds: Int? = nil) {
        guard accessGranted else {
            showAlert = true
            return
        }
        isKeyboardLocked = true
        showAlert = true
        if let seconds = seconds {
            countdownTimer.start(seconds: seconds)
        }
        createEventTap()
    }
    
    private func unlockKeyboard() {
        isKeyboardLocked = false
        showAlert = false
        countdownTimer.stop()
        disableEventTap()
    }
    
    var countdownTimerMessage: String {
        if let countdown = countdownTimer.countdown {
            return "Your keyboard will be unlocked in \(countdown) seconds."
        } else {
            return "Your keyboard is locked."
        }
    }
    
    var strokeColor: Color {
        return colorScheme == .light ? Color.black : Color.white
    }
}

// MARK: App Store Review Prompts

func incrementHomepageVisits() {
    let currentCount = UserDefaults.standard.integer(forKey: "HPVC")
    UserDefaults.standard.set(currentCount + 1, forKey: "HPVC")
}

func promptReviewIfAppropriate() {
    let currentCount = UserDefaults.standard.integer(forKey: "HPVC")
    let previouslyPrompted = UserDefaults.standard.bool(forKey: "pp")
    
    if currentCount >= 2 && !previouslyPrompted {
        SKStoreReviewController.requestReview()
        UserDefaults.standard.set(true, forKey: "pp")
    }
}

#Preview {
    HomeView()
}
