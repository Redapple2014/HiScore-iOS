//
//  WalletViewModel.swift
//  HiScore
//
//  Created by RATPC-043 on 04/09/23.
//

import Foundation

class WalletViewModel {
    private let networkService: HiScoreNetworkRepository
    var walletData: Wallet?
    init(networkService: HiScoreNetworkRepository) {
        self.networkService = networkService
    }
    
    func getWalletDetails(completion: @escaping (Result<Wallet, APIError>) -> Void) {
        networkService.postData(to: .wallet(version: .v1),
                                responseModelType: Wallet.self) { result in
            switch result {
            case .success(let response):
                Log.d(response)
                self.walletData = response
                completion(.success(response))
            case .failure(let error):
                Log.d(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    func getKycStatus(completion: @escaping (Result<UserDataModel, APIError>) -> Void){
        networkService.fetchData(from: .kycStatus(version: .v1),
                                model: UserDataModel.self) { result in
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


