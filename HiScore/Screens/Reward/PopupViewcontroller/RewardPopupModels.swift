//
//  RewardPopupModels.swift
//  HiScore
//
//  Created by PC-072 on 21/08/23.
//

import Foundation



// MARK: - Welcome
struct RewardPopupResponseModel: Codable {
    let status, message: String
    let statusCode: Int
    let data: RewardDataClass

    enum CodingKeys: String, CodingKey {
        case status, message
        case statusCode = "status_code"
        case data
    }
}

// MARK: - DataClass
struct RewardDataClass: Codable {
    let greetingSection: GreetingSection
    let hurryUpSection: HurryUpSection
    let rewardSection: RewardSection
    let knowMoreSection: KnowMoreSection

    enum CodingKeys: String, CodingKey {
        case greetingSection = "greeting_section"
        case hurryUpSection = "hurry_up_section"
        case rewardSection = "reward_section"
        case knowMoreSection = "know_more_section"
    }
}

// MARK: - GreetingSection
struct GreetingSection: Codable {
    let username, subtitle: String
}

// MARK: - HurryUpSection
struct HurryUpSection: Codable {
    let hurryTitle, hurrySubtitle: String
    let timeLeft: Int

    enum CodingKeys: String, CodingKey {
        case hurryTitle = "hurry_title"
        case hurrySubtitle = "hurry_subtitle"
        case timeLeft = "time_left"
    }
}

// MARK: - KnowMoreSection
struct KnowMoreSection: Codable {
    let rewardsList: [RewardsList]
}

// MARK: - RewardsList
struct RewardsList: Codable {
    let rewardTitle, rewardDesc: String
    let rewardIcon: String

    enum CodingKeys: String, CodingKey {
        case rewardTitle = "reward_title"
        case rewardDesc = "reward_desc"
        case rewardIcon = "reward_icon"
    }
}
extension RewardsList: EventUrlPresentable {
    var splashScreenUrl: URL {
        return URL(string: rewardIcon)!
    }
}

// MARK: - RewardSection
struct RewardSection: Codable {
    let totalRewardReceived: Int
    let currency, totalRewardSubtitle: String
    let allRewards: AllRewards

    enum CodingKeys: String, CodingKey {
        case totalRewardReceived = "total_reward_received"
        case currency
        case totalRewardSubtitle = "total_reward_subtitle"
        case allRewards = "all_rewards"
    }
}

// MARK: - AllRewards
struct AllRewards: Codable {
    let verticalSet: [JSONAny]
    let horizontalSet: [HorizontalSet]

    enum CodingKeys: String, CodingKey {
        case verticalSet = "vertical_set"
        case horizontalSet = "horizontal_set"
    }
}

// MARK: - HorizontalSet
struct HorizontalSet: Codable {
    let rewardType: String
    let rewardValue: Int
    let currency: String

    enum CodingKeys: String, CodingKey {
        case rewardType = "reward_type"
        case rewardValue = "reward_value"
        case currency
    }
}
