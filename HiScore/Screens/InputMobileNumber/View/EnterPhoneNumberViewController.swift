//
//  EnterPhoneNumberViewController.swift
//  HiScore
//
//  Created by PC-072 on 10/08/23.
//

import UIKit
import DTTextField
import MHLoadingButton
import IQKeyboardManager

class EnterPhoneNumberViewController: BaseViewController {
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var bottomConstraintOfLoginView: NSLayoutConstraint!
    @IBOutlet weak var topConstraintOfLoginView: NSLayoutConstraint!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var buttonGetStarted: LoadingButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewCollectionPagination: UIView!

    let placeHolderText = "Enter Phone number"
    let errorMessage = "Invalid Phone Number"
    
}
extension EnterPhoneNumberViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initSettings()
        hideInPutError()
    }
}
extension EnterPhoneNumberViewController {
    private func showInPutError() {
        errorLabel.isHidden = false
        errorLabel.text = errorMessage
        errorImage.isHidden = false
    }
    private func hideInPutError() {
        errorLabel.isHidden = true
        errorImage.isHidden = true
        errorLabel.text = ""
    }

    private func initSettings() {
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        IQKeyboardManager.shared().isEnabled = false
        UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.light
        inputTextField.addTarget(self, action: #selector(editingText(_:)), for: .valueChanged)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)

    }
    private func initUI() {
        placeholderLabel.text = ""
        viewContainer.backgroundColor = .black.withAlphaComponent(20)
        inputTextField.textColor = UIColor.HSPlaceHolderColor
        inputTextField.font = UIFont.Rajdhani.Bold.withSize(18)
        viewContainer.layer.cornerRadius = 5
        viewContainer.layer.borderColor = UIColor.HSTextFieldBorderColor.cgColor
        viewContainer.layer.borderWidth = 2.0
        viewContainer.backgroundColor = UIColor.HSTextFieldColor
       
        buttonGetStarted.setTitleColor(.HSGradientButtonTextColor, for: .normal)
        buttonGetStarted.titleLabel?.font = UIFont.MavenPro.Bold.withSize(14)
        buttonGetStarted.clipsToBounds = true
        buttonGetStarted.layer.cornerRadius = 10
        buttonGetStarted.setGradientBackground()
    }

}
extension EnterPhoneNumberViewController {
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
//        topConstraintOfPaginationView.constant = 0
        self.view.endEditing(true)
    }

}
extension EnterPhoneNumberViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        placeholderLabel.text = placeHolderText
        viewCollectionPagination.layoutIfNeeded()
        self.view.layoutIfNeeded()
        UIView.transition(with: viewCollectionPagination, duration: 2.4,
                          options: .transitionCurlUp,
                          animations: {
            self.topConstraintOfLoginView.constant = 500
            self.topConstraintOfLoginView.constant = 350

                      })

    }
    @objc func editingText(_ textField: UITextField) {
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.transition(with: viewCollectionPagination, duration: 2.4,
                          options: .transitionCurlUp,
                          animations: {
            self.topConstraintOfLoginView.constant = 0
            self.topConstraintOfLoginView.constant = 0
                      })
        if (textField.text?.count ?? 0) == 0 {
            placeholderLabel.text = ""
            hideInPutError()
        } else if ((textField.text?.count ?? 0) > 0 ) && ((textField.text?.count ?? 0) < 10 ){
            showInPutError()
        } else if ((textField.text?.count ?? 0) == 10 ) {
            hideInPutError()
        }
    }
}
