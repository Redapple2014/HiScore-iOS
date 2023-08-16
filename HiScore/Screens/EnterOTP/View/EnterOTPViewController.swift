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
        OTPTextField.defaultBorderColor = .HSTextFieldBorderColor
        OTPTextField.filledBorderColor = .HSTextFieldBorderColor
        OTPTextField.cursorColor = UIColor.white
        OTPTextField.displayType = .square
        OTPTextField.fieldSize = 42
        OTPTextField.separatorSpace = 10
        OTPTextField.displayType = .roundedCorner
        OTPTextField.fieldFont = UIFont.Rajdhani.Bold.withSize(25)
        OTPTextField.shouldAllowIntermediateEditing = false
        OTPTextField.errorBorderColor = .HSRedColor
        OTPTextField.delegate = self
        UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.light
        OTPTextField.initializeUI()
    }
}
// MARK: - OTPFieldView Delegate -
extension EnterOTPViewController: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        Log.d("Has entered all OTP? \(hasEntered)")
        return true
    }
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    func enteredOTP(otp otpString: String) {
        Log.d("OTPString: \(otpString)")
    }
}
// MARK: - Button Actions -
extension EnterOTPViewController {
    @IBAction func buttonbackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
