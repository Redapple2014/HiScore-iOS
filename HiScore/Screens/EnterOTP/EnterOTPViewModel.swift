//
//  EnterOTPViewModel.swift
//  HiScore
//
//  Created by PC-072 on 16/08/23.
//

import Foundation
import UIKit

class EnterOTPViewModel {
    private let networkService: HiScoreNetworkServiceprotocol
    
    init(networkService: HiScoreNetworkServiceprotocol) {
        self.networkService = networkService
    }
    var accountDetais: AccountDetails!
    var device: DeviceData!
    var uid = ""
    func verifyOTP(otpEntered: String,
                   phoneNumber: String,
                   uid:String,
                   completion: @escaping (Result<VerifyOtpAndLoginResponseModel, APIError>) -> Void) {
        
        accountDetais = AccountDetails(otp: otpEntered,
                                       userMobile: phoneNumber,
                                       referralCode: "",
                                       uid: uid)
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        var version = 1.0
        if let dble = Double(appVersion ?? "1.0") {
            version = dble
        }
        device = DeviceData(abis: UIDevice.current.getCPUName(),
                            gaid: "",
                            androidID: DeviceDetails.uniqueIdentifier,
                            appVersion: Int(version),
                            cpuABI: "",
                            deviceType: DeviceDetails.deviceType,
                            manufecturer: DeviceDetails.manufacturer,
                            model: UIDevice.current.name,
                            osAPILevel: 0,
                            ram: 0,
                            screenDPI: 0,
                            screenHeight: Int(ScreenDetails.height),
                            screenWidth: Int(ScreenDetails.width))
        
        let param = VerifyOtpAndLoginRequestModel(accountDetails: accountDetais,
                                                  appType: DeviceDetails.deviceOS,
                                                  appsflyerAdset: "",
                                                  appsflyerCampaignName: "",
                                                  appsflyerChannel: "",
                                                  appsflyerMediaSource: "",
                                                  campaignName: AdvertiseDetails.campaignName,
                                                  device: device,
                                                  method: "1p",
                                                  walletInit: -1)
        networkService.postData(to: .login(version: .v5),
                                with: param,
                                responseModelType: VerifyOtpAndLoginResponseModel.self) { result in
            switch result {
            case .success(let response):
                Log.d(response)
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            case .failure(let error):
                Log.d(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
