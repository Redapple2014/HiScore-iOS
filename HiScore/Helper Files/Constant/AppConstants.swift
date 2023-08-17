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
}
enum Messages {
    case invalidOtp
    case invalidPhoneNumber
    case otpRecieved
    var description: String {
        switch self {
        case .invalidOtp:
            return "Invalid OTP. Please try again"
        case .invalidPhoneNumber:
            return "Invalid Phone Number"
        case .otpRecieved:
            return "OTP resent successfully"
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
