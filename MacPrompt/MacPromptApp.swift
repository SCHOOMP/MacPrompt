import SwiftUI

@main
struct MacPromptApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {} //app runs in the menu bar
    }
}
