//
//  SlidesCollectionViewCell.swift
//  HiScore
//
//  Created by PC-072 on 14/08/23.
//

import UIKit

class SlidesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageSlides: UIImageView!
    @IBOutlet weak var labelHeader1: UILabel!
    @IBOutlet weak var labelHeader2: UILabel!
    
    var images: Images? {
        didSet {
            labelHeader1.text = images?.title
            labelHeader2.text = images?.subTitle
            imageSlides.kf.setImage(with: images?.splashScreenUrl)
        }
    }
}
