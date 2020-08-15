//
//  AppDelegate.swift
//  FSWatch
//
//  Created by Danny Hawkins on 15/08/2020.
//

import Cocoa
import SwiftUI
import EonilFSEvents

extension Notification.Name {
    static let filesChanged = Notification.Name("filesChanged")
}

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var window: NSWindow!
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()
        
        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        
        do {
            try EonilFSEvents.startWatching(
                paths: ["Users/danny/Code"],
                for: ObjectIdentifier(self),
                with: { event in
                    NotificationCenter.default.post(.init(name: .filesChanged, object: event))
                })
        } catch {
            print("unexpected error")
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
}

