//
//  SplashDataModel.swift
//  NetworkConnection
//
//  Created by RATPC-043 on 11/08/23.
//

import Foundation

struct SplashResponseModel: Codable {
    let status: String
    let message: String
    let data: Event
}

struct Event: Codable {
    let event: EventUrl
}
struct EventUrl: Codable {
   private let splashScreen: String

    enum CodingKeys: String, CodingKey {
        case splashScreen = "splash_screen_url"
    }
}

protocol EventUrlPresentable {
    var splashScreenUrl: URL { get }
}

extension EventUrl: EventUrlPresentable {
    var splashScreenUrl: URL {
        let imageString = splashScreen
        return URL(string: imageString)!
    }
}
