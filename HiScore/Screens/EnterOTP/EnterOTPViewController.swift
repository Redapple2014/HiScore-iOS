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
    // MARK: - IBOutlets
    @IBOutlet weak var viewShowError: UIView!
    @IBOutlet weak var labelResend: UILabel!
    @IBOutlet weak var OTPTextField: OTPFieldView!
    @IBOutlet weak var labelInvalidOTP: UILabel!
    @IBOutlet weak var buttonVerify: LoadingButton!
    @IBOutlet weak var labelDisplayMobileNumber: UILabel!
    @IBOutlet weak var buttonChangeNumber: LoadingButton!

    // MARK: - Variables
    var errorMessage = Messages.invalidOtp.description
    var viewModelGetOtp: OnboardingScreenViewModel!
    var viewModelVerifyOtp: EnterOTPViewModel!
    var counter = 0
    var timer: Timer?
}
// MARK: - View Life Cycle -
extension EnterOTPViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkService = HiScoreNetworkRepository()
        viewModelGetOtp = OnboardingScreenViewModel(networkService: networkService)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        labelResend.addGestureRecognizer(tap)
        initUI()
        initSettings()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        invalidTimer()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonVerify.setNeedsLayout()
        buttonVerify.layoutIfNeeded()
        buttonVerify.setCornerBorder(color: .HSYellowButtonColor,
                                         cornerRadius: 10,
                                         borderWidth: 0.8)
        buttonVerify.setUpButtonWithGradientBackground(type: .yellow)
        buttonChangeNumber.setNeedsLayout()
        buttonChangeNumber.layoutIfNeeded()
        buttonChangeNumber.setCornerBorder(color: .HSYellowButtonColor,
                                         cornerRadius: 10,
                                         borderWidth: 0.8)
        buttonChangeNumber.setUpButtonWithGradientBackground(type: .lightGrey)
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
        self.viewModelVerifyOtp.otp = otpString
    }
}
// MARK: - @objc methods
extension EnterOTPViewController {
    @objc func updateCounter() {
        if counter > -1 {
            if counter == 0 {
                self.labelResend.text = "RESEND OTP"
            } else {
                self.labelResend.text = "RESEND OTP in \(getTimeRemainingText(time: counter))"
            }
            Log.d("\(counter) seconds to enable button")
            labelResend.isUserInteractionEnabled = false
            counter -= 1
        } else {
            timer?.invalidate()
            labelResend.isUserInteractionEnabled = true
        }
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
        resendOTP(phoneNumber: self.viewModelVerifyOtp.phoneNumber)
    }
}
// MARK: - Button Actions
extension EnterOTPViewController {
    @IBAction func buttonVerifyTapped(_ sender: Any) {
        verifyOTP()
    }
    @IBAction func buttonbackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
// MARK: - Private methods -
private extension EnterOTPViewController {
    func invalidTimer() {
        counter = 0
        if timer != nil {
            timer?.invalidate()
        }
    }
    func resendOTP(phoneNumber: String) {
        invalidTimer()
        self.viewModelGetOtp.getOTP(phoneNumber: phoneNumber) { response in
            switch response {
            case .success(let response):
                Log.d(response)
                guard let otpResponse = response.data else { return }
                self.viewModelVerifyOtp.modelOTPResponse = response
                if let err = otpResponse.errorMsg {
                    self.counter = otpResponse.remainingTime ?? 0
                    self.labelResend.isUserInteractionEnabled = (otpResponse.resendAllowed ?? true)
                    self.showSnackbarError(title: "", subtitle: err)
                    self.showOtpTimerAndText()
                } else {
                    self.showSnackbarSuccessOnTop(title: "", subtitle: Messages.otpRecieved)
                }
            case .failure(let error):
                Log.d(error)
                self.showSnackbarError(title: "", subtitle: error.localizedDescription)
            }
        }
    }
    func showOtpTimerAndText() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    func initSettings() {
        guard let otpResponse = viewModelVerifyOtp.modelOTPResponse?.data else { return }
        labelResend.isUserInteractionEnabled = (otpResponse.resendAllowed ?? true)
        if let err = otpResponse.errorMsg {
            counter = otpResponse.remainingTime ?? 0
            self.showSnackbarError(title: "", subtitle: err)
            self.showOtpTimerAndText()
        }
    }
    func initUI() {
        labelDisplayMobileNumber.text = "Enter OTP sent to \(viewModelVerifyOtp.phoneNumber)"
        viewShowError.isHidden = true
        OTPTextField.setupOTPView()
        OTPTextField.delegate = self
    }
    func getTimeRemainingText(time: Int) -> String {
        let hours = time / 3600
        let minutes = (time % 3600) / 60
        let seconds = time % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    func verifyOTP() {
        viewModelVerifyOtp.verifyOTP { response in
            switch response {
            case .success(let response):
                Log.d(response)
                DispatchQueue.main.async {
                    guard let data = response.data else {
                        self.showSnackbarError(title: "", subtitle: Messages.invalidResponse.description)
                        return
                    }
                    if data.status == .invalidOTP {
                        self.showSnackbarError(title: "", subtitle: data.errorMsg ?? Messages.invalidResponse.description)
                        return
                    }
                    guard let viewController = self.storyboard(name: .location)
                            .instantiateViewController(withIdentifier: "GetLocationViewController") as? GetLocationViewController else {
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
}
