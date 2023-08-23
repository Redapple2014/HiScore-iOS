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
    func setGradiantColor(topColor : UIColor,
                          bottomColor: UIColor,
                          cornerRadius : CGFloat = 0.0
                          ,gradiantDirection : GradiantDirection = .topToBottom )
    {
        
        self.layer.sublayers?.filter{ $0 is CAGradientLayer }.forEach{ $0.removeFromSuperlayer() }
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.frame = self.bounds
        
        switch gradiantDirection {
        case .topToBottom:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        case .bottomToTop:
            gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        case .leftToRight:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .rightToLeft:
            gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        }
        
        gradient.masksToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.cornerRadius = cornerRadius
        gradient.rasterizationScale = 100
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}
enum GradiantDirection {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
}


