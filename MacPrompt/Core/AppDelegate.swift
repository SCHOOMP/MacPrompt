import AppKit
import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var powerManager: PowerManager!
    var menuBuilder: MenuBuilder!
    var statusBarManager: StatusBarManager!
    var fileManager: FileManagerHelper!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Initialize managers
        powerManager = PowerManager()
        statusBarManager = StatusBarManager()
        fileManager = FileManagerHelper()
        menuBuilder = MenuBuilder(powerManager: powerManager,
                                 statusBarManager: statusBarManager,
                                 fileManager: fileManager,
                                 appDelegate: self)
        
        // Create the status bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusBarManager.statusItem = statusItem
        
        // Set up initial display and menu
        statusBarManager.updateDisplay(isAwake: powerManager.isAwake, endTime: powerManager.endTime)
        statusItem.menu = menuBuilder.createMenu()
        
        // Set up power manager callbacks
        powerManager.onStateChange = { [weak self] isAwake, endTime in
            self?.statusBarManager.updateDisplay(isAwake: isAwake, endTime: endTime)
            self?.statusItem.menu = self?.menuBuilder.createMenu()
        }
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        powerManager.disableAwake()
    }
}
