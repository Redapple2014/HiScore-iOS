//
//  EnterOTPViewController.swift
//  HiScore
//
//  Created by PC-072 on 10/08/23.
//

import UIKit
import OTPFieldView
import MHLoadingButton
//import UIScreenExtension

class EnterOTPViewController: BaseViewController {
    @IBOutlet weak var viewShowError: UIView!
    @IBOutlet weak var labelResend: UILabel!
    @IBOutlet weak var OTPTextField: OTPFieldView!
    @IBOutlet weak var labelInvalidOTP: UILabel!
    @IBOutlet weak var buttonVerify: LoadingButton!
    @IBOutlet weak var labelDisplayMobileNumber: UILabel!
    @IBOutlet weak var buttonChangeNumber: LoadingButton!
    
    var errorMessage = Messages.invalidOtp.description
    var phoneNumber: String?
    var viewModelGetOtp: OnboardingScreenViewModel!
    var viewModelVerifyOtp: EnterOTPViewModel!
    var counter = 0
    var timer: Timer?
    var otpEntered: String?
    var modelOTPResponse: GetOTPResponseModel!
}
// MARK: - View Life Cycle -
extension EnterOTPViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initSettings()
    }
}
// MARK: - UI Design -
extension EnterOTPViewController {
    private func getOTP(phoneNumber: String) {
       // buttonVerify.showButtonLoader(vc: self)
        counter = modelOTPResponse.data?.remainingTime ?? 0
             self.viewModelGetOtp.getOTP(phoneNumber: phoneNumber) { response in
              //  self.buttonVerify.hideButtonLoader(vc: self)
                self.showOtpTimerAndText()
                switch response {
                case .success(let response):
                    self.modelOTPResponse = response
//                    self.vi
                    Log.d(response)
                    self.showSnackbarSuccessOnTop(title: "", subtitle: Messages.otpRecieved)
                case .failure(let error):
                    self.showSnackbarError(title: "", subtitle: error.localizedDescription)
                    Log.d(error)
                }
            }
    }
}
// MARK: - Private methods -
extension EnterOTPViewController {
    private func showOtpTimerAndText() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    private func initSettings() {
        counter = modelOTPResponse.data?.remainingTime ?? 0
        labelResend.isUserInteractionEnabled = (modelOTPResponse.data?.resendAllowed ?? true) //? true : false
        if let err = modelOTPResponse.data?.errorMsg {
            self.showSnackbarError(title: "", subtitle: err)
            self.showOtpTimerAndText()
            self.updateCounter()
        }
        let networkService = HiScoreNetworkRepository()
        viewModelGetOtp = OnboardingScreenViewModel(networkService: networkService)
        viewModelVerifyOtp = EnterOTPViewModel(networkService: networkService)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        labelResend.addGestureRecognizer(tap)
    }
    private func initUI() {
       // buttonVerify.initLoadingButton()
        labelDisplayMobileNumber.text = "Enter OTP sent to \(phoneNumber ?? "")"
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
    private func getTimeRemainingText(time: Int) -> String {
        let hours = time / 3600
        let minutes = (time % 3600) / 60
        let seconds = time % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)

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
        self.otpEntered = otpString
    }
}
// MARK: - Button Actions -
extension EnterOTPViewController {
    @objc func updateCounter() {
        //example functionality
        if counter > -1 {
            self.labelResend.text = "RESEND OTP in \(getTimeRemainingText(time: counter))"
            Log.d("\(counter) seconds to enable button")
            labelResend.isUserInteractionEnabled = false
            counter -= 1
        } else {
            timer?.invalidate()
            labelResend.isUserInteractionEnabled = true
        }
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.view.endEditing(true)
        if let err = modelOTPResponse.data?.errorMsg {
            self.showSnackbarError(title: "", subtitle: err)
            return
        }
        getOTP(phoneNumber: self.phoneNumber ?? "")
    }

    @IBAction func buttonVerifyTapped(_ sender: Any) {
        if ((self.otpEntered?.isEmpty) == nil) {
            self.showSnackbarError(title: "", subtitle: Messages.invalidOtp.description)
            return
        }

        guard let otp = self.otpEntered,
              let numberEntered = self.phoneNumber,
              let uniqId =  self.modelOTPResponse.data?.uid else { return }
        
        viewModelVerifyOtp.verifyOTP(otpEntered: otp, phoneNumber: numberEntered, uid: uniqId) { response in
              switch response {
              case .success(let response):
                  Log.d(response)
                  DispatchQueue.main.async {
                      guard let viewController = self.storyboard(name: .location).instantiateViewController(withIdentifier: "GetLocationViewController") as? GetLocationViewController else {
                          return
                      }
                      self.navigationController?.pushViewController(viewController, animated: true)
                      
                  }
              case .failure(let error):
                  self.showSnackbarError(title: "", subtitle: error.localizedDescription)
                  Log.d(error)
              }
          }
    }

    @IBAction func buttonbackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
