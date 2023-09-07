//
//  AddOffersTableViewCell.swift
//  HiScore
//
//  Created by PC-072 on 07/09/23.
//

import UIKit

class AddOffersTableViewCell: UITableViewCell {

    @IBOutlet weak var labelPercent: UILabel!
    @IBOutlet weak var viewGreen: UIView!
    @IBOutlet weak var viewDark: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        designViewGreen()
        designviewDark()
        rotateLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func rotateLabel() {
        labelPercent.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
    }
    func designviewDark() {
        viewDark.backgroundColor = .clear
        let cornerRadius: CGFloat = 20.0
        // Create a UIBezierPath for the rounded corners
        let maskPath = UIBezierPath(
            roundedRect: viewDark.bounds,
            byRoundingCorners: [.topRight, .bottomRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        // Create a CAShapeLayer with the path
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        // Apply the mask to the UIView
        viewDark.layer.mask = maskLayer
    }
    func designViewGreen() {
        let cornerRadius: CGFloat = 20.0
        // Create a UIBezierPath for the rounded corners
        let maskPath = UIBezierPath(
            roundedRect: viewGreen.bounds,
            byRoundingCorners: [.topLeft, .bottomLeft],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        // Create a CAShapeLayer with the path
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        // Apply the mask to the UIView
        viewGreen.layer.mask = maskLayer

    }
}
