//
//  TipView.swift
//  HiScore
//
//  Created by RATPC-043 on 06/09/23.
//

import Foundation
import UIKit

class TipView: UIView {
    @IBOutlet weak var labelHedaer: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var toolTipView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("TipView", owner: self, options: nil)
        contentView.frame = frame
        self.addSubview(contentView)
        toolTipView.setGradiantColor(topColor: .HSWhiteColor,
                                     bottomColor: .HSLightGreen,
                                     cornerRadius: 6,
                                     gradiantDirection: .leftToRight)
        toolTipView.setCornerBorder(color: nil,
                                    cornerRadius: 6,
                                    borderWidth: 0)
    }
    
    func setMessage(title: String, message: String, image: UIImage) {
        labelHedaer.text = title
        labelDescription.text = message
        imageViewLogo.image = image
    }
}