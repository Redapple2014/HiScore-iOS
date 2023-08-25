//
//  HSButton.swift
//  HiScore
//
//  Created by RATPC-043 on 25/08/23.
//

import Foundation
import UIKit
import MHLoadingButton

class HSButton: UIButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        isExclusiveTouch = true
    }
}
