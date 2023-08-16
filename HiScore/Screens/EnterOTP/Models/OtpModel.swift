//
//  OtpModel.swift
//  HiScore
//
//  Created by PC-072 on 16/08/23.
//

import Foundation

struct VerifyOtpAndLoginResponseModel: Codable {
      let status: String
      let status_code: Int
      let message: String
}

struct VerifyOtpAndLoginRequestModel: Encodable {
    let mobile: String
    let uid: String
    let dest: String
}
