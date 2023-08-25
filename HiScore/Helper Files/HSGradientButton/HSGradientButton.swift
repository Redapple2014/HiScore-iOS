//
//  HSGradientButton.swift
//  HiScore
//
//  Created by RATPC-043 on 25/08/23.
//

import Foundation
import UIKit

class HSGradientButton: HSButton {
    private var colorShade1 = UIColor.white
    private var colorShade2 = UIColor.white
    private var colorShade3 = UIColor.white
    private var colorShade4 = UIColor.white
    private var cornerRadius = CGFloat.zero
    private var colorShadow = UIColor.lightGray
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
    @IBInspectable dynamic open var radius: CGFloat = 0 {
        didSet {
            cornerRadius = radius
        }
    }
    @IBInspectable dynamic open var shadowColor: UIColor = .lightGray {
        didSet {
            colorShadow = shadowColor
        }
    }
    override var isHighlighted: Bool {
        didSet {
            guard oldValue != self.isHighlighted else { return }
            UIView.animate(withDuration: 0.15, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                self.alpha = self.isHighlighted ? 0.7 : 1
            }, completion: nil)
        }
    }
    override func setNeedsDisplay() {
        super.setNeedsDisplay()
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.shadowColor = colorShadow.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.64
        layer.masksToBounds = false
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [colorShade1.cgColor, colorShade2.cgColor, colorShade3.cgColor, colorShade4.cgColor]
        gradient.cornerRadius = cornerRadius
        gradient.startPoint = GradientOrientation.horizontal.startPoint
        gradient.endPoint = GradientOrientation.horizontal.endPoint
        layer.insertSublayer(gradient, at: 0)
    }
}
