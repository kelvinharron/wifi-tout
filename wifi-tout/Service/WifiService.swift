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

    private let wifiClient = CWWiFiClient.shared()

    init() {
        self.wifiClient.delegate = self

        registerForWifiEvents()
    }

    private func registerForWifiEvents() {
        DispatchQueue.global(qos: .background).async {
            do {
                try self.startMonitoringEvents()
            } catch {
                print("Failed to register for wifi events: \(error)")
            }
        }
    }

    private func startMonitoringEvents() throws {
        try self.wifiClient.startMonitoringEvent(with: .linkDidChange)
        try self.wifiClient.startMonitoringEvent(with: .linkQualityDidChange)
        try self.wifiClient.startMonitoringEvent(with: .powerDidChange)
        try self.wifiClient.startMonitoringEvent(with: .countryCodeDidChange)
        try self.wifiClient.startMonitoringEvent(with: .bssidDidChange)
        try self.wifiClient.startMonitoringEvent(with: .ssidDidChange)
        try self.wifiClient.startMonitoringEvent(with: .modeDidChange)
        try self.wifiClient.startMonitoringEvent(with: .virtualInterfaceStateChanged)

    }

    func linkDidChangeForWiFiInterface(withName interfaceName: String) {
        print("LINK CHANGE")
    }

    func linkQualityDidChangeForWiFiInterface(withName interfaceName: String, rssi: Int, transmitRate: Double) {
        print("linkQualityDidChangeForWiFiInterface")
    }

    func powerStateDidChangeForWiFiInterface(withName interfaceName: String) {
        print("powerStateDidChangeForWiFiInterface")
    }

    func countryCodeDidChangeForWiFiInterface(withName interfaceName: String) {
        print("countryCodeDidChangeForWiFiInterface")
    }

    func bssidDidChangeForWiFiInterface(withName interfaceName: String) {
        print("bssidDidChangeForWiFiInterface")
    }

    func ssidDidChangeForWiFiInterface(withName interfaceName: String) {
        print("ssidDidChangeForWiFiInterface")
    }

    func modeDidChangeForWiFiInterface(withName interfaceName: String) {
        print("modeDidChange")
    }

    func clientConnectionInterrupted() {
        print("clientConnectionInterrupted")
    }

    func clientConnectionInvalidated() {
        print("clientConnectionInvalidated")
    }


    func getWiFiStatus() {

    }

}
