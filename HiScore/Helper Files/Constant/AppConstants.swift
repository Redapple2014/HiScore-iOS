//
//  AppConstants.swift
//  HiScore
//
//  Created by Sandeep Nag on 16/08/23.
//

import Foundation
import UIKit

enum Storyboards: String {
    case main = "Main"
    case location = "Location"
    case wallet = "Wallet"
    case home = "Home"
    case reward = "Reward"
    case offer = "Offer"
}
enum Messages {
    case tryAgain
    case invalidOtp
    case invalidPhoneNumber
    case locationmessage
    case locationTitle
    case cancel
    case settings
    case otpRecieved
    case invalidResponse
    var description: String {
        switch self {
        case .tryAgain:
            return ""
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
        case .otpRecieved:
            return "OTP resent successfully"
        case .invalidResponse:
            return "Something went wrong. Please try again later."
        }
    }
}
enum PlaceholderMessages {
    case phoneNumber
    var desscription: String {
        switch self {
        case .phoneNumber:
            return "Enter phone number"
        }
    }
}
class DeviceDetails {
    static let deviceOS = "ios"
    static let uniqueIdentifier = UUID().uuidString
    static let manufacturer = "apple"
    static var deviceType: String {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return "iPhone"
        default:
            return "other Decvice"
        }
    }
}
class ScreenDetails {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

class AdvertiseDetails {
    static let campaignName = "organic"
     
}

class AnimationFiles {
    static let reward = "REward Gift Box"
    static let rewardConfetti = "Confetti Animated Icon"
    static let loading = "animation_ll6mjcvw"
}

enum StateOfTextfield {
    case inactive
    case active
    case error
}
