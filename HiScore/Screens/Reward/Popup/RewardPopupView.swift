//
//  RewardPopupView.swift
//  HiScore
//
//  Created by PC-072 on 22/08/23.
//

import UIKit

class RewardPopupView: UIView {
    
    @IBOutlet weak var containerView: UIView!
  
    let nibName = "RewardPopupView"

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
      //  designView()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    func designView() {
        // Auto layout, variables, and unit scale are not yet supported
        var view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 375, height: 622)
        var shadows = UIView()
        shadows.frame = view.frame
        shadows.clipsToBounds = false
        view.addSubview(shadows)

        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 24)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 4
        layer0.shadowOffset = CGSize(width: 0, height: 4)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)

        var shapes = UIView()
        shapes.frame = view.frame
        shapes.clipsToBounds = true
        view.addSubview(shapes)

        let layer1 = CAGradientLayer()
        layer1.colors = [
          UIColor(red: 0.223, green: 0.24, blue: 0.317, alpha: 1).cgColor,
          UIColor(red: 0.078, green: 0.094, blue: 0.165, alpha: 1).cgColor
        ]
        layer1.locations = [0, 1]
        layer1.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer1.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.46, b: 0.68, c: -0.12, d: 0.1, tx: 0.09, ty: -0.05))
        layer1.bounds = shapes.bounds.insetBy(dx: -0.5*shapes.bounds.size.width, dy: -0.5*shapes.bounds.size.height)
        layer1.position = shapes.center
        shapes.layer.addSublayer(layer1)

        let layer2 = CAGradientLayer()
        layer2.colors = [
          UIColor(red: 0.369, green: 0.5, blue: 0.839, alpha: 1).cgColor,
          UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        ]
        layer2.locations = [0, 1]
        layer2.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer2.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer2.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.27, b: 0.48, c: -0.48, d: 0.22, tx: 0.42, ty: -0.11))
        layer2.bounds = shapes.bounds.insetBy(dx: -0.5*shapes.bounds.size.width, dy: -0.5*shapes.bounds.size.height)
        layer2.position = shapes.center
        shapes.layer.addSublayer(layer2)

        shapes.layer.cornerRadius = 24

        var parent = self
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 375).isActive = true
        view.heightAnchor.constraint(equalToConstant: 622).isActive = true
        view.centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 245).isActive = true
    }
    
}
