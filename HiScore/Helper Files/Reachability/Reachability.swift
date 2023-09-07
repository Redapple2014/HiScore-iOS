//
//  Reachability.swift
//  HiScore
//
//  Created by PC-036 on 24/02/22.
//

import Foundation
import UIKit
import SystemConfiguration.CaptiveNetwork

public let reachabilityStatusChangedNotification = "ReachabilityStatusChangedNotification"

public enum ReachabilityType: CustomStringConvertible {
    case wWAN
    case wiFi

    public var description: String {
        switch self {
        case .wWAN: return "WWAN"
        case .wiFi: return "WiFi"
        }
    }
}

public enum ReachabilityStatus: CustomStringConvertible {
    case offline
    case online(ReachabilityType)
    case unknown

    public var description: String {
        switch self {
        case .offline: return "Offline"
        case .online(let type): return "Online (\(type))"
        case .unknown: return "Unknown"
        }
    }
}

public class Reachability {

    func connectionStatus() -> ReachabilityStatus {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = (withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }) else {
           return .unknown
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .unknown
        }

        return ReachabilityStatus(reachabilityFlags: flags)
    }

    func monitorReachabilityChanges() {
        let host = "google.com"
        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        let reachability = SCNetworkReachabilityCreateWithName(nil, host)!

        SCNetworkReachabilitySetCallback(reachability, { (_, flags, _) in
            let status = ReachabilityStatus(reachabilityFlags: flags)

            NotificationCenter.default.post(name: NSNotification.Name(rawValue: reachabilityStatusChangedNotification),
                                            object: nil,
                                            userInfo: ["Status": status.description])}, &context)

        SCNetworkReachabilityScheduleWithRunLoop(reachability, CFRunLoopGetMain(), CFRunLoopMode.commonModes.rawValue)
    }
}

extension ReachabilityStatus {

    public init(reachabilityFlags flags: SCNetworkReachabilityFlags) {
        let connectionRequired = flags.contains(.connectionRequired)
        let isReachable = flags.contains(.reachable)
        let isWWAN = flags.contains(.isWWAN)

        if !connectionRequired && isReachable {
            if isWWAN {
                self = .online(.wWAN)
            } else {
                self = .online(.wiFi)
            }
        } else {
            self =  .offline
        }
    }
}
