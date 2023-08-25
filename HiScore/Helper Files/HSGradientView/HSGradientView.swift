//
//  HSGradientView.swift
//  HiScore
//
//  Created by RATPC-043 on 25/08/23.
//

import UIKit

class HSGradientView: UIView {
    private var colorShade1 = UIColor.white
    private var colorShade2 = UIColor.white
    private var colorShade3 = UIColor.white
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
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        clipsToBounds = true
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [colorShade1.cgColor, colorShade2.cgColor, colorShade3.cgColor]
        gradient.startPoint = GradientOrientation.vertical.startPoint
        gradient.endPoint = GradientOrientation.vertical.endPoint
        layer.insertSublayer(gradient, at: 0)
    }
}
