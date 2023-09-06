//
//  AddCashModel.swift
//  HiScore
//
//  Created by PC-072 on 28/08/23.
//

import Foundation

import Foundation

// MARK: - AddCashResponseModel
struct AddCashResponseModel: Codable {
    let status, message: String?
    let data: AddCashDataClass?
}

// MARK: - DataClass
struct AddCashDataClass: Codable {
    let route: String?
    let minDepositAmt: Int?
    let offerTypes: OfferTypes?
    let extraInfo: JSONNull?
    let isFirstDepositDone: Bool?
    let cashbackKnowMoreSection: CashbackKnowMoreSection?
    let promoExpiryDate: String?

    enum CodingKeys: String, CodingKey {
        case route
        case minDepositAmt = "min_deposit_amt"
        case offerTypes = "offer_types"
        case extraInfo = "extra_info"
        case isFirstDepositDone = "is_first_deposit_done"
        case cashbackKnowMoreSection = "cashback_know_more_section"
        case promoExpiryDate = "promo_expiry_date"
    }
}

// MARK: - CashbackKnowMoreSection
struct CashbackKnowMoreSection: Codable {
    let rewardList: [RewardsList]

    enum CodingKeys: String, CodingKey {
        case rewardList = "reward_list"
    }
}

// MARK: - RewardList
//struct RewardList: Codable {
//    let rewardTitle, rewardDesc: String?
//    let rewardIcon: String?
//
//    enum CodingKeys: String, CodingKey {
//        case rewardTitle = "reward_title"
//        case rewardDesc = "reward_desc"
//        case rewardIcon = "reward_icon"
//    }
//}

// MARK: - OfferTypes
struct OfferTypes: Codable {
    let promotionalOffers: PromotionalOffers?

    enum CodingKeys: String, CodingKey {
        case promotionalOffers = "promotional_offers"
    }
}

// MARK: - PromotionalOffers
struct PromotionalOffers: Codable {
    let typeName, typeDesc: String?
    let offers: [OfferData]?
    let onboardingVoucherCodeApplied: Bool?
    let rewardType: String?

    enum CodingKeys: String, CodingKey {
        case typeName = "type_name"
        case typeDesc = "type_desc"
        case offers
        case onboardingVoucherCodeApplied = "onboarding_voucher_code_applied"
        case rewardType = "reward_type"
    }
}

// MARK: - Offer
struct OfferData: Codable {
    let offerCode, offerTitle: String?
    let offerDesc, offerMoreInfo: [String]?
    let minLimit, maxLimit, capValue, percentage: Int?
    let rewardText, offerAppliedMsg: String?
    let onboardingCashback: Bool?
    let backgroundImgURL: String?
    let offerType: String?
    let secondaryCashback: JSONNull?
    let promoExpiryExtendedHrs: Int?

    enum CodingKeys: String, CodingKey {
        case offerCode = "offer_code"
        case offerTitle = "offer_title"
        case offerDesc = "offer_desc"
        case offerMoreInfo = "offer_more_info"
        case minLimit = "min_limit"
        case maxLimit = "max_limit"
        case capValue = "cap_value"
        case percentage
        case rewardText = "reward_text"
        case offerAppliedMsg = "offer_applied_msg"
        case onboardingCashback
        case backgroundImgURL = "background_img_url"
        case offerType = "offer_type"
        case secondaryCashback = "secondary_cashback"
        case promoExpiryExtendedHrs = "promo_expiry_extended_hrs"
    }
}

class OfferListData {
    var amount: Int
    var percentage: Int
    var bonusAmount: Int
    var isSelected: Bool
    
    init(amount: Int,percentage: Int,bonusAmount: Int, isSelected: Bool = false) {
        self.amount = amount
        self.percentage = percentage
        self.bonusAmount = bonusAmount
        self.isSelected = isSelected
    }
}
