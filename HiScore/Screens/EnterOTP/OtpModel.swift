//
//  OtpModel.swift
//  HiScore
//
//  Created by PC-072 on 16/08/23.
//

import Foundation

import Foundation

// MARK: - Welcome
struct  VerifyOtpAndLoginRequestModel: Codable {
    let accountDetails: AccountDetails
    let appType, appsflyerAdset, appsflyerCampaignName, appsflyerChannel: String
    let appsflyerMediaSource, campaignName: String
    let device: Device
    let method: String
    let walletInit: Int

    enum CodingKeys: String, CodingKey {
        case accountDetails = "account_details"
        case appType = "app_type"
        case appsflyerAdset = "appsflyer_adset"
        case appsflyerCampaignName = "appsflyer_campaign_name"
        case appsflyerChannel = "appsflyer_channel"
        case appsflyerMediaSource = "appsflyer_media_source"
        case campaignName = "campaign_name"
        case device, method
        case walletInit = "wallet_init"
    }
}

// MARK: - AccountDetails
struct AccountDetails: Codable {
    let otp, userMobile, referralCode, uid: String

    enum CodingKeys: String, CodingKey {
        case otp
        case userMobile = "user_mobile"
        case referralCode = "referral_code"
        case uid
    }
}

// MARK: - Device
struct Device: Codable {
    let abis: [String]
    let gaid, androidID: String
    let appVersion: Int
    let cpuABI, deviceType, manufecturer, model: String
    let osAPILevel, ram, screenDPI, screenHeight: Int
    let screenWidth: Int

    enum CodingKeys: String, CodingKey {
        case abis, gaid
        case androidID = "androidId"
        case appVersion = "app_version"
        case cpuABI = "cpu_abi"
        case deviceType = "device_type"
        case manufecturer, model
        case osAPILevel = "os_api_level"
        case ram = "RAM"
        case screenDPI = "screen_dpi"
        case screenHeight = "screen_height"
        case screenWidth = "screen_width"
    }
}

 
// MARK: - Welcome
struct VerifyOtpAndLoginResponseModel: Codable {
    let status, message: String
    let statusCode: Int
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case status, message
        case statusCode = "status_code"
        case data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let isNewUser: Bool
    let userName: String
    let userID: Int
    let userPhoto: String
    let profileCreated, showUserBenefits: Bool
    let loginToken: String
    let dupe: Bool
    let userStatus: String

    enum CodingKeys: String, CodingKey {
        case isNewUser
        case userName = "user_name"
        case userID = "user_id"
        case userPhoto = "user_photo"
        case profileCreated = "profile_created"
        case showUserBenefits = "show_user_benefits"
        case loginToken = "login_token"
        case dupe
        case userStatus = "user_status"
    }
}

 
