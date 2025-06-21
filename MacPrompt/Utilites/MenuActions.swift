import Foundation
import AppKit

class MenuActions: NSObject {
    let powerManager: PowerManager
    let fileManager: FileManagerHelper
    
    init(powerManager: PowerManager, fileManager: FileManagerHelper) {
        self.powerManager = powerManager
        self.fileManager = fileManager
        super.init()
    }
    
    @objc func enableIndefiniteAwake() {
        powerManager.activateCaffeinate()
    }
    
    @objc func enableAwakeFor15Minutes() {
        powerManager.activateCaffeinate(duration: 15 * 60)
    }
    
    @objc func enableAwakeFor30Minutes() {
        powerManager.activateCaffeinate(duration: 30 * 60)
    }
    
    @objc func enableAwakeFor1Hour() {
        powerManager.activateCaffeinate(duration: 60 * 60)
    }
    
    @objc func enableAwakeFor2Hours() {
        powerManager.activateCaffeinate(duration: 2 * 60 * 60)
    }
    
    @objc func enableAwakeFor4Hours() {
        powerManager.activateCaffeinate(duration: 4 * 60 * 60)
    }
    
    @objc func disableAwake() {
        powerManager.disableAwake()
    }
    
    @objc func createTextFile() {
        fileManager.createTextFile()
    }
    
    @objc func showAbout() {
        let alert = NSAlert()
        alert.messageText = "MacPrompt"
        alert.informativeText = "A powerful menu bar app with stay-awake functionality and file management tools.\n\nVersion 1.0"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc func quitApp() {
        powerManager.disableAwake()
        NSApplication.shared.terminate(nil)
    }
}
