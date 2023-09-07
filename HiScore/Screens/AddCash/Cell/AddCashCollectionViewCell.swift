//
//  AddCashCollectionViewCell.swift
//  HiScore
//
//  Created by PC-072 on 28/08/23.
//

import UIKit

class AddCashCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var vwNotSelected: HSShadowView!
    @IBOutlet weak var viewBG: HSShadowView!
    @IBOutlet weak var viewTopHeader: HSShadowView!
    @IBOutlet weak var imageISelected: UIImageView!
    @IBOutlet weak var labelHeaderText: UILabel!

    @IBOutlet weak var labelBonusPercentageAmount: UILabel!
    @IBOutlet weak var labeOfferPercentage: UILabel!
    @IBOutlet weak var labeITotalAmount: UILabel!

    func loadCell(data: OfferListData) {
        labelBonusPercentageAmount.text = "₹ \(data.bonusAmount)"
        labeOfferPercentage.text = "Get \(data.percentage) %"
        labeITotalAmount.text = "₹ \(data.amount)"
        vwNotSelected.backgroundColor = .clear
        if data.isSelected {
            showSelectedUI()
        } else {
            showNotSelectedUI()
        }
    }
    func showSelectedUI() {
       // viewBG.backgroundColor = UIColor.clear
        vwNotSelected.isHidden = true
        imageISelected.isHidden = false
        labelBonusPercentageAmount.textColor = .HSGreen
        labeOfferPercentage.alpha = 0.5
        labeOfferPercentage.textColor = .HSBlackColor
        labeITotalAmount.textColor =  .HSBlackColor
        imageISelected.isHidden = false
    }
    func showNotSelectedUI() {
      //  viewBG.backgroundColor = .clear
        vwNotSelected.isHidden = false
        imageISelected.isHidden = true
        labelBonusPercentageAmount.textColor =  .HSWhiteColor
        labeOfferPercentage.alpha = 1
        labeOfferPercentage.textColor = .HSYellowColor2
        labeITotalAmount.textColor =  .HSWhiteColor
        imageISelected.isHidden = true
    }
}
