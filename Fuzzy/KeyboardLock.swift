import Foundation
import CoreFoundation
import CoreGraphics

class KeyboardLock {
    private var eventTap: CFMachPort?

    func lockKeyboard(countdownTimer: CountdownTimer, seconds: Int? = nil, accessGranted: Bool, showAlert: inout Bool, isKeyboardLocked: inout Bool) {
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
    
    func unlockKeyboard(countdownTimer: CountdownTimer, showAlert: inout Bool, isKeyboardLocked: inout Bool) {
        isKeyboardLocked = false
        showAlert = false
        countdownTimer.stop()
        disableEventTap()
    }

    func countdownTimerMessage(countdownTimer: CountdownTimer) -> String {
        if let countdown = countdownTimer.countdown {
            return "Your keyboard will be unlocked in \(countdown) seconds."
        } else {
            return "Your keyboard is locked."
        }
    }
    
    private func createEventTap() {
        let eventMask = (1 << CGEventType.keyDown.rawValue) | (1 << CGEventType.keyUp.rawValue)
        eventTap = CGEvent.tapCreate(tap: .cghidEventTap,
                                     place: .headInsertEventTap,
                                     options: .defaultTap,
                                     eventsOfInterest: CGEventMask(eventMask),
                                     callback: eventTapCallback,
                                     userInfo: nil)
        
        guard let eventTap = eventTap else {
            print("Failed to create event tap.")
            exit(1)
        }
        
        let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0)
        CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .defaultMode)
        CGEvent.tapEnable(tap: eventTap, enable: true)
        CFRunLoopRun()
    }
    
    private func disableEventTap() {
        if let eventTap = eventTap {
            CGEvent.tapEnable(tap: eventTap, enable: false)
        }
    }
}

// Event tap callback function, kept outside the class as it’s a C function
func eventTapCallback(proxy: CGEventTapProxy, type: CGEventType, event: CGEvent, refcon: UnsafeMutableRawPointer?) -> Unmanaged<CGEvent>? {
    if type == .keyDown || type == .keyUp {
        return nil
    }
    return Unmanaged.passRetained(event)
}
