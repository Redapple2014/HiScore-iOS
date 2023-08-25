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
    @IBOutlet weak var labelHeaderTitle: UILabel!
    @IBOutlet weak var labelDescriptionTitle: UILabel!
    @IBOutlet weak var labelDescriptionText: UILabel!
   
    var viewModel = DisableLocationViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonContactUs.addTarget(self, action: #selector(buttonContactUsDidTap), for: .touchUpInside)
        guard let error = viewModel.errorText else { return }
        labelHeaderTitle.text = error.headerTitle
        labelDescriptionTitle.text = error.headerTitle
        labelDescriptionText.text = error.headerTitle
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonContactUs.setNeedsLayout()
        buttonContactUs.layoutIfNeeded()
        buttonContactUs.setCornerBorder(color: .HSYellowButtonColor,
                                         cornerRadius: 10,
                                         borderWidth: 0.8)
        buttonContactUs.setUpButtonWithGradientBackground(type: .yellow)
    }
    @objc func buttonContactUsDidTap() { }
}
