//
//  APIHeader.swift
//  HiScore
//
//  Created by PC-072 on 21/08/23.
//

import Foundation

class HttpHeader {
    var commonHeader: [String:Any] = ["app_flavor": DeviceDetails.deviceOS,
                                      "app_version":"1751",
                                      "platform_name": DeviceDetails.deviceOS,
                                      "Content-Type": "application/json",
                                      "authorization":User.shared.details?.data?.loginToken ?? ""]
    
}
