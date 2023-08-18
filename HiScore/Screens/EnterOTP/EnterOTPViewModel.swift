//
//  EnterOTPViewModel.swift
//  HiScore
//
//  Created by PC-072 on 16/08/23.
//

import Foundation

class EnterOTPViewModel {
    private let networkService: HiScoreNetworkServiceprotocol

    
    init(networkService: HiScoreNetworkServiceprotocol) {
        self.networkService = networkService
    }
    var accountDetais: AccountDetails!
    var device: Device!
    func verifyOTP(completion: @escaping (Result<VerifyOtpAndLoginResponseModel, APIError>) -> Void) {
      
        let param = VerifyOtpAndLoginRequestModel(accountDetails: accountDetais,
                                                  appType: "ios",
                                                  appsflyerAdset: "",
                                                  appsflyerCampaignName: "",
                                                  appsflyerChannel: "",
                                                  appsflyerMediaSource: "",
                                                  campaignName: "organic",
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
