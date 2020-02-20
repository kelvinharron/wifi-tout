//
//  AppDelegate.swift
//  wifi-tout
//
//  Created by Matthew Wilson on 28/01/2020.
//  Copyright © 2020 Matthew Wilson. All rights reserved.
//

import Cocoa
import SwiftUI
import UserNotifications

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    private var window: NSWindow!
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    private let eventLogger = EventLogger()
    private var eventMonitor: EventMonitor?
    private lazy var popover = NSPopover()

    private lazy var overviewViewController: OverviewViewController = {
        OverviewViewController()
    }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        eventLogger.logAppStartup()
        enableNotifications()
        setButton()

        popover.contentViewController = overviewViewController

        enableEventMonitor()
        openPopover(sender: self)
    }

    private func enableEventMonitor() {
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            guard let self = self else {
                return
            }
            guard self.popover.isShown else {
                return
            }

            self.closePopover(sender: event)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        eventLogger.logAppTerminated()
    }

    private func enableNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            print("Got permission to emit notifications \(granted)")
        }
    }

    private func setButton() {
        guard let button = statusItem.button else {
            return
        }

        button.image = NSImage(named: "Icon")
        button.action = #selector(togglePopover(_:))

    }

    @objc func togglePopover(_ sender: AnyObject?) {
        if self.popover.isShown {
            closePopover(sender: sender)
        } else {
            openPopover(sender: sender)
        }
    }

    private func closePopover(sender: Any) {
        popover.performClose(sender)

        eventMonitor?.stop()
    }

    private func openPopover(sender: Any) {
        guard let button = statusItem.button else {
            return
        }

        eventMonitor?.start()

        popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
    }
}