//
//  RewardPopupViewController.swift
//  HiScore
//
//  Created by PC-072 on 21/08/23.
//

import UIKit
import MHLoadingButton

class RewardPopupViewController: BaseViewController {
    
    @IBOutlet weak var viewKnowMore: UIView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewBetween: UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var circle1: UIView!
    @IBOutlet weak var circle2: UIView!
    @IBOutlet weak var buttonContinue: LoadingButton!
    
}
extension RewardPopupViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        drawStroke()
        createCircleUI()
    }
}

extension RewardPopupViewController {
    @IBAction func buttonContinue(_ sender: Any) {
        
    }

}

extension RewardPopupViewController {
    func initUI() {
        viewTop.setGradientBackground(colorTop: UIColor.init(hex: "272B40"), colorBottom: UIColor.init(hex: "181C31"))
        viewBottom.setGradientBackground(colorTop: UIColor(hex: "393D51"), colorBottom: UIColor.init(hex: "14182A"))
        buttonContinue.setUpButtonWithGradientBackground(type: .yellow)
        designKnowMoreView()

    }
    func designKnowMoreView() {
        viewKnowMore.layer.cornerRadius = 11
        let shadows = UIView()
        shadows.frame = viewKnowMore.frame
        shadows.clipsToBounds = false
        viewKnowMore.addSubview(shadows)
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 11)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 4
        layer0.shadowOffset = CGSize(width: 0, height: 4)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
        let shapes = UIView()
        shapes.frame = viewKnowMore.frame
        shapes.clipsToBounds = true
        viewKnowMore.addSubview(shapes)
        let layer1 = CALayer()
        layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1).cgColor
        layer1.bounds = shapes.bounds
        layer1.position = shapes.center
        shapes.layer.addSublayer(layer1)
        shapes.layer.cornerRadius = 11

    }
    func createCircleUI() {
        circle1.circleUI()
        circle2.circleUI()
    }
    func drawStroke() {
        viewBetween.backgroundColor = .clear
        let stroke = UIView()
        stroke.bounds = viewBetween.bounds.insetBy(dx: -2, dy: -2)
        stroke.center = viewBetween.center
        viewBetween.addSubview(stroke)
        stroke.bounds = viewBetween.bounds.insetBy(dx: -2, dy: -2)
        stroke.layer.borderWidth = 4
        stroke.layer.borderColor = UIColor(red: 0.078, green: 0.094, blue: 0.169, alpha: 1).cgColor
    }
}
