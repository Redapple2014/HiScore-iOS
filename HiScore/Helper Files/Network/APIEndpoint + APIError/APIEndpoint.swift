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
    
    var path: String {
        switch self {
        case .fetchSplashImage(let version):
            return "\(version)/game/splash"
        case .sendOTP(let version):
            return "\(version)/game/users/sendOTP"
        case .login(let version):
            return "\(version)/game/users/login"
        }
    }
    var headers: [String: String]? {
        switch self {
        case .fetchSplashImage, .sendOTP, .login:
            return ["app_version":"1751","platform_name": "ios","Content-Type": "application/json"]
//        case .postItem:
//            return ["Authorization": "Bearer YOUR_ACCESS_TOKEN",
//                    "Content-Type": "application/json"]
            
        }
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
enum Version: Int {
    case v1
    case v2
    case v3
    case v4
    case v5
}
