import SwiftUI
import AppKit

@main
struct StayAwakeApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {} //app runs in the menu bar
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem! // Menu bar item
    var assertionID: IOPMAssertionID = 0 // Power assertion ID used to prevent sleep
    var isAwake = false // Tracks whether system sleep is currently prevented
    var sleepTimer: Timer? // Optional timer to auto-disable stay-awake mode

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create the status bar item with a dynamic width
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        // Set the icon for the menu bar button
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "cup.and.saucer.fill", accessibilityDescription: "Stay Awake")
        }

        constructMenu()
    }

    // Build the dropdown menu with time options and disable control
    func constructMenu() {
        let menu = NSMenu()

        // Menu options to enable stay awake for different durations
        menu.addItem(NSMenuItem(title: "Stay Awake Indefinitely", action: #selector(enableIndefiniteAwake), keyEquivalent: "I"))
        menu.addItem(NSMenuItem(title: "Stay Awake for 15 Minutes", action: #selector(enableAwakeFor15Minutes), keyEquivalent: "1"))
        menu.addItem(NSMenuItem(title: "Stay Awake for 30 Minutes", action: #selector(enableAwakeFor30Minutes), keyEquivalent: "2"))
        menu.addItem(NSMenuItem(title: "Stay Awake for 1 Hour", action: #selector(enableAwakeFor1Hour), keyEquivalent: "3"))

        // Separator and disable option
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Disable Stay Awake", action: #selector(disableAwake), keyEquivalent: "D"))

        statusItem.menu = menu
    }

    // Activates the no-sleep assertion, optionally for a limited time
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

        // If successful, update the state and icon
        if result == kIOReturnSuccess {
            isAwake = true
            statusItem.button?.image = NSImage(systemSymbolName: "cup.and.saucer", accessibilityDescription: "Stay Awake")

            // If a duration is specified, set a timer to disable later
            if let duration = duration {
                sleepTimer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(disableAwake), userInfo: nil, repeats: false)
            }
        }
    }

    @objc func enableIndefiniteAwake() {
        activateCaffeinate()
    }

    @objc func enableAwakeFor15Minutes() {
        activateCaffeinate(duration: 15 * 60)
    }

    @objc func enableAwakeFor30Minutes() {
        activateCaffeinate(duration: 30 * 60)
    }

    @objc func enableAwakeFor1Hour() {
        activateCaffeinate(duration: 60 * 60)
    }

    // Releases the no-sleep assertion and clears timer
    @objc func disableAwake() {
        if isAwake {
            IOPMAssertionRelease(assertionID)
            isAwake = false
            statusItem.button?.image = NSImage(systemSymbolName: "cup.and.saucer.fill", accessibilityDescription: "Sleep Enabled")
        }

        sleepTimer?.invalidate()
        sleepTimer = nil
    }
}
