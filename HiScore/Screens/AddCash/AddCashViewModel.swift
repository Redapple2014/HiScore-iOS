//
//  addCashViewModel.swift
//  HiScore
//
//  Created by PC-072 on 28/08/23.
//

import Foundation

protocol AddCashDelegate {
    func updateOffers(offerList: [OfferListData])
    func errorInPut()
}
class AddCashViewModel {
    private let networkService: HiScoreNetworkServiceprotocol
    
    init(networkService: HiScoreNetworkServiceprotocol) {
        self.networkService = networkService
    }
    var delegate: AddCashDelegate?
//    var totalOfferCount = 4
    var amount = 0
    private var offerData = [OfferData]()
    var userOfferType: UserOfferType?
    func getAddMoneyScreenData(completion: @escaping (Result<AddCashResponseModel, APIError>) -> Void) {
        networkService.fetchData(from: .getAddMoneyScreenData(version: .v1),
                                 model: AddCashResponseModel.self) { response in
            switch response {
            case .success(let data):
                if let promo = data.data?.offerTypes?.promotionalOffers {
                    if let offerDetails = promo.offers {
                        self.offerData = offerDetails
                        self.userOfferType = .promotional
                    }
                }
                if let rummy = data.data?.offerTypes?.rummy {
                    if let offerDetails = rummy.offers {
                        self.offerData = offerDetails
                        self.userOfferType = .rummy
                    }
                }
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
            if checkInputNumber() {
                checkAmountType()
            } else {
                delegate?.updateOffers(offerList: showOffersForEmpty())
            }
        }
    }
    private func checkInputNumber() -> Bool {
        _ = offerData.sorted(by: { $0.minLimit ?? 0 > $1.minLimit ?? 0 })
        if offerData.count > 0 && amount < offerData[0].minLimit ?? 0 {
            //self.delegate?.errorInPut()
            return false
        } else {
            return true
        }
    }
    private func checkAmountType() {
        for i in 0..<(offerData.count) {
            if ((offerData[i].minLimit ?? 0)...(offerData[i].maxLimit ?? 0)).contains(amount) {
                findRange(min: (offerData[i].minLimit ?? 0), max: (offerData[i].maxLimit ?? 0), index: i)
                break
            }
        }
    }
    private func findRange(min: Int, max: Int, index: Int) {
        let mid = (min+max)/2
        if amount == min {
            minimumValueOffer(index:index)
        }  else if amount > min && amount < mid {
            minimumToMidumValueOffer(index:index)
        } else if amount >= mid && amount < max {
            midiumToMaximumValueOffer(index: index)
        } else if amount == max {
            maximumValueOffer(index: index)
        }
    }
    private func minimumValueOffer(index: Int) {
        var array = [OfferListData]()
        var amountValue = self.amount

        let item0 = OfferListData(amount: amountValue,
                                 percentage: self.offerData[index].percentage ?? 0,
                                 bonusAmount: percentageValue(percent: self.offerData[index].percentage ?? 0,
                                                              number: self.amount,
                                                              capValue: self.offerData[index].capValue ?? 0),
                                  isSelected: true)
        array.append(item0)
            // 2nd item
        amountValue = ((self.offerData[index].minLimit ?? 0)+(self.offerData[index].maxLimit ?? 0))/2
        let item1 = OfferListData(amount: amountValue,
                                 percentage: self.offerData[index].percentage ?? 0,
                                  bonusAmount: percentageValue(percent: self.offerData[index].percentage ?? 0,
                                                               number: amountValue,
                                                               capValue: self.offerData[index].capValue ?? 0))
        array.append(item1)
            // 3rd item
        if (index+1) < self.offerData.count {
            amountValue = self.offerData[index+1].minLimit ?? 0
            let item2 = OfferListData(amount: amountValue,
                                     percentage: self.offerData[index+1].percentage ?? 0,
                                     bonusAmount: percentageValue(percent: self.offerData[index+1].percentage ?? 0,
                                                                  number: amountValue,
                                                                  capValue: self.offerData[index+1].capValue ?? 0))
            array.append(item2)
            // 4th item
            amountValue = ((self.offerData[index+1].minLimit ?? 0)+(self.offerData[index+1].maxLimit ?? 0))/2
            let item3 = OfferListData(amount: amountValue,
                                     percentage: self.offerData[index+1].percentage ?? 0,
                                     bonusAmount: percentageValue(percent: self.offerData[index+1].percentage ?? 0,
                                                                  number: amountValue,
                                                                  capValue: self.offerData[index+1].capValue ?? 0))
            array.append(item3)

        }
        self.delegate?.updateOffers(offerList: array)
    }
    
    private func minimumToMidumValueOffer(index: Int) {
        var array = [OfferListData]()
        var amountValue = self.amount
        let item0 = OfferListData(amount: amountValue,
                                 percentage: self.offerData[index].percentage ?? 0,
                                 bonusAmount: percentageValue(percent: self.offerData[index].percentage ?? 0,
                                                              number: self.amount,
                                                              capValue: self.offerData[index].capValue ?? 0),
                                  isSelected: true)
        array.append(item0)

        
        amountValue = (self.offerData[index].maxLimit ?? 0)
        let item1 = OfferListData(amount: amountValue,
                                 percentage: self.offerData[index].percentage ?? 0,
                                 bonusAmount: percentageValue(percent: self.offerData[index].percentage ?? 0,
                                                              number: amountValue,
                                                              capValue: self.offerData[index].capValue ?? 0))
        array.append(item1)

        if (index+1) < self.offerData.count {
            amountValue = ((self.offerData[index+1].minLimit ?? 0) + (self.offerData[index+1].maxLimit ?? 0))/2
            let item2 = OfferListData(amount: amountValue,
                                     percentage: self.offerData[index+1].percentage ?? 0,
                                     bonusAmount: percentageValue(percent: self.offerData[index+1].percentage ?? 0,
                                                                  number: amountValue,
                                                                  capValue: self.offerData[index+1].capValue ?? 0))
            array.append(item2)

            amountValue = self.offerData[index+1].maxLimit ?? 0
            let item3 = OfferListData(amount: amountValue,
                                     percentage: self.offerData[index+1].percentage ?? 0,
                                     bonusAmount: percentageValue(percent: self.offerData[index+1].percentage ?? 0,
                                                                  number: amountValue,
                                                                  capValue: self.offerData[index+1].capValue ?? 0))
            array.append(item3)

        }
        self.delegate?.updateOffers(offerList: array)
    }
    
    private func midiumToMaximumValueOffer(index: Int) {
        var array = [OfferListData]()
        var amountValue = self.amount
        let item0 = OfferListData(amount: amountValue,
                                 percentage: self.offerData[index].percentage ?? 0,
                                 bonusAmount: percentageValue(percent: self.offerData[index].percentage ?? 0,
                                                              number: self.amount,
                                                              capValue: self.offerData[index].capValue ?? 0),
                                  isSelected: true)
        array.append(item0)

        if (index+1) < self.offerData.count {
            amountValue = (self.offerData[index+1].minLimit ?? 0)
            let item2 = OfferListData(amount: amountValue,
                                     percentage: self.offerData[index+1].percentage ?? 0,
                                     bonusAmount: percentageValue(percent: self.offerData[index+1].percentage ?? 0,
                                                                  number: amountValue,
                                                                  capValue: self.offerData[index+1].capValue ?? 0))
            array.append(item2)

            amountValue = ((self.offerData[index+1].minLimit ?? 0)+(self.offerData[index+1].maxLimit ?? 0))/2
            let item3 = OfferListData(amount: amountValue,
                                     percentage: self.offerData[index+1].percentage ?? 0,
                                     bonusAmount: percentageValue(percent: self.offerData[index+1].percentage ?? 0,
                                                                  number: amountValue,
                                                                  capValue: self.offerData[index+1].capValue ?? 0))
            array.append(item3)

        }
        self.delegate?.updateOffers(offerList: array)
    }
    private func maximumValueOffer(index: Int) {
        var array = [OfferListData]()
        var amountValue = self.amount
        let item0 = OfferListData(amount: amountValue,
                                 percentage: self.offerData[index].percentage ?? 0,
                                 bonusAmount: percentageValue(percent: self.offerData[index].percentage ?? 0,
                                                              number: self.amount, capValue: self.offerData[index].capValue ?? 0),
                                  isSelected: true)
        array.append(item0)
        if (index+1) < self.offerData.count {
            amountValue = ((self.offerData[index+1].minLimit ?? 0)+(self.offerData[index+1].maxLimit ?? 0))/2
            
            let item1 = OfferListData(amount: amountValue,
                                     percentage: self.offerData[index+1].percentage ?? 0,
                                     bonusAmount: percentageValue(percent: self.offerData[index+1].percentage ?? 0,
                                                                  number: amountValue, capValue: self.offerData[index+1].capValue ?? 0))
            array.append(item1)

            amountValue = (self.offerData[index+1].maxLimit ?? 0)
            let item2 = OfferListData(amount: amountValue,
                                     percentage: self.offerData[index+1].percentage ?? 0,
                                     bonusAmount: percentageValue(percent: self.offerData[index+1].percentage ?? 0,
                                                                  number: amountValue, capValue: self.offerData[index+1].capValue ?? 0))
            array.append(item2)
        }
        if (index+2) < self.offerData.count {
            amountValue = ((self.offerData[index+2].minLimit ?? 0)+(self.offerData[index+2].maxLimit ?? 0))/2
            let item3 = OfferListData(amount: amountValue,
                                     percentage: self.offerData[index+2].percentage ?? 0,
                                     bonusAmount: percentageValue(percent: self.offerData[index+2].percentage ?? 0,
                                                                  number: amountValue, capValue: self.offerData[index+2].capValue ?? 0))
            array.append(item3)
        }
        self.delegate?.updateOffers(offerList: array)
    }
    
    private func showOffersForEmpty() -> [OfferListData] {
        var array = [OfferListData]()
        for offer in self.offerData {
            let item = OfferListData(amount: offer.minLimit ?? 0,
                                     percentage: offer.percentage ?? 0,
                                     bonusAmount: percentageValue(percent: offer.percentage ?? 0,
                                                                  number: offer.minLimit ?? 0, capValue: offer.capValue ?? 0))
            array.append(item)
        }
        return array
    }
    
    private func percentageValue(percent: Int, number: Int, capValue: Int) -> Int {
        return ((percent*number)/100) > capValue ? capValue : ((percent*number)/100)
    }
}

enum UserOfferType {
    case promotional
    case rummy
    case poker
    case ludo
}
