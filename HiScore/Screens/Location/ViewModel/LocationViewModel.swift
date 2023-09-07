//
//  LocationViewModel.swift
//  HiScore
//
//  Created by RATPC-043 on 17/08/23.
//

import Foundation

class LocationViewModel {

    private let networkService: HiScoreNetworkRepository

    init(networkService: HiScoreNetworkRepository) {
        self.networkService = networkService
    }
    func getLocationData(lat: String, long: String, completion: @escaping (Result<LocationResponseModel, APIError>) -> Void) {
        let param = LocationRequestModel(lat: lat, long: long)
        networkService.postData(to: .validateAccess(version: .version2),
                                with: param,
                                responseModelType: LocationResponseModel.self) { result in
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
