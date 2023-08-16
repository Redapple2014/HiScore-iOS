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
        
    }
}
