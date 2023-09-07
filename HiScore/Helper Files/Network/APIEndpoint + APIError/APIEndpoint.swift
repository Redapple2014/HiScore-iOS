//
//  APIEndpoint.swift
//  NetworkConnection
//
//  Created by RATPC-043 on 10/08/23.
//

import Foundation

enum APIEndpoint {
    case fetchSplashImage(version: Version)
    case sendOTP(version: Version)
    case login(version: Version)
    case validateAccess(version: Version)
    case reward(version: Version)
    case offer(version: Version)
    case wallet(version: Version)
    case kycStatus(version: Version)
    case getAddMoneyScreenData(version: Version)
    case getUserWallet(version: Version)
    var path: String {
        switch self {
        case .fetchSplashImage(let version):
            return "\(version.rawValue)/game/splash"
        case .sendOTP(let version):
            return "\(version.rawValue)/game/users/sendOTP"
        case .login(let version):
            return "\(version.rawValue)/game/users/login"
        case .validateAccess(let version):
            return "\(version.rawValue)/user/app/capability"
        case .reward(let version):
            return "\(version.rawValue)/game/users/rewardsInfoV2"
        case .offer(let version):
            return "\(version.rawValue)/utils/onboardingDepositOffers"
        case .wallet(let version):
            return "\(version.rawValue)/wallet/getUserWallet"
        case .kycStatus(let version):
            return "\(version.rawValue)/game/users"
        case .getAddMoneyScreenData(let version):
            return "\(version.rawValue)/utils/getAddMoneyScreenData"
        case .getUserWallet(let version):
            return "\(version.rawValue)/wallet/getUserWallet"
        }
    }
    var baseHeader: [String: String] {
        return ["app_flavor": DeviceDetails.deviceOS,
                "app_version": "1751",
                "platform_name": DeviceDetails.deviceOS,
                "Content-Type": "application/json"]
    }
    var headers: [String: String]? {
        var allHeaders = baseHeader
        switch self {
        case .fetchSplashImage, .sendOTP, .login, .validateAccess:
            break
        case .reward, .offer, .wallet, .kycStatus, .getAddMoneyScreenData, .getUserWallet:
            if let token = User.shared.details?.data?.loginToken {
                allHeaders["authorization"] = token
            }
        }
        return allHeaders
    }
    var url: URL? {
        return URL(string: APIEndpoint.baseURL + path)
    }
    var onboardingUrlurl: URL? {
        return URL(string: APIEndpoint.onboardingSlide)
    }

    static let baseURL = "https://nostrapi-ios.nostragamus-stage.in/"
    static let onboardingSlide = "https://cdn-static.nostragamus-stage.in/loginHomeSlides_iOS.json"
}
enum Version: String {
    case version1 = "v1"
    case version2 = "v2"
    case version3 = "v3"
    case version4 = "v4"
    case version5 = "v5"
}
