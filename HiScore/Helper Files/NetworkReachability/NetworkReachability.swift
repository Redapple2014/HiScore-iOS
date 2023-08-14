//
//  NetworkReachability.swift
//  JustGame
//
//  Created by PC-010 on 21/11/22.
//

import Foundation
import Network
import UIKit

final class NetworkReachability {
    static let shared = NetworkReachability()
    private var monitor: NWPathMonitor?
    private var isMonitoring = false
    var didStartMonitoringHandler: (() -> Void)?
    var didStopMonitoringHandler: (() -> Void)?
    var networkStatusChangeHandler: ((NWPath.Status) -> Void)?
    var isConnected: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }
    private var availableInterfacesTypes: [NWInterface.InterfaceType]? {
        guard let monitor = monitor else { return nil }
        return monitor.currentPath.availableInterfaces.map { $0.type }
    }
    var interfaceType: NWInterface.InterfaceType? {
        return self.availableInterfacesTypes?.first
    }
    // MARK: - Initializer
    private init () {}
    deinit {
        stopMonitoring()
    }
}
// MARK: - Public methods
extension NetworkReachability {
    public final func startMonitoring(_ status: ((NWPath.Status) -> Void)?) {
        networkStatusChangeHandler = status
        if isMonitoring { return }
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Monitor")
        monitor?.start(queue: queue)
        monitor?.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.networkStatusChangeHandler?(path.status)
            }
        }
        isMonitoring = true
        didStartMonitoringHandler?()
    }
    public final func stopMonitoring() {
        if isMonitoring, let monitor = monitor {
            monitor.cancel()
            self.monitor = nil
            isMonitoring = false
            didStopMonitoringHandler?()
        }
    }
}
