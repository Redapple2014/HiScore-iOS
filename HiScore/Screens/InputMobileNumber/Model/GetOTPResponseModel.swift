//
//  GetOTP.swift
//  HiScore
//
//  Created by PC-072 on 16/08/23.
//

import Foundation

struct GetOTPResponseModel: Codable {
    let status: String
    let status_code: Int
    let message: String
}

struct GetOtpRequestModel: Encodable {
    let mobile: String
    let uid: String
    let dest: String
}
