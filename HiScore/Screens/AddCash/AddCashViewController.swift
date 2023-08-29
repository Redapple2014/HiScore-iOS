//
//  AddCashViewController.swift
//  HiScore
//
//  Created by PC-072 on 28/08/23.
//

import UIKit
import MHLoadingButton
import IQKeyboardManager

class AddCashViewController: BaseViewController {

    @IBOutlet weak var labelUptoCash: UILabel!
    @IBOutlet weak var labelOfferTotal: UILabel!
    @IBOutlet weak var collectionOfCashOffers: UICollectionView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var enterAmountTextField: UITextField!
    @IBOutlet weak var buttonContinue: LoadingButton!
    @IBOutlet weak var viewTextField: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initSettings()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonContinue.setNeedsLayout()
        buttonContinue.layoutIfNeeded()
        buttonContinue.setCornerBorder(color: .HSYellowButtonColor,
                                         cornerRadius: 10,
                                         borderWidth: 0.8)
        buttonContinue.setUpButtonWithGradientBackground(type: .yellow)
    }
}

extension AddCashViewController {
    func initSettings() {
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        IQKeyboardManager.shared().isEnabled = false
        UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.light
        enterAmountTextField.addTarget(self, action: #selector(editingText(_:)), for: .editingChanged)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
    }
    func initUI() {
        buttonContinue.initLoadingButton()
        viewTextField.layer.borderColor = UIColor.HSWhiteColor.withAlphaComponent(0.75).cgColor
        viewTextField.layer.cornerRadius = 8
        viewTextField.layer.borderWidth = 1.0
        viewTextField.backgroundColor = UIColor.HSWhiteColor.withAlphaComponent(0.1)
        enterAmountTextField.clearButtonMode = .never
        enterAmountTextField.textColor = UIColor.HSWhiteColor
        enterAmountTextField.font = UIFont.Rajdhani.Bold.withSize(18)
        enterAmountTextField.tintColor = .HSWhiteColor
        clearButton.isHidden = true
        view.setNeedsLayout()
    }

}
extension AddCashViewController {
    @IBAction func clearButtonTapped(_ sender: Any) {
        self.enterAmountTextField.text = ""
        self.view.endEditing(true)
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
         self.view.endEditing(true)
    }
}
// MARK: - UITextFieldDelegate -
extension AddCashViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 10
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.layoutIfNeeded()
        
    }
    @objc func editingText(_ textField: UITextField) {
        if (textField.text?.count ?? 0) == 0 {
            clearButton.isHidden = true
        } else if ((textField.text?.count ?? 0) > 0 ) && ((textField.text?.count ?? 0) < 10 ){
            clearButton.isHidden = false
        } else if ((textField.text?.count ?? 0) == 10 ) { }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        clearButton.isHidden = true
        if (textField.text?.count ?? 0) == 0 {

        } else if ((textField.text?.count ?? 0) > 0 ) && ((textField.text?.count ?? 0) < 10 ){
            clearButton.isHidden = false
        } else if ((textField.text?.count ?? 0) == 10 ) { }
    }
}
