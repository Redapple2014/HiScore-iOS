//
//  APIEndpoint.swift
//  NetworkConnection
//
//  Created by RATPC-043 on 10/08/23.
//

import Foundation

enum APIEndpoint {
    case fetchSplashImage(version: Version)
    case postItem(version: Version)
    case sendOTP(version: Version)
    
    
    var path: String {
        switch self {
        case .fetchSplashImage(let version):
            return "\(version)/game/splash"
        case .postItem(let version):
            return "\(version)/post-item"
        case .sendOTP(let version):
            return "\(version)/game/users/sendOTP"
        }
    }
    var headers: [String: String]? {
        switch self {
        case .fetchSplashImage, .sendOTP:
            return ["Content-Type": "application/json"]
        case .postItem:
            return ["Authorization": "Bearer YOUR_ACCESS_TOKEN",
                    "Content-Type": "application/json"]
            
        }
    }
    var url: URL? {
        return URL(string: APIEndpoint.baseURL + path)
    }
    var onboardingUrlurl: URL? {
        return URL(string: APIEndpoint.onboardingSlide)
    }
    
    static let baseURL = "https://nostrapi-ios.nostragamus-stage.in/"
    static let onboardingSlide = "https://cdn-static.nostragamus-stage.in/loginHomeSlides.json"
}
enum Version: Int {
    case v1 = 1
    case v2 = 2
    case v3 = 3
}
