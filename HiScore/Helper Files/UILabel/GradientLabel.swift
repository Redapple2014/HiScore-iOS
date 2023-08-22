//
//  UIlabel+Extension.swift
//  HiScore
//
//  Created by PC-072 on 21/08/23.
//

import Foundation
import UIKit
class GradientLabel: UILabel {
    var gradientColors: [CGColor] = []

    override func drawText(in rect: CGRect) {
        if let gradientColor = drawGradientColor(in: rect, colors: gradientColors) {
            self.textColor = gradientColor
        }
        super.drawText(in: rect)
    }

    private func drawGradientColor(in rect: CGRect, colors: [CGColor]) -> UIColor? {
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.saveGState()
        defer { currentContext?.restoreGState() }

        let size = rect.size
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                        colors: colors as CFArray,
                                        locations: nil) else { return nil }

        let context = UIGraphicsGetCurrentContext()
        context?.drawLinearGradient(gradient,
                                    start: CGPoint.zero,
                                    end: CGPoint(x: size.width, y: 0),
                                    options: [])
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let image = gradientImage else { return nil }
        return UIColor(patternImage: image)
    }
}

//extension UILabel {
//
//    func applyGradientWith(startColor: UIColor, endColor: UIColor) -> Bool {
//
//        var startColorRed:CGFloat = 0
//        var startColorGreen:CGFloat = 0
//        var startColorBlue:CGFloat = 0
//        var startAlpha:CGFloat = 0
//
//        if !startColor.getRed(&startColorRed, green: &startColorGreen, blue: &startColorBlue, alpha: &startAlpha) {
//            return false
//        }
//
//        var endColorRed:CGFloat = 0
//        var endColorGreen:CGFloat = 0
//        var endColorBlue:CGFloat = 0
//        var endAlpha:CGFloat = 0
//
//        if !endColor.getRed(&endColorRed, green: &endColorGreen, blue: &endColorBlue, alpha: &endAlpha) {
//            return false
//        }
//
//        let gradientText = self.text ?? ""
//
//
//
//
//        let name  = NSAttributedString.Key.font//NSFontAttributeName
////        let textSize: CGSize = gradientText.size(attributes: [name:self.font])
////        let width:CGFloat = textSize.width
////        let height:CGFloat = textSize.height
//
//
//
//
//
//
//        let name:String = NSAttributedString.Key.font.rawValue
//        let textSize: CGSize = gradientText.size(withAttributes: <#T##[NSAttributedString.Key : Any]?#>)
//        let width:CGFloat = textSize.width
//        let height:CGFloat = textSize.height
//
//        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
//
//        guard let context = UIGraphicsGetCurrentContext() else {
//            UIGraphicsEndImageContext()
//            return false
//        }
//
//        UIGraphicsPushContext(context)
//
//        let glossGradient:CGGradient?
//        let rgbColorspace:CGColorSpace?
//        let num_locations:size_t = 2
//        let locations:[CGFloat] = [ 0.0, 1.0 ]
//        let components:[CGFloat] = [startColorRed, startColorGreen, startColorBlue, startAlpha, endColorRed, endColorGreen, endColorBlue, endAlpha]
//        rgbColorspace = CGColorSpaceCreateDeviceRGB()
//        glossGradient = CGGradient(colorSpace: rgbColorspace!, colorComponents: components, locations: locations, count: num_locations)
//        let topCenter = CGPoint.zero
//        let bottomCenter = CGPoint(x: 0, y: textSize.height)
//        context.drawLinearGradient(glossGradient!, start: topCenter, end: bottomCenter, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
//
//        UIGraphicsPopContext()
//
//        guard let gradientImage = UIGraphicsGetImageFromCurrentImageContext() else {
//            UIGraphicsEndImageContext()
//            return false
//        }
//
//        UIGraphicsEndImageContext()
//
//        self.textColor = UIColor(patternImage: gradientImage)
//
//        return true
//    }
//
//}
