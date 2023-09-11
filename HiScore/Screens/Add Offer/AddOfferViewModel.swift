//
//  AddOfferViewModel.swift
//  HiScore
//
//  Created by PC-072 on 11/09/23.
//

import Foundation



class AddOfferViewModel {
    
    private let networkService: HiScoreNetworkServiceprotocol

    init(networkService: HiScoreNetworkServiceprotocol) {
        self.networkService = networkService
    }
    
    func getAddMoneyScreenData(value: String, completion: @escaping (Result<AddCashResponseModel, APIError>) -> Void) {
        networkService.getData(from: .getAddMoneyScreenData(version: .v1),
                               model: AddCashResponseModel.self,
                               queryParam: [URLQueryItem(name: "voucher_code", value: value)]) { response in
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
