//
//  WalletModel.swift
//  HiScore
//
//  Created by RATPC-043 on 04/09/23.
//

import Foundation

// MARK: - Wallet
struct Wallet: Codable {
    let paytmPayout: Bool
    let winningsAmount, depositAmount, promoAmount, withdrawalProgress: Int
    let lockedAmount, nonTaxableWithdrawalAmount: Int
    let tdsPercents: Double
    let tdsKnowMoreURL: String
    let paymentInfo: PaymentInfo?
    let upiID, upiBankingName: String
    let promoExpiryDate: String?
    let pokerBalance: Double
    let pokerPromo: Int
    let showPokerWallet, showPokerPromo: Bool
    let pokerPromoPercentage: Int
    let showRummyCash: Bool
    let rummyCash: Double
    let rummyCashInfo: [Info]
    let showCallbreakCash: Bool
    let callBreakCash: Int
    let callBreakInfo: [Info]

    enum CodingKeys: String, CodingKey {
        case paytmPayout = "paytm_payout"
        case winningsAmount, depositAmount, promoAmount, withdrawalProgress, lockedAmount
        case nonTaxableWithdrawalAmount = "non_taxable_withdrawal_amount"
        case tdsPercents = "tds_percents"
        case tdsKnowMoreURL = "tds_know_more_url"
        case paymentInfo = "payment_info"
        case upiID = "upi_id"
        case upiBankingName = "upi_banking_name"
        case promoExpiryDate = "promo_expiry_date"
        case pokerBalance, pokerPromo, showPokerWallet
        case showPokerPromo = "show_poker_promo"
        case pokerPromoPercentage = "poker_promo_percentage"
        case showRummyCash = "show_rummy_cash"
        case rummyCash = "rummy_cash"
        case rummyCashInfo = "rummy_cash_info"
        case showCallbreakCash = "show_callbreak_cash"
        case callBreakCash = "call_break_cash"
        case callBreakInfo = "call_break_info"
    }
}

// MARK: - Info
struct Info: Codable {
    let text: String
    let iconURL: String

    enum CodingKeys: String, CodingKey {
        case text
        case iconURL = "icon_url"
    }
}

// MARK: - PaymentInfo
struct PaymentInfo: Codable {
    let cashfree: Cashfree
}

// MARK: - Cashfree
struct Cashfree: Codable {
    let ifsc, name, address1, bankAccount: String
}
