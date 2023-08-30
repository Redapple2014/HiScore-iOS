//
//  HSShadowView.swift
//  HiScore
//
//  Created by RATPC-043 on 25/08/23.
//

import Foundation
import UIKit

typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

protocol GradientOrientationPresentable {
    var startPoint: CGPoint { get }
    var endPoint: CGPoint { get }
    var points: GradientPoints { get }
}

enum GradientOrientation: GradientOrientationPresentable {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical
    case custom
    var startPoint: CGPoint {
        return points.startPoint
    }
    var endPoint: CGPoint {
        return points.endPoint
    }
    var points: GradientPoints {
        switch self {
        case .topRightBottomLeft:
            return (CGPoint(x: 0.0, y: 1.0), CGPoint(x: 1.0, y: 0.0))
        case .topLeftBottomRight:
            return (CGPoint(x: 0.0, y: 0.0), CGPoint(x: 1, y: 1))
        case .horizontal:
            return (CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5))
        case .vertical:
            return (CGPoint(x: 0.0, y: 0.0), CGPoint(x: 0.0, y: 1.0))
        case .custom:
            return (CGPoint(x: 0.25, y: 0.5), CGPoint(x: 0.75, y: 0.5))
        }
    }
}
class HSShadowView: UIView {
    private var colorShade1 = UIColor.white
    private var colorShade2 = UIColor.white
    private var colorShade3 = UIColor.white
    private var colorShade4 = UIColor.white
    private var shadow = UIColor.lightGray
    private var borderColorShade1 = UIColor.lightGray
    private var borderColorShade2 = UIColor.black
    private var width = 0.5
    private var cornerRadius = CGFloat.zero
    private var gradientLayer: CAGradientLayer?
    @IBInspectable dynamic open var color1: UIColor = .white {
        didSet {
            colorShade1 = color1
        }
    }
    @IBInspectable dynamic open var color2: UIColor = .white {
        didSet {
            colorShade2 = color2
        }
    }
    @IBInspectable dynamic open var color3: UIColor = .white {
        didSet {
            colorShade3 = color3
        }
    }
    @IBInspectable dynamic open var color4: UIColor = .white {
        didSet {
            colorShade4 = color4
        }
    }
    @IBInspectable dynamic open var shadowColor: UIColor = .lightGray {
        didSet {
            shadow = shadowColor
        }
    }
    @IBInspectable dynamic open var borderColor1: UIColor = .lightGray {
        didSet {
            borderColorShade1 = borderColor1
        }
    }
    @IBInspectable dynamic open var borderColor2: UIColor = .lightGray {
        didSet {
            borderColorShade2 = borderColor2
        }
    }
    @IBInspectable dynamic open var borderWidth: CGFloat = 0 {
        didSet {
            width = borderWidth
        }
    }
    @IBInspectable dynamic open var radius: CGFloat = 0 {
        didSet {
            cornerRadius = radius
        }
    }
    
    override func draw(_ rect: CGRect) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadow.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.6
        layer.masksToBounds = false
        
        gradientLayer = gradient()
        if let gradientLayer = gradientLayer {
            layer.insertSublayer(gradientLayer, at: 0)
        }
        gradientLayer = setGradientBorder()
        if let gradientLayer = gradientLayer {
            layer.addSublayer(gradientLayer)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradientLayer = gradientLayer {
            gradientLayer.frame = bounds
        } else {
            draw(bounds)
        }
    }
    private func gradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [colorShade1.cgColor, colorShade2.cgColor, colorShade3.cgColor, colorShade4.cgColor]
        gradient.cornerRadius = cornerRadius
        gradient.startPoint = GradientOrientation.topLeftBottomRight.startPoint
        gradient.endPoint = GradientOrientation.topLeftBottomRight.endPoint
        return gradient
    }
    private func setGradientBorder() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.frame.size)
        gradient.colors =  [borderColor1.cgColor,
                            borderColor2.cgColor]
        let shape = CAShapeLayer()
        shape.lineWidth = width
        shape.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        return gradient
    }
}
