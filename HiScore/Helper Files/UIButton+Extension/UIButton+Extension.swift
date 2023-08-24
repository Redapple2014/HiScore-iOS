//
//  UIButton+Extension.swift
//  HiScore
//
//  Created by PC-072 on 09/08/23.
//

import Foundation
import UIKit
import MHLoadingButton

enum ButtonColor {
    case lightGrey
    case yellow
}
extension LoadingButton {
    func setUpButtonWithGradientBackground(type: ButtonColor, fontSize: CGFloat = 14, cornerRadius: CGFloat = 10) {
        self.titleLabel?.font = UIFont.MavenPro.Bold.withSize(fontSize)
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        type == .yellow ? designYellowGradientButton() : designLightGreyButton()
    }
    private func designYellowGradientButton() {
        let colorTop =  UIColor.HSYellowButtonColor.cgColor
        let colorBottom = UIColor.HSDarkYellowButtonColor.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.setTitleColor(.HSBlackTextColor, for: .normal)
      }
    private func designLightGreyButton() {
        self.layer.backgroundColor = UIColor.HSWhiteColor.withAlphaComponent(0.1).cgColor
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.HSYellowTextColor.withAlphaComponent(0.25).cgColor
        self.setTitleColor(.HSYellowTextColor, for: .normal)
    }

    func initLoadingButton(color: UIColor = .black) {
        self.indicator = UIActivityIndicatorView()
        self.indicator = MaterialLoadingIndicator(color: color)
    }
    
    func showButtonLoader(vc: UIViewController) {
        self.showLoader(userInteraction: true)
        vc.view.isUserInteractionEnabled = false
    }
    
    func hideButtonLoader(vc: UIViewController) {
        self.hideLoader()
        vc.view.isUserInteractionEnabled = true
    }
}
