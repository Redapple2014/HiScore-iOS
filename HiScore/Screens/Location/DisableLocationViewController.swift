//
//  DisableLocationViewController.swift
//  HiScore
//
//  Created by RATPC-043 on 14/08/23.
//

import Foundation
import UIKit
import MHLoadingButton
class DisableLocationViewController: BaseViewController {
    @IBOutlet weak var buttonContactUs: LoadingButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonContactUs.setUpButtonWithGradientBackground(type: .yellow)
    }
}
