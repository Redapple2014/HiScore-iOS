//
//  ViewModel.swift
//  NetworkConnection
//
//  Created by RATPC-043 on 10/08/23.
//

import Foundation
class OnboardingScreenViewModel {
    
    private let networkService: HiScoreNetworkRepository
    
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
                completion(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
                
            }
        }
    }
}
