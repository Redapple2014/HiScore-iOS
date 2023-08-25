//
//  HoleUIView.swift
//  HiScore
//
//  Created by PC-072 on 21/08/23.
//

import Foundation

import UIKit

class DashedLineView: UIView {
   override func draw(_ rect: CGRect) {
       let path = UIBezierPath()
       path.move(to: CGPoint(x: rect.minX, y: rect.midY))
       path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))

       let dashedLayer = CAShapeLayer()
       dashedLayer.strokeColor = UIColor.black.cgColor//UIColor.black.cgColor
       dashedLayer.lineWidth = 5
       dashedLayer.cornerRadius = 5
       dashedLayer.lineCap = .round
       dashedLayer.lineDashPattern = [5,10]
       dashedLayer.path = path.cgPath
       self.layer.addSublayer(dashedLayer)
   }
}
