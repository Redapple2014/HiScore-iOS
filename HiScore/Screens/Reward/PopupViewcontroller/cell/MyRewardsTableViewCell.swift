//
//  MyRewardsTableViewCell.swift
//  HiScore
//
//  Created by PC-072 on 21/08/23.
//

import UIKit
//import Kingfisher

class MyRewardsTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var viewGradient: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var labelAmuont: UILabel!
    @IBOutlet weak var labelRewardName: UILabel!
//
//    var data: RewardsList {
//        didSet {
//            imgIcon.kf.setImage(with: data.rewardIcon,
//                                    placeholder: UIImage(named: "placeholder"),
//                                    options: nil,
//                                    progressBlock: nil,
//                                    completionHandler: nil)
//            labelAmuont.text = "₹ 600"
//            labelRewardName.text = data.rewardTitle
//        }
//    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        viewGradient.layoutIfNeeded()
        viewGradient.setNeedsLayout()
        imageContainer()
    }
    func configCell(data: RewardsList) {
        viewBG.backgroundColor = .clear
        imgIcon.kf.setImage(with: data.splashScreenUrl,
                                placeholder: UIImage(named: "placeholder"),
                                options: nil,
                                progressBlock: nil,
                                completionHandler: nil)
        labelAmuont.text = "₹ 600"
        labelRewardName.text = data.rewardTitle
    }
    func imageContainer() {
        viewGradient.setGradientBackground(colorTop: UIColor(red: 1, green: 1, blue: 1, alpha: 1), colorBottom: UIColor(red: 1, green: 1, blue: 1, alpha: 0))
        viewGradient.layer.cornerRadius = 10
        viewGradient.clipsToBounds = true
        viewGradient.backgroundColor = .clear
    }
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
