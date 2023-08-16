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
    @IBOutlet weak var collectionSlides: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    private let placeHolderText = "Enter Phone number"
    private let errorMessage = "Invalid Phone Number"
    private var viewModel: OnboardingScreenViewModel!
}
// MARK: - View Life Cycle ------------
extension EnterPhoneNumberViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initSettings()
        hideInPutError()
        let networkService = HiScoreNetworkRepository()
        viewModel = OnboardingScreenViewModel(networkService: networkService)
        getOnBoadingScreens()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Remove keyboard observers
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
// MARK: - Keyboard animations ------------
extension EnterPhoneNumberViewController {
    @objc func keyboardWillShow(_ notification: Notification) {
        animateView(upward: true)
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        animateView(upward: false)
    }
    private func animateView(upward: Bool) {
        UIView.animate(withDuration: 0.3) {
            if upward {
                // Move the view upward and fade it out
                self.viewCollectionPagination.transform = CGAffineTransform(translationX: 0, y: -self.viewCollectionPagination.frame.height)
                self.viewCollectionPagination.alpha = 0.0
                self.bottomConstraintOfLoginView.constant = 350
            } else {
                // Reset the view's position and fade it in
                self.viewCollectionPagination.transform = .identity
                self.viewCollectionPagination.alpha = 1.0
                self.bottomConstraintOfLoginView.constant = 20
            }
        }
    }

}
// MARK: - API Calls ------------
extension EnterPhoneNumberViewController{
    private func getOTP(phoneNumber: String) {
        buttonGetStarted.showButtonLoader(vc: self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.getOTP(phoneNumber: phoneNumber) { response in
                self.buttonGetStarted.hideButtonLoader(vc: self)
                switch response {
                case .success(let response):
                    guard let viewController = self.storyboard(name: .main).instantiateViewController(withIdentifier: "EnterOTPViewController") as? EnterOTPViewController else {
                        return
                    }
                    self.navigationController?.pushViewController(viewController, animated: true)

                    Log.d(response)
                case .failure(let error):
                    self.showSnackbarError(title: "", subtitle: error.localizedDescription)
                    Log.d(error)
                }
            }
        }
    }
    private func getOnBoadingScreens() {
            self.viewModel.getOnBoadingScreens { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.collectionSlides.reloadData()
                        self?.pageControl.numberOfPages = self?.viewModel.slides.count ?? 0
                        print(data)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
}
// MARK: - CollectionView UICollectionViewDataSource ------------
extension EnterPhoneNumberViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SlidesCollectionViewCell else { return SlidesCollectionViewCell() }
        cell.images = self.viewModel.slides[indexPath.row]
        return cell
    }
}
// MARK: - CollectionView UICollectionViewDelegateFlowLayout ------------
extension EnterPhoneNumberViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}
// MARK: - Private methods ------------
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
    private func hideViewWithAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            // Move the view upward and fade it out
            self.viewCollectionPagination.transform = CGAffineTransform(translationX: 0, y: -350)
            self.viewCollectionPagination.alpha = 0.0
        }) { (_) in
            // Once animation is completed, hide the view
            self.viewCollectionPagination.isHidden = true
        }
    }
    private func unhideViewWithAnimation() {
        // Reset the view's properties
        self.viewCollectionPagination.transform = .identity
        self.viewCollectionPagination.alpha = 0.0
        self.viewCollectionPagination.isHidden = false
        
        UIView.animate(withDuration: 0.3, animations: {
            // Move the view back to its original position and fade it in
            self.viewCollectionPagination.alpha = 1.0
        })
    }

    private func initSettings() {
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        IQKeyboardManager.shared().isEnabled = false
        UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.light
        inputTextField.addTarget(self, action: #selector(editingText(_:)), for: .editingChanged)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        collectionSlides.dataSource = self
        collectionSlides.delegate = self
     }
    private func initUI() {
        collectionSlides.isPagingEnabled = true
        placeholderLabel.text = ""
        viewContainer.backgroundColor = .black.withAlphaComponent(20)
        inputTextField.textColor = UIColor.HSPlaceHolderColor
        inputTextField.font = UIFont.Rajdhani.Bold.withSize(18)
        viewContainer.layer.cornerRadius = 5
        viewContainer.layer.borderColor = UIColor.HSTextFieldBorderColor.cgColor
        viewContainer.layer.borderWidth = 2.0
        viewContainer.backgroundColor = UIColor.HSTextFieldColor
        buttonGetStarted.initLoadingButton()
        buttonGetStarted.setUpButtonWithGradientBackground(type: .yellow)
        inputTextField.clearButtonMode = .whileEditing
    }

}
// MARK: - UIScrollViewDelegate ------------
extension EnterPhoneNumberViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let xPoint = scrollView.contentOffset.x + scrollView.frame.width / 2
        let yPoint = scrollView.frame.height / 2
        let center = CGPoint(x: xPoint, y: yPoint)
        if let ip = collectionSlides.indexPathForItem(at: center) {
            self.pageControl.currentPage = ip.row
        }
    }
}
// MARK: - Buttons tap ------------
extension EnterPhoneNumberViewController {
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.view.endEditing(true)
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        if !self.viewModel.validate(value: inputTextField.text!) {
            showInPutError()
            return
        }
        guard let phoneNumber = inputTextField.text else { return }
        getOTP(phoneNumber: phoneNumber)
    }

}
// MARK: - UITextFieldDelegate ------------
extension EnterPhoneNumberViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 10
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        placeholderLabel.text = placeHolderText
        viewCollectionPagination.layoutIfNeeded()
        self.view.layoutIfNeeded()
    }
    @objc func editingText(_ textField: UITextField) {
        if (textField.text?.count ?? 0) == 0 {
            placeholderLabel.text = ""
            hideInPutError()
        } else if ((textField.text?.count ?? 0) > 0 ) && ((textField.text?.count ?? 0) < 10 ){
            showInPutError()
        } else if ((textField.text?.count ?? 0) == 10 ) {
            hideInPutError()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
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
