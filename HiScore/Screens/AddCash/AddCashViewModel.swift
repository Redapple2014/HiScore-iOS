//
//  addCashViewModel.swift
//  HiScore
//
//  Created by PC-072 on 28/08/23.
//

import Foundation

class AddCashViewModel {
    private let networkService: HiScoreNetworkServiceprotocol
    
    init(networkService: HiScoreNetworkServiceprotocol) {
        self.networkService = networkService
    }
    
    func getAddMoneyScreenData(completion: @escaping (Result<RewardPopupResponseModel, APIError>) -> Void) {
        networkService.fetchData(from: .getAddMoneyScreenData(version: .v1),
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
