//
//  EnterOTPViewController.swift
//  HiScore
//
//  Created by PC-072 on 10/08/23.
//

import UIKit
import OTPFieldView
import MHLoadingButton

class EnterOTPViewController: BaseViewController {
    
    @IBOutlet weak var labelResend: UILabel!
    @IBOutlet weak var OTPTextField: OTPFieldView!
    
    @IBOutlet weak var buttonVerify: LoadingButton!
    @IBOutlet weak var buttonChangeNumber: LoadingButton!
}
// MARK: - View Life Cycle
extension EnterOTPViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
}
// MARK: - UI Design
extension EnterOTPViewController {
    func initUI() {
        buttonVerify.setUpButtonWithGradientBackground(type: .gradient)
        buttonChangeNumber.setUpButtonWithGradientBackground(type: .dark)
    }
}
// MARK: - Button Actions
extension EnterOTPViewController {
    @IBAction func buttonbackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
