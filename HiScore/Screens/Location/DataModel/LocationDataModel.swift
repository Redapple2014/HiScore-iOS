//
//  LocationDataModel.swift
//  HiScore
//
//  Created by RATPC-043 on 17/08/23.
//

import Foundation

struct LocationRequestModel: Encodable {
    let lat: String
    let long: String
}

struct LocationResponseModel: Decodable {
    let status: String
    let message: String
    let data: LocationAccess
}

struct LocationAccess: Decodable {
    let rummy: LocationAllowance
    //    let login: LocationAllowance
    //    let poker: LocationAllowance
    //    let fantasy: LocationAllowance
    //    let games: LocationAllowance
    //    let quiz: LocationAllowance
    //    let callbreak: LocationAllowance
    //    let ludo: LocationAllowance
}
struct LocationAllowance: Decodable {
    let isAllowed: Bool
    let error: LocationError?

    enum CodingKeys: String, CodingKey {
        case isAllowed = "is_allowed"
        case error
    }
}
struct LocationError: Codable {
    let headerTitle: String?
    let descTitle: String?
    let descText: String?

    enum CodingKeys: String, CodingKey {
        case headerTitle = "header_title"
        case descTitle = "desc_title"
        case descText =  "desc_text"
    }
}
