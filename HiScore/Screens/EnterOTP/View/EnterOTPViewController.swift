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
        buttonVerify.setUpButtonWithGradientBackground(type: .yellow)
        buttonChangeNumber.setUpButtonWithGradientBackground(type: .lightGrey)
        OTPTextField.fieldsCount = 6
        OTPTextField.fieldBorderWidth = 2
        OTPTextField.defaultBorderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        OTPTextField.filledBorderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        OTPTextField.cursorColor = UIColor.white
        OTPTextField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        OTPTextField.displayType = .square
        OTPTextField.fieldSize = 40
        OTPTextField.separatorSpace = 8
        OTPTextField.shouldAllowIntermediateEditing = false
       // otpTextFieldView.delegate = self
        OTPTextField.initializeUI()

    }
}
// MARK: - Button Actions
extension EnterOTPViewController {
    @IBAction func buttonbackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
