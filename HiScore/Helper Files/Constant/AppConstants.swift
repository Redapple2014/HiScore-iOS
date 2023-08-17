//
//  AppConstants.swift
//  HiScore
//
//  Created by Sandeep Nag on 16/08/23.
//

import Foundation

enum Storyboards: String {
    case main = "Main"
    case location = "Location"
    case wallet = "Wallet"
    case home = "Home"
}
enum Messages {
    case invalidOtp
    case invalidPhoneNumber
    case locationmessage
    case locationTitle
    case cancel
    case settings
    var description: String {
        switch self {
        case .invalidOtp:
            return "Invalid OTP. Please try again"
        case .invalidPhoneNumber:
            return "Invalid Phone Number"
        case .locationmessage:
            return "Allow \"HiScore\" to Determine Your Location"
        case .locationTitle:
            return "Turn On Location Services to"
        case .cancel:
            return "Cancel"
        case .settings:
            return "Settings"
        }
    }
}
enum PlaceholderMessages {
    case phoneNumber
    var desscription: String {
        switch self {
        case .phoneNumber:
            return "Enter Phone number"
        }
    }
}
class Device {
    static let deviceOS = "ios"
    static let uniqueIdentifier = UUID().uuidString
}
