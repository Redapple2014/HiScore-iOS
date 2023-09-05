//
//  AddCashCollectionViewCell.swift
//  HiScore
//
//  Created by PC-072 on 28/08/23.
//

import UIKit

class AddCashCollectionViewCell: UICollectionViewCell {
    
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
//        viewBG.layoutSubviews()
//        viewBG.setNeedsLayout()
//
        if data.isSelected {
            showSelectedUI()
        } else {
            showNotSelectedUI()
        }
    }
    func showSelectedUI() {
//        viewBG.backgroundColor = UIColor.clear
//        viewBG.color1 = .HSYellowButtonColor
//        viewBG.color2 = .HSDarkYellowButtonColor
//        viewBG.color3 = .HSDarkYellowButtonColor
//        viewBG.color4 = .HSDarkYellowButtonColor
//        viewBG.borderWidth = 2
//        viewBG.borderColor1 = .HSWhiteColor.withAlphaComponent(0.5)
//        viewBG.borderColor2 = .HSWhiteColor.withAlphaComponent(0)
//        viewBG.shadowColor = .lightGray
        imageISelected.isHidden = false
    }
    func showNotSelectedUI() {
//        viewBG.backgroundColor = .HSDarkBlue
//        viewBG.setGradientBackground(colorTop: .HSMediumDarkBlue, colorBottom: .HSdar)
//      //  viewBG.backgroundColor = UIColor.clear
//        viewBG.color1 = .HSMediumDarkBlue
//        viewBG.color2 = .HSMediumDarkBlue
//        viewBG.color3 = .HSMediumDarkBlue
//        viewBG.color4 = .HSDarkBlue
//        viewBG.borderColor1 = .clear
//        viewBG.borderColor2 = .clear
//        viewBG.shadowColor = .clear
        imageISelected.isHidden = true
    }
}
