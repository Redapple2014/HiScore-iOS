//
//  UserDataModel.swift
//  HiScore
//
//  Created by RATPC-043 on 05/09/23.
//

import Foundation

// MARK: - UserDataModel
struct UserDataModel: Codable {
    let data: UserDataClass
}

// MARK: - DataClass
struct UserDataClass: Codable {
    let userID: Int
    let userName, userEmail, userNick: String
    let userPhoto: String
    let userFbID, userGoogleID: String?
    let info: UserInformation
    let daysInApp, countGroups, countPredictions, countPowerups: Int
    let totalPoints, accuracy: Int
    let paymentInfo: String?
    let otpNumber, userMobile, mostPlayedSport: String
    let countContestsJoined, countPaidContestsJoined, countDeposits, countMatches: Int
    let liveQuizPlayed: Int
    let hasUnreadActivities: Bool
    let totalPowerups, countReferrals: Int
    let hasReferred, hasDeposited: Bool
    let pinpoint: Pinpoint
    let userServicePriority: String
    let showQuest, hideQuizButton, hideRealtimeQuiz, hideQuizMaster: Bool
    let playerPollUsed, newPicksUI, autojoinEnabled: Bool
    let userSegment: String
    let hasPurchasedPass, contactsSynced: Bool
    let quizButtonColor: Int
    let moe: Moe
    let userStatus: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userName = "user_name"
        case userEmail = "user_email"
        case userNick = "user_nick"
        case userPhoto = "user_photo"
        case userFbID = "user_fb_id"
        case userGoogleID = "user_google_id"
        case info
        case daysInApp = "days_in_app"
        case countGroups = "count_groups"
        case countPredictions = "count_predictions"
        case countPowerups = "count_powerups"
        case totalPoints = "total_points"
        case accuracy
        case paymentInfo = "payment_info"
        case otpNumber = "otp_number"
        case userMobile = "user_mobile"
        case mostPlayedSport = "most_played_sport"
        case countContestsJoined = "count_contests_joined"
        case countPaidContestsJoined = "count_paid_contests_joined"
        case countDeposits = "count_deposits"
        case countMatches = "count_matches"
        case liveQuizPlayed = "live_quiz_played"
        case hasUnreadActivities = "has_unread_activities"
        case totalPowerups = "total_powerups"
        case countReferrals = "count_referrals"
        case hasReferred = "has_referred"
        case hasDeposited = "has_deposited"
        case pinpoint
        case userServicePriority = "user_service_priority"
        case showQuest = "show_quest"
        case hideQuizButton = "hide_quiz_button"
        case hideRealtimeQuiz = "hide_realtime_quiz"
        case hideQuizMaster = "hide_quiz_master"
        case playerPollUsed = "player_poll_used"
        case newPicksUI = "new_picks_ui"
        case autojoinEnabled = "autojoin_enabled"
        case userSegment = "user_segment"
        case hasPurchasedPass = "has_purchased_pass"
        case contactsSynced = "contacts_synced"
        case quizButtonColor = "quiz_button_color"
        case moe
        case userStatus = "user_status"
    }
}

// MARK: - Info
struct UserInformation: Codable {
    let dupe: Bool
    let level: String
    let badges: [JSONAny]
    let campaign: String
    let powerups: Powerups
    let referrals: [JSONAny]
    let friendCode: JSONNull?
    let walletInit: Int
    let appsflyerID: String
    let otpVerified, tosAccepted: Bool
    let voucherCode: JSONNull?
    let notifications: Notifications
    let emailVerified, walletCreated: Bool
    let accessProvider, appsflyerAdset: String
    let mobileVerified, profileCreated: Bool
    let pokerPromoInit, rummyPromoInit: Int
    let transientBadges: [JSONAny]
    let appsflyerChannel, appsflyerCampaign: String
    let showUserBenefits: Bool
    let userReferralCode: String
    let callbreakPromoInit: Int
    let campaignVoucherArr: [String]
    let isDefaultPromoApplied: Bool
    let appsflyerMediaSource: String
    let isDefaultPSPromoApplied, firstDepositCashbackClaimedV2: Bool
    private let kycStatus: String

    enum CodingKeys: String, CodingKey {
        case dupe, level, badges, campaign, powerups, referrals
        case friendCode = "friend_code"
        case walletInit = "wallet_init"
        case appsflyerID = "appsflyer_id"
        case otpVerified = "otp_verified"
        case tosAccepted = "tos_accepted"
        case voucherCode = "voucher_code"
        case notifications
        case emailVerified = "email_verified"
        case walletCreated = "wallet_created"
        case accessProvider = "access_provider"
        case appsflyerAdset = "appsflyer_adset"
        case mobileVerified = "mobile_verified"
        case profileCreated = "profile_created"
        case pokerPromoInit = "poker_promo_init"
        case rummyPromoInit = "rummy_promo_init"
        case transientBadges = "transient_badges"
        case appsflyerChannel = "appsflyer_channel"
        case appsflyerCampaign = "appsflyer_campaign"
        case showUserBenefits = "show_user_benefits"
        case userReferralCode = "user_referral_code"
        case callbreakPromoInit = "callbreak_promo_init"
        case campaignVoucherArr = "campaign_voucher_arr"
        case isDefaultPromoApplied
        case appsflyerMediaSource = "appsflyer_media_source"
        case isDefaultPSPromoApplied, firstDepositCashbackClaimedV2
        case kycStatus = "kyc_status"
    }
}

// MARK: - Notifications
struct Notifications: Codable {
    let daily, hourly: Bool
}

// MARK: - Powerups
struct Powerups: Codable {
    let the2X, noNegs, playerPoll: Int

    enum CodingKeys: String, CodingKey {
        case the2X = "2x"
        case noNegs = "no_negs"
        case playerPoll = "player_poll"
    }
}

// MARK: - Moe
struct Moe: Codable {
    let isUserEven: Bool
    let countPayins, sumPayins, bankCount, roomsJoined: Int
    let countDeposits: Int
    let referrals: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case isUserEven = "is_user_even"
        case countPayins = "count_payins"
        case sumPayins = "sum_payins"
        case bankCount = "bank_count"
        case roomsJoined = "rooms_joined"
        case countDeposits = "count_deposits"
        case referrals
    }
}

// MARK: - Pinpoint
struct Pinpoint: Codable {
    let countReferrals: Int
    let hasReferred: Bool
    let countDeposits: Int
    let hasDeposited: Bool
    let countContestsJoined, countPaidContestsJoined: Int
    let mostPlayedSport: String
    let countPowerups: Int
    let lastSeenDate, lastSeenWeek: String

    enum CodingKeys: String, CodingKey {
        case countReferrals = "count_referrals"
        case hasReferred = "has_referred"
        case countDeposits = "count_deposits"
        case hasDeposited = "has_deposited"
        case countContestsJoined = "count_contests_joined"
        case countPaidContestsJoined = "count_paid_contests_joined"
        case mostPlayedSport = "most_played_sport"
        case countPowerups = "count_powerups"
        case lastSeenDate = "last_seen_date"
        case lastSeenWeek = "last_seen_week"
    }
}

enum  UserKycStatus {
    case required
    var description: String {
        switch self {
        case .required: return "required"
        }
    }
}

extension UserInformation: UserKycStatusDelegate {
    var kycstatus: UserKycStatus? {
        if kycStatus == UserKycStatus.required.description {
            return .required
        } else {
            return nil
        }
    }
}

protocol UserKycStatusDelegate {
    var kycstatus: UserKycStatus? { get }
}
