import Foundation
import IOKit.pwr_mgt

class PowerManager {
    private var assertionID: IOPMAssertionID = 0
    private(set) var isAwake = false
    private var sleepTimer: Timer?
    private var displayTimer: Timer?
    private(set) var endTime: Date?
    
    var onStateChange: ((Bool, Date?) -> Void)?
    
    func activateCaffeinate(duration: TimeInterval? = nil) {
        // Always disable any previous assertion first
        disableAwake()
        
        let reasonForActivity = "Prevent display sleep" as CFString
        
        // Request a power management assertion to prevent display sleep
        let result = IOPMAssertionCreateWithName(
            kIOPMAssertionTypeNoDisplaySleep as CFString,
            IOPMAssertionLevel(kIOPMAssertionLevelOn),
            reasonForActivity,
            &assertionID
        )
        
        // If successful, update the state and setup timers
        if result == kIOReturnSuccess {
            isAwake = true
            
            // Set end time if duration is specified
            if let duration = duration {
                endTime = Date().addingTimeInterval(duration)
                sleepTimer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(disableAwake), userInfo: nil, repeats: false)
                
                // Start display update timer
                displayTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateDisplay), userInfo: nil, repeats: true)
            } else {
                endTime = nil
            }
            
            onStateChange?(isAwake, endTime)
        }
    }
    
    @objc func disableAwake() {
        if isAwake {
            IOPMAssertionRelease(assertionID)
            isAwake = false
        }
        
        sleepTimer?.invalidate()
        sleepTimer = nil
        
        displayTimer?.invalidate()
        displayTimer = nil
        
        endTime = nil
        onStateChange?(isAwake, endTime)
    }
    
    @objc private func updateDisplay() {
        onStateChange?(isAwake, endTime)
    }
}
