//
//  BaseViewController.swift
//  HiScore
//
//  Created by PC-072 on 09/08/23.
//

import UIKit
import Skeleton
import NotificationBannerSwift
import OTPFieldView




enum Storyboards: String {
    case main = "Main"
    case splash = "Splash"
    case wallet = "Wallet"
}
class BaseViewController: UIViewController {

//    private let snackVw = SnackerView()
    

}
extension BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
extension BaseViewController {
    func storyboard(name: Storyboards) -> UIStoryboard {
        return UIStoryboard(name: name.rawValue, bundle: nil)
    }
    func updateUI() {
    }
    
    func setupOtpView(otpTextFieldView: OTPFieldView){
            otpTextFieldView.fieldsCount = 5
            otpTextFieldView.fieldBorderWidth = 2
            otpTextFieldView.defaultBorderColor = UIColor.black
            otpTextFieldView.filledBorderColor = UIColor.green
            otpTextFieldView.cursorColor = UIColor.red
            otpTextFieldView.displayType = .square
            otpTextFieldView.fieldSize = 40
            otpTextFieldView.separatorSpace = 8
            otpTextFieldView.shouldAllowIntermediateEditing = false
           // otpTextFieldView.delegate = self
            otpTextFieldView.initializeUI()
        }

}
extension BaseViewController {
    func showSnackbarError(title: String, subtitle: String) {
        showAlert(title: title, subtitle: subtitle, style: .danger, font: UIFont.MavenPro.SemiBold.withSize(18))
    }
    
    func showSnackbarSuccessOnTop(title: String, subtitle: String) {
        showAlert(title: title, subtitle: subtitle, style: .success, font: UIFont.MavenPro.ExtraBold.withSize(18))
    }
    private func showAlert(title: String, subtitle: String, style: BannerStyle, font: UIFont) {
        let banner = NotificationBanner(title: title, subtitle: subtitle, style: style)
        banner.subtitleLabel?.font = font
        banner.subtitleLabel?.textAlignment = .center
        banner.autoDismiss = true
        banner.show()
    }
}
extension BaseViewController {
//     func placeHolderTextField(textField: TKFormTextField) {
//        // UITextField traditional properties
//        textField.placeholder = "Enter phone number"
//        textField.enablesReturnKeyAutomatically = true
//        textField.returnKeyType = .next
//        textField.clearButtonMode = .whileEditing
//        textField.placeholderFont = UIFont.MavenPro.SemiBold.withSize(18)//systemFont(ofSize: 18)
//        textField.font = UIFont.MavenPro.SemiBold.withSize(18)
//
//        // TKFormTextField properties: floating placeholder title
//        textField.titleLabel.font = UIFont.systemFont(ofSize: 18)
//        textField.titleColor = UIColor.lightGray
//        textField.selectedTitleColor = UIColor.gray
//
//        // TKFormTextField properties: underline
//        textField.lineColor = UIColor.gray
//        textField.selectedLineColor = UIColor.black
//        
//        // TKFormTextField properties: bottom error label
//        textField.errorLabel.font = UIFont.systemFont(ofSize: 18)
//        textField.errorColor = UIColor.red // this color is also used for the underline on error state
//
//        // TKFormTextField properties: update error message
//        // NOTE: Ideally you should show error on .editingDidEnd, and attempt to hide it on .editingChanged.
//        // See the demo project on how I design the validation flow.
//     //   textField.addTarget(self, action: #selector(updateError), for: .editingChanged)
//
//    }
}
//extension BaseViewController: GradientsOwner {
//    var gradientLayers: [CAGradientLayer] {
//        let grad = gradView.map({$0.gradientLayer})
//      return grad
//    }
//    func showSkeleton() {
//        DispatchQueue.main.async {
//            self.viewSkeleton.isHidden = false
//            _ = self.viewSkeleton.map({$0.layer.cornerRadius = 20})
//            _ = self.viewSkeleton.map({ $0.addShadow(offset: .init(width: 1, height: 1),
//                                                 color: UIColor.black.withAlphaComponent(0.2)) })
//            let baseColor = UIColor.gray.withAlphaComponent(0.3)
//            _ = self.gradView.map({$0.gradientLayer.colors = [baseColor.cgColor,
//                                                             baseColor.withAlphaComponent(0.4).cgColor,
//                                                             baseColor.cgColor]})
//            _ = self.gradView.map({$0.gradientLayer.slide(to: .right)})
//        }
//    }
//    func stopSkeleton() {
//        viewSkeleton.isHidden = true
//    }
//
//
//}
