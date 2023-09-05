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
        if data.isSelected {
            
        }
    }

    func showSelectedUI() {
        
    }
}
