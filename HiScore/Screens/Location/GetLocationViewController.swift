//
//  GetLocationViewController.swift
//  HiScore
//
//  Created by RATPC-043 on 14/08/23.
//

import Foundation
import UIKit
import MHLoadingButton

class GetLocationViewController: BaseViewController {
    @IBOutlet weak var buttonShareLocation: LoadingButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonShareLocation.setYellowGradientBackground()
    }
}
