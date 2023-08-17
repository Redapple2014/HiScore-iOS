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
    var counter = 15
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
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        counter = modelOTPResponse.data?.remainingTime ?? 15
             self.viewModelGetOtp.getOTP(phoneNumber: phoneNumber) { response in
              //  self.buttonVerify.hideButtonLoader(vc: self)
                self.showOtpTimerAndText()
                switch response {
                case .success(let response):
                    self.modelOTPResponse = response
                    Log.d(response)
                    self.showSnackbarSuccessOnTop(title: "", subtitle: Messages.otpRecieved)
                case .failure(let error):
                    self.showSnackbarError(title: "", subtitle: error.localizedDescription)
                    Log.d(error)
                }
            }
//        }
    }
}
// MARK: - Private methods -
extension EnterOTPViewController {
    private func showOtpTimerAndText() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    private func initSettings() {
        counter = modelOTPResponse.data?.remainingTime ?? 14
        labelResend.isUserInteractionEnabled = (modelOTPResponse.data?.resendAllowed ?? true) //? true : false
        if let err = modelOTPResponse.data?.errorMsg {
            self.showSnackbarError(title: "", subtitle: err)
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
            self.labelResend.text = "RESEND OTP in 00:\(counter)"
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
        viewModelVerifyOtp.accountDetais = AccountDetails(otp: self.otpEntered ?? "",
                                                          userMobile: self.phoneNumber ?? "",
                                                          referralCode: "",
                                                          uid: UUID().uuidString)
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    
        
        viewModelVerifyOtp.device = Device(abis: UIDevice.current.getCPUName(),
                                           gaid: "",
                                           androidID: "",
                                           appVersion: 1,
                                           cpuABI: "",
                                           deviceType: "iPhone",
                                           manufecturer: "Apple",
                                           model: UIDevice.current.name,
                                           osAPILevel: 0,
                                           ram: 0,
                                           screenDPI: 0,
                                           screenHeight: Int(self.view.frame.size.height),
                                           screenWidth: Int(self.view.frame.size.width))
        
        viewModelVerifyOtp.verifyOTP { response in
              switch response {
              case .success(let response):
                  Log.d(response)
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
