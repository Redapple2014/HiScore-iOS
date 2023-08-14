//
//  UIButton+Extension.swift
//  HiScore
//
//  Created by PC-072 on 09/08/23.
//

import Foundation
import UIKit

extension UIButton {
    func setGradientBackground() {
        let colorTop =  UIColor(red: 0.96, green: 0.89, blue: 0.72, alpha: 1).cgColor
        let colorBottom = UIColor(red: 0.8, green: 0.62, blue: 0.32, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}
