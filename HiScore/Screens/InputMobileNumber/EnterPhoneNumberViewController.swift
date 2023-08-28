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
    //MARK: - IBOutlets -
    @IBOutlet weak var inputTextField: UITextField!{
        didSet {
            let redPlaceholderText = NSAttributedString(string: PlaceholderMessages.phoneNumber.desscription,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.HSWhiteColor.withAlphaComponent(0.3),
                                                                     NSAttributedString.Key.font: UIFont.MavenPro.ExtraBold.withSize(16)])
            inputTextField.attributedPlaceholder = redPlaceholderText
        }
    }
    
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var heightConstraintLoginView: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintErrorView: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintPlaceholderText: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraintOfLoginView: NSLayoutConstraint!
    @IBOutlet weak var topConstraintOfButton: NSLayoutConstraint!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var buttonGetStarted: LoadingButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewCollectionPagination: UIView!
    @IBOutlet weak var collectionSlides: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var clearButton: UIButton!
    private var hasApiCalled = false
    //MARK: - Instance of viewModel -
    private var viewModel: OnboardingScreenViewModel!
}
// MARK: - View Life Cycle -
extension EnterPhoneNumberViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initSettings()
        let networkService = HiScoreNetworkRepository()
        viewModel = OnboardingScreenViewModel(networkService: networkService)
        getOnBoadingScreens()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hasApiCalled = false
        if inputTextField.text?.count ?? 0 > 0 {
            inputTextField.becomeFirstResponder()
            clearButton.isHidden = false
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonGetStarted.setNeedsLayout()
        buttonGetStarted.layoutIfNeeded()
        buttonGetStarted.setCornerBorder(color: .HSYellowButtonColor,
                                         cornerRadius: 10,
                                         borderWidth: 0.8)
        buttonGetStarted.setUpButtonWithGradientBackground(type: .yellow)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Remove keyboard observers
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - Private methods -
private extension EnterPhoneNumberViewController {
    func initSettings() {
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        IQKeyboardManager.shared().isEnabled = false
        UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.light
        inputTextField.addTarget(self, action: #selector(editingText(_:)), for: .editingChanged)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        collectionSlides.dataSource = self
        collectionSlides.delegate = self
    }
    func initUI() {
        collectionSlides.isPagingEnabled = true
        buttonGetStarted.initLoadingButton()
        
        heightConstraintPlaceholderText.constant = 0
        placeholderLabel.font = UIFont.MavenPro.SemiBold.withSize(10)
        placeholderLabel.text = PlaceholderMessages.phoneNumber.desscription
        placeholderLabel.textColor = UIColor.HSWhiteColor.withAlphaComponent(0.3)
        
        viewContainer.layer.cornerRadius = 8
        viewContainer.layer.borderWidth = 1.0
        viewContainer.backgroundColor = UIColor.HSWhiteColor.withAlphaComponent(0.1)
        
        inputTextField.clearButtonMode = .never
        inputTextField.textColor = UIColor.HSWhiteColor
        inputTextField.font = UIFont.Rajdhani.Bold.withSize(18)
        inputTextField.tintColor = .HSWhiteColor
        hideInPutError()
        clearButton.isHidden = true
        view.setNeedsLayout()
    }
    func showInPutError() {
        heightConstraintErrorView.constant = 12
        heightConstraintLoginView.constant = 218
        textfieldStateChange(to: .error)
        view.setNeedsLayout()
    }
    func hideInPutError() {
        heightConstraintErrorView.constant = 0
        heightConstraintLoginView.constant = 206
        inputTextField.text?.count ?? 0 > 0 ? textfieldStateChange(to: .active) : textfieldStateChange(to: .inactive)
        
        view.setNeedsLayout()
    }
    func hideViewWithAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            // Move the view upward and fade it out
            self.viewCollectionPagination.transform = CGAffineTransform(translationX: 0, y: -350)
            self.viewCollectionPagination.alpha = 0.0
        }) { (_) in
            // Once animation is completed, hide the view
            self.viewCollectionPagination.isHidden = true
        }
    }
    func unhideViewWithAnimation() {
        // Reset the view's properties
        self.viewCollectionPagination.transform = .identity
        self.viewCollectionPagination.alpha = 0.0
        self.viewCollectionPagination.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            // Move the view back to its original position and fade it in
            self.viewCollectionPagination.alpha = 1.0
        })
    }
    func textfieldStateChange(to state: StateOfTextfield){
        switch state {
        case .inactive:
            viewContainer.layer.borderColor = UIColor.HSWhiteColor.withAlphaComponent(0.2).cgColor
        case .active:
            viewContainer.layer.borderColor = UIColor.HSWhiteColor.withAlphaComponent(0.75).cgColor
        case .error:
            viewContainer.layer.borderColor = UIColor.HSRedColor.withAlphaComponent(0.5).cgColor
        }
    }
}
// MARK: - Keyboard animations -
extension EnterPhoneNumberViewController {
    @objc func keyboardWillShow(_ notification: Notification) {
        animateView(upward: true)
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        if !hasApiCalled  {
            animateView(upward: false)
        }
    }
    private func animateView(upward: Bool) {
        UIView.animate(withDuration: 0.3) {
            if upward {
                // Move the view upward and fade it out
                self.viewCollectionPagination.transform = CGAffineTransform(translationX: 0, y: -self.viewCollectionPagination.frame.height)
                self.viewCollectionPagination.alpha = 0.0
                self.bottomConstraintOfLoginView.constant = 400
            } else {
                // Reset the view's position and fade it in
                self.viewCollectionPagination.transform = .identity
                self.viewCollectionPagination.alpha = 1.0
                self.bottomConstraintOfLoginView.constant = 20
            }
        }
    }
}
// MARK: - API Calls -
private extension EnterPhoneNumberViewController{
    func getOTP(phoneNumber: String) {
        hasApiCalled = true
        buttonGetStarted.showButtonLoader(vc: self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.getOTP(phoneNumber: phoneNumber) { response in
                self.buttonGetStarted.hideButtonLoader(vc: self)
                self.hasApiCalled = false
                switch response {
                case .success(let response):
                    Log.d(response)
                    guard let viewController = self.storyboard(name: .main).instantiateViewController(withIdentifier: "EnterOTPViewController") as? EnterOTPViewController else {
                        return
                    }
                    viewController.viewModelVerifyOtp = EnterOTPViewModel(networkService: HiScoreNetworkRepository())
                    viewController.viewModelVerifyOtp.modelOTPResponse = response
                    viewController.viewModelVerifyOtp.phoneNumber = self.inputTextField.text ?? ""
                    self.navigationController?.pushViewController(viewController, animated: true)
                case .failure(let error):
                    self.showSnackbarError(title: "", subtitle: error.localizedDescription)
                    Log.d(error)
                }
            }
        }
    }
    func getOnBoadingScreens() {
        self.viewModel.getOnBoadingScreens { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    Log.d(data)
                    self?.collectionSlides.reloadData()
                    self?.pageControl.numberOfPages = self?.viewModel.slides.count ?? 0
                case .failure(let error):
                    Log.d(error.localizedDescription)
                }
            }
        }
    }
}
// MARK: - CollectionView UICollectionViewDataSource -
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
// MARK: - CollectionView UICollectionViewDelegateFlowLayout -
extension EnterPhoneNumberViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}
// MARK: - UIScrollViewDelegate -
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
// MARK: - Buttons tap -
extension EnterPhoneNumberViewController {
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
      // self.view.endEditing(true)
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        if !self.viewModel.validate(value: inputTextField.text!) {
            showInPutError()
            return
        }
        guard let phoneNumber = inputTextField.text else { return }
        getOTP(phoneNumber: phoneNumber)
    }
    @IBAction func clearText(_ sender: Any) {
        inputTextField.text = ""
        clearButton.isHidden = true
        hideInPutError()
        textfieldStateChange(to: .active)
    }
}
// MARK: - UITextFieldDelegate -
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
        heightConstraintPlaceholderText.constant = 13
        viewCollectionPagination.layoutIfNeeded()
        if heightConstraintErrorView.constant > 0 {
            textfieldStateChange(to: .error)
        } else {
            textfieldStateChange(to: .active)
        }
 
        self.view.layoutIfNeeded()
        
    }
    @objc func editingText(_ textField: UITextField) {
        if (textField.text?.count ?? 0) == 0 {
            clearButton.isHidden = true
            hideInPutError()
            textfieldStateChange(to: .active) // conditon overriden  bcz keyboard will not go down ever for now condition
        } else if ((textField.text?.count ?? 0) > 0 ) && ((textField.text?.count ?? 0) < 10 ){
            showInPutError()
            clearButton.isHidden = false
        } else if ((textField.text?.count ?? 0) == 10 ) {
            hideInPutError()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        clearButton.isHidden = true
        heightConstraintPlaceholderText.constant = 0
        if (textField.text?.count ?? 0) == 0 {
            hideInPutError()
        } else if ((textField.text?.count ?? 0) > 0 ) && ((textField.text?.count ?? 0) < 10 ){
            clearButton.isHidden = false
            showInPutError()
        } else if ((textField.text?.count ?? 0) == 10 ) {
            hideInPutError()
        }
    }
}
