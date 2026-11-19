import SwiftUI
import AppKit

@main
struct MyApp: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .defaultSize(width: 320, height: 150)
        .windowResizability(.contentSize)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {

    let hotKeyManager = HotKeyManager()

    func applicationDidFinishLaunching(_ notification: Notification) {
        hotKeyManager.register()
    }
}
