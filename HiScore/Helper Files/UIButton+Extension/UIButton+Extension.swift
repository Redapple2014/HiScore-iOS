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
        let colorTop =  UIColor(red: 0.96, green: 0.89, blue: 0.72, alpha: 1).cgColor
        let colorBottom = UIColor(red: 0.8, green: 0.62, blue: 0.32, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at:0)
        self.setTitleColor(.HSGradientButtonTextColor, for: .normal)
    }
    private func designLightGreyButton() {
        self.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1).cgColor
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.953, green: 0.871, blue: 0.694, alpha: 0.25).cgColor
        self.setTitleColor(.HSDarkButtonTextColor, for: .normal)
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
