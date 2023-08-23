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
    let device: DeviceData
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
struct DeviceData: Codable {
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
class VerifyOtpAndLoginResponseModel: NSObject, NSCoding,  Codable {
    let status, message: String?
    let statusCode: Int?
    let data: DataClass?

    enum CodingKeys: String, CodingKey {
        case status, message
        case statusCode = "status_code"
        case data
    }
    func encode(with coder: NSCoder) {
        coder.encode(self.data, forKey: "data")
        coder.encode(self.status, forKey: "status")
        coder.encode(self.message, forKey: "message")
        coder.encode(self.statusCode, forKey: "status_code")
    }
    
    required init?(coder: NSCoder) {
        self.data = coder.decodeObject(forKey: "data") as? DataClass
        self.status = coder.decodeObject(forKey: "status") as? String
        self.message = coder.decodeObject(forKey: "message") as? String
        self.statusCode = coder.decodeObject(forKey: "status_code") as? Int
    }
}

// MARK: - DataClass
class DataClass: NSObject, NSCoding, Codable {
    let isNewUser: Bool?
    let userName: String?
    let userID: Int?
    let userPhoto: String?
    let profileCreated, showUserBenefits: Bool?
    let loginToken: String?
    let dupe: Bool?
    private let userStatus: String?
    let errorMsg: String?
    
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
        case errorMsg = "error_msg"
    }
    func encode(with coder: NSCoder) {
        coder.encode(self.isNewUser, forKey: "isNewUser")
        coder.encode(self.userName, forKey: "user_name")
        coder.encode(self.userID, forKey: "user_id")
        coder.encode(self.userPhoto, forKey: "user_photo")
        coder.encode(self.profileCreated, forKey: "profile_created")
        coder.encode(self.showUserBenefits, forKey: "show_user_benefits")
        coder.encode(self.loginToken, forKey: "login_token")
        coder.encode(self.dupe, forKey: "dupe")
        coder.encode(self.userStatus, forKey: "user_status")
        coder.encode(self.errorMsg, forKey: "error_msg")
    }
    
    required init?(coder: NSCoder) {
        self.isNewUser = coder.decodeObject(forKey: "isNewUser") as? Bool
        self.userName = coder.decodeObject(forKey: "user_name") as? String
        self.userID = coder.decodeObject(forKey: "user_id") as? Int
        self.userPhoto = coder.decodeObject(forKey: "user_photo") as? String
        self.profileCreated = coder.decodeObject(forKey: "profile_created") as? Bool
        self.showUserBenefits = coder.decodeObject(forKey: "show_user_benefits") as? Bool
        self.loginToken = coder.decodeObject(forKey: "login_token") as? String
        self.dupe = coder.decodeObject(forKey: "dupe") as? Bool
        self.userStatus = coder.decodeObject(forKey: "user_status") as? String
        self.errorMsg = coder.decodeObject(forKey: "error_msg") as? String
    }
}
 
enum  UserLoginStatus {
    case existingUser
    case invalidOTP
    case profileCreated
    var description: String {
        switch self {
        case .existingUser : return "EXISTING_USER"
        case .invalidOTP : return "INVALID_OTP"
        case .profileCreated: return "PROFILE_CREATED"
        }
    }
}

extension DataClass: UserLoginStatusDelegate {
    var status: UserLoginStatus? {
        if userStatus == UserLoginStatus.existingUser.description {
            return .existingUser
        } else  if userStatus == UserLoginStatus.profileCreated.description {
            return .profileCreated
        } else  if userStatus == UserLoginStatus.invalidOTP.description {
            return .invalidOTP
        } else {
            return nil
        }
    }
}

protocol UserLoginStatusDelegate {
    var status: UserLoginStatus? { get }
}

