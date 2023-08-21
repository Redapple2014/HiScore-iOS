//
//  UIView+Extension.swift
//  HiScore
//
//  Created by PC-072 on 09/08/23.
//

import Foundation
import UIKit

extension UIView {
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = self.bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    func circleUI() {
        self.backgroundColor = .clear
        self.layer.borderWidth = 0.9
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
        self.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.06).cgColor
    }
}
