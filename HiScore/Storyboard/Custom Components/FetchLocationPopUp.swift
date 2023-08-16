//
//  FetchLocationPopUp.swift
//  HiScore
//
//  Created by RATPC-043 on 16/08/23.
//

import Foundation
import UIKit

class FetchLocationPopUp: UIView {
    @IBOutlet weak var loaderImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("FetchLocationPopUp", owner: self, options: nil)
        mainView.frame = frame
        self.addSubview(mainView)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = .clear
        self.mainView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.mainView.alpha = 0
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 24
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layoutIfNeeded()
        containerView.setNeedsLayout()
    }
    func animationPopUp(view: UIWindow) {
        view.addSubview(self)
        self.frame = view.bounds
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.55,
            initialSpringVelocity: 3,
            options: .transitionCrossDissolve,
            animations: {
                self.mainView.transform = .identity
                self.mainView.alpha = 1
            }, completion: nil)
    }
    @objc func closePopUpView(sender: Any) {
        UIView.animate(
            withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
            options: .curveEaseOut, animations: {
                self.mainView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.mainView.alpha = 0
            }, completion: {_ in
                self.removeFromSuperview()
            })
    }
}
