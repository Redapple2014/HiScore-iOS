//
//  UIView+Extension.swift
//  HiScore
//
//  Created by PC-072 on 09/08/23.
//

import Foundation
import UIKit
import Kingfisher

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
    func applyShadow(
        opacity: Float = 0.5,
        radius: CGFloat = 4,
        offset: CGSize = CGSize(width: 0, height: 2),
        color: UIColor = .black) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        shadowLayer.fillColor = UIColor.yellow.cgColor
        shadowLayer.shadowColor = UIColor.red.withAlphaComponent(0.5).cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 4)
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 4
        layer.insertSublayer(shadowLayer, at: 0)
    }
    func setGradiantColor(
        topColor: UIColor,
        bottomColor: UIColor,
        cornerRadius: CGFloat = 0.0,
        gradiantDirection: GradiantDirection = .topToBottom) {
        self.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
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

extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
}

enum VerticalLocation: String {
    case bottom
    case top
}

extension UIView {
    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 1.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -1), color: color, opacity: opacity, radius: radius)
        }
    }
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
