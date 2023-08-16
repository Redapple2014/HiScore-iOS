//
//  ViewModel.swift
//  NetworkConnection
//
//  Created by RATPC-043 on 10/08/23.
//

import Foundation
class OnboardingScreenViewModel {
    
    private let networkService: HiScoreNetworkServiceprotocol
    var slides = [Images]()
    
    init(networkService: HiScoreNetworkServiceprotocol) {
        self.networkService = networkService
    }
    func getOnBoadingScreens(completion: @escaping (Result<OnboardingScreenResponseModel, APIError>) -> Void) {
        
        guard let url = URL(string: APIEndpoint.onboardingSlide) else { return }
        networkService.getData(from: url,
                               model: OnboardingScreenResponseModel.self) { response in
            switch response {
            case .success(let data):
                Log.d(data)
                DispatchQueue.main.async {
                    self.slides = data.en
                    completion(.success(data))
                }
            case .failure(let error):
                Log.d(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getOTP(phoneNumber: String, completion: @escaping (Result<GetOTPResponseModel, APIError>) -> Void) {
        let tempId = "\(UUID().uuidString)p"
        let param = GetOtpRequestModel(mobile: phoneNumber,
                                       uid: UUID().uuidString,
                                       dest: "phone")
        networkService.postData(to: .sendOTP(version: .v5),
                                with: param,
                                responseModelType: GetOTPResponseModel.self) { result in
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
    
    func validate(value: String) -> Bool {
        if (value.count) == 0 {
            return false
        } else if ((value.count) > 0 ) && ((value.count) < 10 ){
            return false
        } else if ((value.count) == 10 ) {
            return true
        }
        return false
//        let PHONE_REGEX = "^//[6-9]\\d{9}$"
//        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
//        let result = phoneTest.evaluate(with: value)
//        return result
    }
    
}
