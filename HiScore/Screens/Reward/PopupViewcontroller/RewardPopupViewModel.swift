//
//  RewardPopupViewModel.swift
//  HiScore
//
//  Created by PC-072 on 21/08/23.
//

import Foundation

class RewardPopupViewModel {
    private let networkService: HiScoreNetworkServiceprotocol
    
    init(networkService: HiScoreNetworkServiceprotocol) {
        self.networkService = networkService
    }
    
    func getRewardData(completion: @escaping (Result<RewardPopupResponseModel, APIError>) -> Void) {
        networkService.fetchData(from: .reward(version: .version5),
                                 model: RewardPopupResponseModel.self) { response in
            switch response {
            case .success(let data):
                DispatchQueue.main.async {
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
}
