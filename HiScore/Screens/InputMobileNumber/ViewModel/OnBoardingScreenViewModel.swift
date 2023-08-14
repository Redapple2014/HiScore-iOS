//
//  ViewModel.swift
//  NetworkConnection
//
//  Created by RATPC-043 on 10/08/23.
//

import Foundation
class OnboardingScreenViewModel {
    
    private let networkService: HiScoreNetworkRepository
    var slides = [Images]()

    init(networkService: HiScoreNetworkRepository) {
        self.networkService = networkService
    }
    func getOnBoadingScreens(completion: @escaping (Result<OnboardingScreenResponseModel, APIError>) -> Void) {
        
        guard let url = URL(string: APIEndpoint.onboardingSlide) else { return }
        networkService.getData(from: url,
                               model: OnboardingScreenResponseModel.self) { response in
            switch response {
            case .success(let data):
                print(data)
                DispatchQueue.main.async {
                    self.slides = data.en
                    completion(.success(data))
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func validate(value: String) -> Bool {
        

            let PHONE_REGEX = "^//[6-9]\\d{9}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
            let result = phoneTest.evaluate(with: value)
            return result
        }

}
