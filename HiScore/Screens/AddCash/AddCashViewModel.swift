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
    
    func getAddMoneyScreenData(completion: @escaping (Result<AddCashResponseModel, APIError>) -> Void) {
//        networkService.fetchData(from: .getUserWallet(version: .v1),
        networkService.fetchData(from: .getAddMoneyScreenData(version: .v1),
                                 model: AddCashResponseModel.self) { response in
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
    
    func showDefaultOffers(amount: Int, data: OfferData) {//-> [OfferData] {
        let min = data.minLimit
        let max = data.maxLimit
        if amount == 0 {
           // OfferListData(amount: <#T##Int#>, percentage: <#T##Int#>, bonusAmount: <#T##Int#>)
        }
    }
    
    
    
  private  func createArray()  { //}-> [OfferData] {
        
    }
}

class OfferListData {
    var amount: Int
    var percentage: Int
    var bonusAmount: Int
    
    init(amount: Int,percentage: Int,bonusAmount: Int) {
        self.amount = amount
        self.percentage = percentage
        self.bonusAmount = bonusAmount
    }
}
