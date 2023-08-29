//
//  WalletViewController.swift
//  HiScore
//
//  Created by PC-072 on 28/08/23.
//

import UIKit
import MHLoadingButton

class WalletViewController: BaseViewController {
    @IBOutlet weak var buttonAddCash: LoadingButton!
    @IBOutlet weak var buttonWithdraw: LoadingButton!
    override func updateUI() {
        super.updateUI()
    }
}
//MARK: - View Life Cycle -
extension WalletViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidLayoutSubviews() {
        buttonAddCash.layoutIfNeeded()
        buttonAddCash.setNeedsLayout()
        buttonWithdraw.layoutIfNeeded()
        buttonWithdraw.setNeedsLayout()
        buttonAddCash.setUpButtonWithGradientBackground(type: .yellow)
        buttonWithdraw.setUpButtonWithGradientBackground(type: .yellow)
       
        self.buttonAddCash.clipsToBounds = true
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.buttonAddCash.frame.size)
        gradient.colors =  [UIColor.HSYellowButtonColor.cgColor,
                            UIColor.HSGoldenYellowTextColor.cgColor]

        let shape = CAShapeLayer()
        shape.lineWidth = 4

        shape.path = UIBezierPath(roundedRect: self.buttonAddCash.bounds, cornerRadius: 10).cgPath

        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape

        self.buttonAddCash.layer.addSublayer(gradient)
        
        buttonWithdraw.setCornerBorder(color: .HSYellowButtonColor,
                                           cornerRadius: 10,
                                           borderWidth: 1)
    }
}
//MARK: - Button actions -
extension WalletViewController {
    @IBAction func addCash(_ sender: Any) {
//        guard let viewController = self.storyboard(name: .addCash).instantiateViewController(withIdentifier: "AddCashViewController") as? AddCashViewController else {
//            return
//        }
//        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

