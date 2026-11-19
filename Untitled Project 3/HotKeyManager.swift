//
//  HotKeyManager.swift
//  Untitled Project 3
//
//  Created by  柊大 on 2026/11/19.
//

import SwiftUI
import Carbon

class HotKeyManager {

    var hotKeyRef: EventHotKeyRef?
    var eventHandler: EventHandlerRef?

    func register() {
        var eventType = EventTypeSpec(
            eventClass: OSType(kEventClassKeyboard),
            eventKind: OSType(kEventHotKeyPressed)
        )

        InstallEventHandler(
            GetApplicationEventTarget(),
            { _, _, userData in
                let manager = Unmanaged<HotKeyManager>
                    .fromOpaque(userData!)
                    .takeUnretainedValue()

                DispatchQueue.main.async {
                    manager.toggleWindow()
                }
                return noErr
            },
            1,
            &eventType,
            Unmanaged.passUnretained(self).toOpaque(),
            &eventHandler
        )

        let hotKeyID = EventHotKeyID(
            signature: OSType(0x4D434841),
            id: 1
        )

        RegisterEventHotKey(
            UInt32(kVK_Space),
            UInt32(optionKey),
            hotKeyID,
            GetApplicationEventTarget(),
            0,
            &hotKeyRef
        )
    }

    func toggleWindow() {
        if let window = NSApp.windows.first {
            if window.isVisible {
                window.orderOut(nil)
            } else {
                NSApp.activate(ignoringOtherApps: true)
                window.makeKeyAndOrderFront(nil)
            }
        }
    }

    // この下に追加！
    func hideWindow() {
        NSApp.keyWindow?.orderOut(nil)
    }
    }
