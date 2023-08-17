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
   private let splash_screen_url: String
}

protocol EventUrlPresentable {
    var splashScreenUrl: URL { get }
}

extension EventUrl: EventUrlPresentable {
    var splashScreenUrl: URL {
        let imageString = splash_screen_url
        return URL(string: imageString)!
    }
}
