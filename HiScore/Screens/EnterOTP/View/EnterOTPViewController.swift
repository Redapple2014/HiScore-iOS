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
    @IBOutlet weak var viewShowError: UIView!
    @IBOutlet weak var labelResend: UILabel!
    @IBOutlet weak var OTPTextField: OTPFieldView!
    @IBOutlet weak var labelInvalidOTP: UILabel!
    @IBOutlet weak var buttonVerify: LoadingButton!
    @IBOutlet weak var buttonChangeNumber: LoadingButton!
    
    var errorMessage = Messages.invalidOtp.description
}
// MARK: - View Life Cycle -
extension EnterOTPViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
}
// MARK: - UI Design -
extension EnterOTPViewController {
    func initUI() {
        viewShowError.isHidden = true
        buttonVerify.setUpButtonWithGradientBackground(type: .yellow)
        buttonChangeNumber.setUpButtonWithGradientBackground(type: .lightGrey)
        OTPTextField.fieldsCount = 6
        OTPTextField.fieldBorderWidth = 2
        OTPTextField.defaultBorderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        OTPTextField.filledBorderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        OTPTextField.cursorColor = UIColor.white
        OTPTextField.displayType = .square
        OTPTextField.fieldSize = 42
        OTPTextField.separatorSpace = 10
        OTPTextField.displayType = .roundedCorner
        OTPTextField.fieldFont = UIFont.Rajdhani.Bold.withSize(25)
        OTPTextField.shouldAllowIntermediateEditing = false
        OTPTextField.errorBorderColor = UIColor(red: 0.961, green: 0.302, blue: 0.247, alpha: 0.5)
        OTPTextField.delegate = self
        UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.light
        OTPTextField.initializeUI()
    }
}
// MARK: - OTPFieldView Delegate -
extension EnterOTPViewController: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        return true
    }
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    func enteredOTP(otp otpString: String) {
        print("OTPString: \(otpString)")
    }
}
// MARK: - Button Actions -
extension EnterOTPViewController {
    @IBAction func buttonbackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
