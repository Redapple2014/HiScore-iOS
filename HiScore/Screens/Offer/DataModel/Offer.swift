//
//  Offer.swift
//  HiScore
//
//  Created by RATPC-043 on 22/08/23.
//

// MARK: - Welcome
struct OfferResponseModel: Codable {
    let status, message: String
    let data: OfferDetails?
}

// MARK: - OfferDetails
struct OfferDetails: Codable {
    let hurryUpSection: TimerSection
    let greetingSection: Greeting
    let offersSection: OffersSection

    enum CodingKeys: String, CodingKey {
        case hurryUpSection = "hurry_up_section"
        case greetingSection = "greeting_section"
        case offersSection = "offers_section"
    }
}

// MARK: - GreetingSection
struct Greeting: Codable {
    let greetingTitle, greetingSubtitle: GreetingSubtitle

    enum CodingKeys: String, CodingKey {
        case greetingTitle = "greeting_title"
        case greetingSubtitle = "greeting_subtitle"
    }
}

// MARK: - GreetingSubtitle
struct GreetingSubtitle: Codable {
    let en, hi: String
}

// MARK: - HurryUpSection
struct TimerSection: Codable {
    let hurryTitle, hurrySubtitle: GreetingSubtitle
    let timeLeft: Int

    enum CodingKeys: String, CodingKey {
        case hurryTitle = "hurry_title"
        case hurrySubtitle = "hurry_subtitle"
        case timeLeft = "time_left"
    }
}

// MARK: - OffersSection
struct OffersSection: Codable {
    let offers: [Offer]
}

// MARK: - Offer
struct Offer: Codable {
    let offerCode: String
    let discountPercentage, lowerLimit, upperLimit, maxCashbackAmt: Int
    let isTagAvailable: Bool
    let buttonText: GreetingSubtitle
    let offerType: String
    let bannerURL: String
    let category: String

    enum CodingKeys: String, CodingKey {
        case offerCode = "offer_code"
        case discountPercentage = "discount_percentage"
        case lowerLimit = "lower_limit"
        case upperLimit = "upper_limit"
        case maxCashbackAmt = "max_cashback_amt"
        case isTagAvailable
        case buttonText = "button_text"
        case offerType = "offer_type"
        case bannerURL = "banner_url"
        case category
    }
}
