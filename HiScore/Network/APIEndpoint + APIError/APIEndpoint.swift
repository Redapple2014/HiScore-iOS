//
//  APIEndpoint.swift
//  NetworkConnection
//
//  Created by RATPC-043 on 10/08/23.
//

import Foundation

enum APIEndpoint {
    case fetchSplashImage(version: Int)
    case postItem(version: Int)
    
    var path: String {
        switch self {
        case .fetchSplashImage(let version):
            return "v\(version)/game/splash"
        case .postItem(let version):
            return "v\(version)/post-item"
        }
    }
    var headers: [String: String]? {
        switch self {
        case .fetchSplashImage:
            return ["": ""]
        case .postItem:
            return ["Authorization": "Bearer YOUR_ACCESS_TOKEN",
                    "Content-Type": "application/json"]
        }
    }
    var url: URL? {
        return URL(string: APIEndpoint.baseURL + path)
    }
    
    static let baseURL = "https://nostrapi-ios.nostragamus-stage.in/"
}
