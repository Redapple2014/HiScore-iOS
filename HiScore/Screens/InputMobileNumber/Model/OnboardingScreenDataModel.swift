//
//  DataModel.swift
//  NetworkConnection
//
//  Created by RATPC-043 on 11/08/23.
//

import Foundation

struct OnboardingScreenResponseModel: Codable {
    let hi, en: [En]
}

// MARK: - En
struct En: Codable {
    let title: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "imageUrl"
    }
}
