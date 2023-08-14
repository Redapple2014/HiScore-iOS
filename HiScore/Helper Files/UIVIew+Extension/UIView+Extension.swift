//
//  UIView+Extension.swift
//  HiScore
//
//  Created by PC-072 on 09/08/23.
//

import Foundation
import UIKit
extension UIView {
    func setBUttonGradientBackground() {
        let colorTop =  UIColor(red: 0.96, green: 0.89, blue: 0.72, alpha: 1).cgColor
        let colorBottom = UIColor(red: 0.8, green: 0.62, blue: 0.32, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at:0)
    }

    func setGradientForSliderBG() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ UIColor(red: 0.475, green: 0.416, blue: 0.361, alpha: 1).cgColor, UIColor(red: 0.078, green: 0.094, blue: 0.169, alpha: 1).cgColor, UIColor(red: 0.408, green: 0.361, blue: 0.325, alpha: 0).cgColor
            ]
        gradientLayer.locations = [0, 1, 1]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}

