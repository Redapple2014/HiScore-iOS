//
//  OfferCollectionCell.swift
//  HiScore
//
//  Created by RATPC-043 on 22/08/23.
//

import Foundation
import UIKit

class OfferCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageViewOffer: UIImageView!
    @IBOutlet weak var labelButtonText: UILabel!
    @IBOutlet weak var viewButton: UIView!
    override func awakeFromNib() {
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        viewButton.setNeedsLayout()
        viewButton.layoutIfNeeded()
        viewButton.setGradiantColor(topColor: .white,
                                    bottomColor: .white.withAlphaComponent(0.5),
                                    cornerRadius: 8,
                                    gradiantDirection: .topToBottom)
        viewButton.setCornerBorder(color: nil,
                                  cornerRadius: 8,
                                  borderWidth: 0)
    }
    var offer: Offer? {
        didSet {
            if let data = offer {
                let url = URL(string: data.bannerURL)
                imageViewOffer.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
                labelButtonText.text = data.buttonText.en
            }
        }
    }
}
class PlaceholderCell: UICollectionViewCell {
    @IBOutlet weak var imageViewPlaceholder: UIImageView!
    @IBOutlet weak var viewBackground: UIView!
    override func layoutSubviews() {
        super.layoutSubviews()
        viewBackground.layer.cornerRadius = 10
    }
}
