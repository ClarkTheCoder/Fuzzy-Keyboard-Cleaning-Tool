import SwiftUI
import StoreKit

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var countdownTimer = CountdownTimer() // Initialize the countdown timer
    @State var isKeyboardLocked: Bool = false
    @State private var showAlert = false

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
                .padding(.bottom, 2)
          
            VStack {
                Text("*Grant permissions via System Settings > Privacy & Security > Accessibility*")
                    .padding()
                    .font(.title3)
            }

            HStack {
                Button(isKeyboardLocked ? "Unlock Keyboard" : "Lock Keyboard") {
                    if isKeyboardLocked {
                        unlockKeyboard()
                    } else {
                        lockKeyboard()
                    }
                }
                .buttonStyle(.bordered)
                .padding(.top, 30)
                
                Button("20 Second Lock") {
                    lockKeyboard(withCountdown: 20)
                }
                .buttonStyle(.bordered)
                .padding(.top, 30)
            }
            
            if isKeyboardLocked {
                VStack {
                    Text("Your keyboard is locked. Please click 'Unlock Keyboard'")
                        .foregroundColor(.red)
                        .padding(.top, 3)
                }
            } else {
                Text("Your keyboard is unlocked.")
                    .padding(.top, 3)
            }
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
            incrementHomepageVisits()
            promptReviewIfAppropriate()
        }
    }
    
    // MARK: Helper methods
    private func lockKeyboard(withCountdown seconds: Int? = nil) {
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
