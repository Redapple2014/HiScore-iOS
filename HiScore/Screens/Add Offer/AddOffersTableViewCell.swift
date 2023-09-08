//
//  AddOffersTableViewCell.swift
//  HiScore
//
//  Created by PC-072 on 07/09/23.
//

import UIKit

class AddOffersTableViewCell: UITableViewCell {

    @IBOutlet weak var tickImageWidth: NSLayoutConstraint!
    @IBOutlet weak var imageTick: UIImageView!
    @IBOutlet weak var labelPercent: UILabel!
    @IBOutlet weak var viewGreen: UIView!
    @IBOutlet weak var viewDark: UIView!
    @IBOutlet weak var viewOrange: UIView!
    
    @IBOutlet weak var vwApply: UIView!
    @IBOutlet weak var labelPercentageExtra: UILabel!
    @IBOutlet weak var labelDepositRange: UILabel!
    @IBOutlet weak var labelOfferDesc: UILabel!
    @IBOutlet weak var labelMoreInfo1: UILabel!
    @IBOutlet weak var labelMoreInfo2: UILabel!
    @IBOutlet weak var buttonApply: UIButton!
    
    var buttonTapped:((OfferData, Int)-> Void)?
    var data:OfferData?
    var index: Int?
}
extension AddOffersTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        designViewGreen()
        designviewDark()
        designViewOrange()
        rotateLabel()
        shadowView(isSelected: false)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
extension AddOffersTableViewCell {
  private func rotateLabel() {
        labelPercent.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
    }
    private func shadowView(isSelected: Bool) {
        if isSelected {
            vwApply.layer.borderWidth = 0
            return
        }
        vwApply.layer.cornerRadius = 10
        // border
        vwApply.layer.borderWidth = 1.0
        vwApply.layer.borderColor = UIColor.HSWhiteColor.withAlphaComponent(0.5).cgColor
        // shadow
        vwApply.layer.shadowColor = UIColor.HSWhiteColor.withAlphaComponent(0.2).cgColor
        vwApply.layer.shadowOffset = CGSize(width: 3, height: 3)
        vwApply.layer.shadowOpacity = 0.7
        vwApply.layer.shadowRadius = 4.0
    }

    private func designviewDark() {
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
    private func designViewGreen() {
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
    private func designViewOrange() {
        let cornerRadius: CGFloat = 20.0
        // Create a UIBezierPath for the rounded corners
        let maskPath = UIBezierPath(
            roundedRect: viewOrange.bounds,
            byRoundingCorners: [.topLeft, .bottomLeft],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        // Create a CAShapeLayer with the path
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        // Apply the mask to the UIView
        viewOrange.layer.mask = maskLayer
    }
    
    private func showSelected() {
        viewOrange.isHidden = true
        viewGreen.isHidden = false
        vwApply.backgroundColor = .clear
        shadowView(isSelected: true)
        buttonApply.setTitle("Applied", for: .normal)
        imageTick.isHidden = false
        tickImageWidth.constant = 14
        buttonApply.setTitleColor(.HSNewGreenA1, for: .normal)
    }
    private func showNotSelected() {
        viewOrange.isHidden = false
        viewGreen.isHidden = true
        shadowView(isSelected: false)
        buttonApply.setTitle("Apply", for: .normal)
        buttonApply.setTitleColor(.HSYellowButtonColor, for: .normal)
        imageTick.isHidden = true
        tickImageWidth.constant = 0
         
    }

}
extension AddOffersTableViewCell {
    func loadCell(data:OfferData, index: Int) {
        self.data = data
        self.index = index
        labelDepositRange.text = data.offerTitle
        labelOfferDesc.text =     data.offerDesc?.count ?? 0 > 0 ? data.offerDesc?[0] : ""
        labelMoreInfo1.text = data.offerMoreInfo?.count ?? 0 > 0 ? data.offerMoreInfo?[0] : ""
        labelMoreInfo2.text = data.offerMoreInfo?.count ?? 1 > 1  ? data.offerMoreInfo?[1] : ""
        labelPercentageExtra.text =   "\(data.percentage ?? 0)% EXTRA"
        data.isSelected ? showSelected() : showNotSelected()
    }
}
extension AddOffersTableViewCell {
    @IBAction func buttonApplyTapped(_ sender: Any) {
        guard let tapped = buttonTapped else { return }
        guard let dataSelected = self.data , let arrayIndex = index else { return }
        tapped(dataSelected,arrayIndex)
    }
}
