//
//  FetchLocationPopUp.swift
//  HiScore
//
//  Created by RATPC-043 on 16/08/23.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class FetchLocationPopUp: UIView {
    @IBOutlet weak var loaderImage: NVActivityIndicatorView!
    @IBOutlet weak var containerView: HSShadowView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var backGroundView: UIView!
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
        backGroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    override func layoutSubviews() {
    }
    func startLoading() {
        loaderImage.startAnimating()
    }
    func stopLoading() {
        loaderImage.stopAnimating()
    }
}
