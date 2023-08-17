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
    let login: LoginAllowance
    
}
struct LoginAllowance: Decodable {
    let isAllowed: Bool
    
    enum CodingKeys: String, CodingKey {
        case isAllowed = "is_allowed"
    }
}
