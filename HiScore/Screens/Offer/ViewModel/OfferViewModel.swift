//
//  OfferViewModel.swift
//  HiScore
//
//  Created by RATPC-043 on 22/08/23.
//

import Foundation

class OfferViewModel {
    private let networkService: HiScoreNetworkRepository
    
    init(networkService: HiScoreNetworkRepository) {
        self.networkService = networkService
    }
    func getOfferDetails(completion: @escaping (Result<OfferResponseModel, APIError>) -> Void) {
        networkService.fetchData(from: .offer(version: .version5),
                                 model: OfferResponseModel.self) { result in
            switch result {
            case .success(let response):
                Log.d(response)
                completion(.success(response))
            case .failure(let error):
                Log.d(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
