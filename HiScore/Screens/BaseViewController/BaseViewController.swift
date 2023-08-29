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

class BaseViewController: UIViewController {
    private var locationPopUp = FetchLocationPopUp(frame: UIScreen.main.bounds)
    // MARK: - This one is instance of UIWindow.
    weak var mainWindow: UIWindow? = {
        let window =  UIApplication.shared.windows.first { $0.isKeyWindow }
        return window
        
    }()
    func updateUI() {
        self.view.backgroundColor = .HSAppThemeColor
    }
}
// MARK: - View life cycles
extension BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
// MARK: - Initiate storyboard
extension BaseViewController {
    func storyboard(name: Storyboards) -> UIStoryboard {
        return UIStoryboard(name: name.rawValue, bundle: nil)
    }
}
// MARK: - Methods for snackbar
extension BaseViewController {
    func showSnackbarError(title: String, subtitle: String) {
        showAlert(title: title, subtitle: subtitle, style: .danger, font: UIFont.MavenPro.SemiBold.withSize(18))
    }
    
    func showSnackbarSuccessOnTop(title: String, subtitle: Messages) {
        showAlert(title: title, subtitle: subtitle.description, style: .success, font: UIFont.MavenPro.ExtraBold.withSize(18))
    }
    private func showAlert(title: String, subtitle: String, style: BannerStyle, font: UIFont) {
        let banner = NotificationBanner(title: title, subtitle: subtitle.description, style: style)
        banner.subtitleLabel?.font = font
        banner.subtitleLabel?.textAlignment = .center
        banner.autoDismiss = true
        banner.show()
    }
}

// MARK: - Activity loader methods
extension BaseViewController {
    /// This function is used to show loader and message.
    /// - Parameter message: The message to be displayed.
    func showFetchLocationPopUp() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
            self.locationPopUp.startLoading()
            guard let mainWindow = self.mainWindow else { return }
            mainWindow.addSubview(self.locationPopUp)
            self.locationPopUp.translatesAutoresizingMaskIntoConstraints = false
            let constraints = [
                self.locationPopUp.topAnchor.constraint(equalTo: mainWindow.topAnchor, constant: 0),
                self.locationPopUp.bottomAnchor.constraint(equalTo: mainWindow.bottomAnchor, constant: 0),
                self.locationPopUp.leftAnchor.constraint(equalTo: mainWindow.leftAnchor, constant: 0),
                self.locationPopUp.rightAnchor.constraint(equalTo: mainWindow.rightAnchor, constant: 0)
            ]
            NSLayoutConstraint.activate(constraints)
        }
    }
    /// This function is used to show loader and message.
    func hideFetchLocationPopUp() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            self.locationPopUp.removeFromSuperview()
            self.locationPopUp.stopLoading()
        }
    }
}



//extension BaseViewController {
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
//}
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
