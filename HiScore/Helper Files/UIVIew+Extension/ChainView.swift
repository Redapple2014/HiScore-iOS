//
//  HoleUIView.swift
//  HiScore
//
//  Created by PC-072 on 21/08/23.
//

import Foundation

import UIKit

class ChainView: UIView {
    let holeCount = 5
    let holeSpacing: CGFloat = 10.0
    let holeRadius: CGFloat = 20.0

    override func draw(_ rect: CGRect) {
        // Get the current graphics context
        let context = UIGraphicsGetCurrentContext()

        // Set a clear background
        backgroundColor?.setFill()
        context?.fill(rect)

        // Calculate the starting x-coordinate for the first hole
        var xPosition: CGFloat = holeSpacing

        for _ in 0..<holeCount {
            // Calculate the hole's CGRect
            let holeRect = CGRect(x: xPosition - holeRadius, y: rect.midY - holeRadius, width: holeRadius * 2, height: holeRadius * 2)

            // Create the path for the hole
            let holePath = UIBezierPath(ovalIn: holeRect)
            holePath.append(UIBezierPath(rect: rect))

            // Set the blend mode to clear so the hole area becomes transparent
            context?.setBlendMode(.clear)

            // Fill the hole area with the clear blend mode
            UIColor.clear.setFill()
            holePath.fill()

            // Move the x-coordinate for the next hole
            xPosition += holeSpacing + holeRadius * 2
        }
    }
}
