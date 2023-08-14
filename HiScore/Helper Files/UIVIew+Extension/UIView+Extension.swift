//
//  UIView+Extension.swift
//  HiScore
//
//  Created by PC-072 on 09/08/23.
//

import Foundation
import UIKit
extension UIView {
    func setGradientBackground(colors:[UIColor] ) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 0.5 ,1.0 ]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}

