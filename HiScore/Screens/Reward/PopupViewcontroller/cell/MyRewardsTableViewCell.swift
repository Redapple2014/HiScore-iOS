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

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        viewGradient.layoutIfNeeded()
        viewGradient.setNeedsLayout()
//        imageContainer()
    }
    func configCell(data: HorizontalSet) {
        viewBG.backgroundColor = .clear
        if data.rewardType.contains("Rummy") {
            imgIcon.image = UIImage(named: "RummyCash")
        } else if data.rewardType.contains("Game") {
            imgIcon.image = UIImage(named: "cashTicket")
        } else {//if data.rewardType.contains("") {
            imgIcon.image = UIImage(named: "cash")
        }
        labelAmuont.text = "₹\(data.rewardValue)"
        labelRewardName.text = data.rewardType
        
    }
//    func imageContainer() {
////        viewGradient.setGradientBackground(colorTop: UIColor(red: 1, green: 1, blue: 1, alpha: 1), colorBottom: UIColor(red: 1, green: 1, blue: 1, alpha: 0))
////        viewGradient.layer.cornerRadius = 10
////        viewGradient.clipsToBounds = true
////        viewGradient.backgroundColor = .clear
//    }
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
