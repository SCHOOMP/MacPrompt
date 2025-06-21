import AppKit

class MenuBuilder {
    private let powerManager: PowerManager
    private let statusBarManager: StatusBarManager
    private let fileManager: FileManagerHelper
    private weak var appDelegate: AppDelegate?
    var menuActions: MenuActions
    
    init(powerManager: PowerManager, statusBarManager: StatusBarManager, fileManager: FileManagerHelper, appDelegate: AppDelegate) {
        self.powerManager = powerManager
        self.statusBarManager = statusBarManager
        self.fileManager = fileManager
        self.appDelegate = appDelegate
        self.menuActions = MenuActions(powerManager: powerManager,
                                     fileManager: fileManager)
    }
    
    func createMenu() -> NSMenu {
        let menu = NSMenu()
        
        // Status item
        addStatusItem(to: menu)
        menu.addItem(NSMenuItem.separator())
        
        // Stay Awake submenu
        addStayAwakeSubmenu(to: menu)
        
        // Create File submenu
        addCreateFileSubmenu(to: menu)
        
        // Quick Actions
        addQuickActions(to: menu)
        
        // Settings submenu
        addSettingsSubmenu(to: menu)
        
        return menu
    }
    
    private func addStatusItem(to menu: NSMenu) {
        let statusMenuItem = NSMenuItem(title: powerManager.isAwake ? "Status: Active" : "Status: Inactive", action: nil, keyEquivalent: "")
        statusMenuItem.isEnabled = false
        menu.addItem(statusMenuItem)
    }
    
    private func addStayAwakeSubmenu(to menu: NSMenu) {
        let stayAwakeMenuItem = NSMenuItem(title: "Stay Awake", action: nil, keyEquivalent: "")
        let stayAwakeSubmenu = NSMenu(title: "Stay Awake")
        
        // Create menu items and set their targets
        let indefiniteItem = NSMenuItem(title: "Indefinitely", action: #selector(MenuActions.enableIndefiniteAwake), keyEquivalent: "I")
        indefiniteItem.target = menuActions
        stayAwakeSubmenu.addItem(indefiniteItem)
        
        stayAwakeSubmenu.addItem(NSMenuItem.separator())
        
        let fifteenMinItem = NSMenuItem(title: "15 Minutes", action: #selector(MenuActions.enableAwakeFor15Minutes), keyEquivalent: "1")
        fifteenMinItem.target = menuActions
        stayAwakeSubmenu.addItem(fifteenMinItem)
        
        let thirtyMinItem = NSMenuItem(title: "30 Minutes", action: #selector(MenuActions.enableAwakeFor30Minutes), keyEquivalent: "2")
        thirtyMinItem.target = menuActions
        stayAwakeSubmenu.addItem(thirtyMinItem)
        
        let oneHourItem = NSMenuItem(title: "1 Hour", action: #selector(MenuActions.enableAwakeFor1Hour), keyEquivalent: "3")
        oneHourItem.target = menuActions
        stayAwakeSubmenu.addItem(oneHourItem)
        
        let twoHourItem = NSMenuItem(title: "2 Hours", action: #selector(MenuActions.enableAwakeFor2Hours), keyEquivalent: "4")
        twoHourItem.target = menuActions
        stayAwakeSubmenu.addItem(twoHourItem)
        
        let fourHourItem = NSMenuItem(title: "4 Hours", action: #selector(MenuActions.enableAwakeFor4Hours), keyEquivalent: "5")
        fourHourItem.target = menuActions
        stayAwakeSubmenu.addItem(fourHourItem)
        
        stayAwakeMenuItem.submenu = stayAwakeSubmenu
        menu.addItem(stayAwakeMenuItem)
    }
    
    private func addCreateFileSubmenu(to menu: NSMenu) {
        let createFileMenuItem = NSMenuItem(title: "Create File", action: nil, keyEquivalent: "")
        let createFileSubMenu = NSMenu(title: "Create File")
        
        let createTextFileItem = NSMenuItem(title: "Create Text File", action: #selector(MenuActions.createTextFile), keyEquivalent: "1")
        createTextFileItem.target = menuActions
        createFileSubMenu.addItem(createTextFileItem)
        
        createFileMenuItem.submenu = createFileSubMenu
        menu.addItem(createFileMenuItem)
    }
    
    private func addQuickActions(to menu: NSMenu) {
        menu.addItem(NSMenuItem.separator())
        
        let quickThirtyItem = NSMenuItem(title: "Quick: 30 Min", action: #selector(MenuActions.enableAwakeFor30Minutes), keyEquivalent: "Q")
        quickThirtyItem.target = menuActions
        menu.addItem(quickThirtyItem)
        
        let disableItem = NSMenuItem(title: "Disable", action: #selector(MenuActions.disableAwake), keyEquivalent: "D")
        disableItem.target = menuActions
        menu.addItem(disableItem)
    }
    
    private func addSettingsSubmenu(to menu: NSMenu) {
        menu.addItem(NSMenuItem.separator())
        let settingsMenuItem = NSMenuItem(title: "Settings", action: nil, keyEquivalent: "")
        let settingsSubmenu = NSMenu(title: "Settings")
        
        let aboutItem = NSMenuItem(title: "About MacPrompt", action: #selector(MenuActions.showAbout), keyEquivalent: "")
        aboutItem.target = menuActions
        settingsSubmenu.addItem(aboutItem)
        
        settingsSubmenu.addItem(NSMenuItem.separator())
        
        let quitItem = NSMenuItem(title: "Quit", action: #selector(MenuActions.quitApp), keyEquivalent: "q")
        quitItem.target = menuActions
        settingsSubmenu.addItem(quitItem)
        
        settingsMenuItem.submenu = settingsSubmenu
        menu.addItem(settingsMenuItem)
    }
}
