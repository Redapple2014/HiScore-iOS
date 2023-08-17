//
//  GetOTP.swift
//  HiScore
//
//  Created by PC-072 on 16/08/23.
//

import Foundation


struct GetOtpRequestModel: Encodable {
    let mobile: String
    let uid: String
    let dest: String
}


//struct GetOTPResponseModel: Codable {
//    let status: String
//    let status_code: Int
//    let message: String
//}

// MARK: - Welcome
struct GetOTPResponseModel: Codable {
    let status, message: String
    let statusCode: Int
    let data: DataClassGetOtp?

    enum CodingKeys: String, CodingKey {
        case status, message
        case statusCode = "status_code"
        case data
    }
}

// MARK: - DataClass
struct DataClassGetOtp: Codable {
    let userStatus, errorMsg: String?
    let multiLang: MultiLang?
    let remainingTime: Int?
    let resendAllowed: Bool?

    enum CodingKeys: String, CodingKey {
        case userStatus = "user_status"
        case errorMsg = "error_msg"
        case multiLang = "multi_lang"
        case remainingTime = "remaining_time"
        case resendAllowed
    }
}

// MARK: - MultiLang
struct MultiLang: Codable {
    let hi: Hi
}

// MARK: - Hi
struct Hi: Codable {
    let errorMsg: String

    enum CodingKeys: String, CodingKey {
        case errorMsg = "error_msg"
    }
}
