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
    
    func verifyOTP(otp: String, completion: @escaping (Result<VerifyOtpAndLoginResponseModel, APIError>) -> Void) {
      
        let param = VerifyOtpAndLoginRequestModel(mobile: otp,
                                                  uid: UUID().uuidString,
                                                  dest: "phone")
        networkService.postData(to: .sendOTP(version: .v5),
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
