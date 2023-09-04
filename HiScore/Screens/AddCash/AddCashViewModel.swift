//
//  addCashViewModel.swift
//  HiScore
//
//  Created by PC-072 on 28/08/23.
//

import Foundation

protocol AddCashDelegate {
    func updateOffers(offerList: [OfferListData])
}
class AddCashViewModel {
    private let networkService: HiScoreNetworkServiceprotocol
    
    init(networkService: HiScoreNetworkServiceprotocol) {
        self.networkService = networkService
    }
    var delegate: AddCashDelegate?
    var totalOfferCount = 4
    var amount = 0
    var offerData: [OfferData]!
    let min0 = 10
    let max0 = 99
    let min1 = 100
    let max1 = 249
    let min2 = 250
    let max2 = 999
    let min3 = 1000
    let max3 = 100000

    func getAddMoneyScreenData(completion: @escaping (Result<AddCashResponseModel, APIError>) -> Void) {
        networkService.fetchData(from: .getAddMoneyScreenData(version: .v1),
                                 model: AddCashResponseModel.self) { response in
            switch response {
            case .success(let data):
                self.offerData = data.data?.offerTypes?.promotionalOffers?.offers
                DispatchQueue.main.async {
                    self.amount =  0
                    self.showOffers()
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
    func showOffers() {
        if self.amount == 0 {
            delegate?.updateOffers(offerList: showOffersForEmpty())
        } else  {
            checkAmountType()
        }
    }
    private func checkAmountType() {
        for i in 0..<(offerData.count) {
            if ((offerData[i].minLimit ?? 0)...(offerData[i].maxLimit ?? 0)).contains(amount) {
                findRange(min: (offerData[i].minLimit ?? 0), max: (offerData[i].maxLimit ?? 0))
            }
        }
    }
    private func findRange(min: Int, max: Int) {
        let mid = (min+max)/2
        let distanceFromMin = amount-min
        let distanceFromMax = max-amount
        let distanceFromMid = abs(mid-amount)
        
        if amount == min {
            
        } //else if amount
    }
    private func showOffersForEmpty() -> [OfferListData] {
        var array = [OfferListData]()
        for offer in self.offerData {
            let item = OfferListData(amount: offer.minLimit ?? 0,
                                     percentage: offer.percentage ?? 0,
                                     bonusAmount: percentageValue(percent: offer.percentage ?? 0,
                                                                  number: offer.minLimit ?? 0))
            array.append(item)
        }
        return array
    }
    
    private func percentageValue(percent: Int, number: Int) -> Int {
        return ((percent*number)/100)
    }
    private  func createArray()  {
        
    }
}

enum OfferAMountType {
    case min
    case minToLessMid
    case fromMidToMax
    case max
}
