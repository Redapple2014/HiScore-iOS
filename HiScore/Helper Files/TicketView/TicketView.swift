//
//  TicketView.swift
//  TicketShapeView
//
//  Created by Ko Kyaw on 31/05/2021.
//

import UIKit

extension UIView {
     func drawTicket() {
        let ticketShapeLayer = CAShapeLayer()
        ticketShapeLayer.frame = self.bounds
        ticketShapeLayer.fillColor = UIColor.white.cgColor

        let ticketShapePath = UIBezierPath(roundedRect: ticketShapeLayer.bounds, cornerRadius: 18)

        let topLeftArcPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 10),
                                          radius: 36 / 2,
                                          startAngle:  CGFloat(Double.pi / 2),
                                          endAngle: CGFloat(Double.pi + Double.pi / 2),
                                          clockwise: false)
        topLeftArcPath.close()
        
        let topRightArcPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 40),
                                          radius: 36 / 2,
                                          startAngle:  CGFloat(Double.pi / 2),
                                          endAngle: CGFloat(Double.pi + Double.pi / 2),
                                          clockwise: true)
        topRightArcPath.close()
        
        let bottomLeftArcPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 60),
                                          radius: 36 / 2,
                                          startAngle:  CGFloat(Double.pi / 2),
                                          endAngle: CGFloat(Double.pi + Double.pi / 2),
                                          clockwise: false)
        bottomLeftArcPath.close()
        
        let bottomRightArcPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 80),
                                          radius: 36 / 2,
                                          startAngle:  CGFloat(Double.pi / 2),
                                          endAngle: CGFloat(Double.pi + Double.pi / 2),
                                          clockwise: true)
        bottomRightArcPath.close()
        
        ticketShapePath.append(topLeftArcPath)
        ticketShapePath.append(topRightArcPath.reversing())
        ticketShapePath.append(bottomLeftArcPath)
        ticketShapePath.append(bottomRightArcPath.reversing())

        ticketShapeLayer.path = ticketShapePath.cgPath
        
        layer.addSublayer(ticketShapeLayer)
        
        // Add elevation
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 10
        layer.shadowOffset = .zero
    }

}
