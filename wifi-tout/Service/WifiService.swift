//
// Created by Kelvin Harron on 17/02/2020.
// Copyright (c) 2020 Matthew Wilson. All rights reserved.
//

import Foundation
import CoreWLAN

private struct WifiStatus {
    var signalStrength: Int
    var noiseLevel: Int
    var currentSsid: String
    var wifiChannelStatus: WifiChannelStatus
}

private struct WifiChannelStatus {
    var channelNumber: Int
    var channelWidth: Int
}

class WiFiService: CWEventDelegate {

    private let wifiClient = CWWiFiClient()

    init() {
        do {
            try registerForWifiEvents()
        } catch {
            print(error)
        }
    }

    private func registerForWifiEvents() throws {
        try wifiClient.startMonitoringEvent(with: .ssidDidChange)
        try wifiClient.startMonitoringEvent(with: .powerDidChange)
        try wifiClient.startMonitoringEvent(with: .bssidDidChange)
        try wifiClient.startMonitoringEvent(with: .virtualInterfaceStateChanged)
    }


    func bssidDidChangeForWiFiInterface(withName interfaceName: String) {
        print("bssidDidChangeForWiFiInterface")     
        print(interfaceName)
    }

    func ssidDidChangeForWiFiInterface(withName interfaceName: String) {
        print("ssidDidChangeForWiFiInterface")
        print(interfaceName)
    }

    func modeDidChangeForWiFiInterface(withName interfaceName: String) {
        print("modeDidChange")
        print(interfaceName)
    }

    func clientConnectionInterrupted() {
        print("INTERRUPTED")
    }

    func clientConnectionInvalidated() {
        print("INVALIDATED")
    }

    func linkDidChangeForWiFiInterface(withName interfaceName: String) {
        print("LINK CHANGE")
        print(interfaceName)
    }

    func getWiFiStatus() {

    }
}
