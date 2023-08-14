//
//  SpalshViewModel.swift
//  NetworkConnection
//
//  Created by RATPC-043 on 10/08/23.
//

import Foundation
class SpalshViewModel {
    
    private let networkService: HiScoreNetworkRepository
    
    init(networkService: HiScoreNetworkRepository) {
        self.networkService = networkService
    }
    func getSplashScreenImages(completion: @escaping (Result<SplashResponseModel, APIError>) -> Void) {
        networkService.fetchData(from: .fetchSplashImage(version: .v3),
                                 model: SplashResponseModel.self) { response in
            
            switch response {
            case .success(let data):
                print(data)
                DispatchQueue.main.async {
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
}
