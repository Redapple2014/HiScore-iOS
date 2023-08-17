//
//  DataModel.swift
//  NetworkConnection
//
//  Created by RATPC-043 on 11/08/23.
//

import Foundation

struct OnboardingScreenResponseModel: Codable {
    let en: [Images]
}

// MARK: - En
struct Images: Codable {
    let title, subTitle : String
  private  let imageURL: String

    enum CodingKeys: String, CodingKey {
        case title
        case subTitle
        case imageURL = "imageUrl"
    }
}
extension Images: EventUrlPresentable {
    var splashScreenUrl: URL {
        return URL(string: imageURL)!
    }
    
    
}
