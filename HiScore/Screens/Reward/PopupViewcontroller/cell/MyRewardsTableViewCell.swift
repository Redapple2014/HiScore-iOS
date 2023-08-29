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
    }
    func configCell(data: HorizontalSet, index: Int) {
        if (index % 2 == 0) {
            viewBG.backgroundColor = .clear
        } else {
            viewBG.backgroundColor = .black.withAlphaComponent(0.08)
        }
        if data.rewardType.contains("Rummy") {
            imgIcon.image = UIImage(named: "RummyCash")
        } else if data.rewardType.contains("Game") {
            imgIcon.image = UIImage(named: "cashTicket")
        } else {
            imgIcon.image = UIImage(named: "cash")
        }
        labelAmuont.text = "₹\(data.rewardValue)"
        labelRewardName.text = data.rewardType
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
