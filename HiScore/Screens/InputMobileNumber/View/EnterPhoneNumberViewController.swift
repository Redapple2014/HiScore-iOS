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
    private var slides = [En]()
}
extension EnterPhoneNumberViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initSettings()
        hideInPutError()
        let networkService = HiScoreNetworkRepository()
        viewModel = OnboardingScreenViewModel(networkService: networkService)
        getOnBoadingScreens()
        
    }
}
extension EnterPhoneNumberViewController{
    private func getOnBoadingScreens() {
      
            self.viewModel.getOnBoadingScreens { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self.slides = data.en
                        self.collectionSlides.reloadData()
                        self.pageControl.numberOfPages = data.en.count
                        print(data)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
}
extension EnterPhoneNumberViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
}
extension EnterPhoneNumberViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
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
        inputTextField.addTarget(self, action: #selector(editingText(_:)), for: .valueChanged)
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
                        //  options: .transitionCurlUp,
                          animations: {
            self.hideViewWithAnimation()
            self.bottomConstraintOfLoginView.constant = 350

                      })

    }
    @objc func editingText(_ textField: UITextField) {
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.transition(with: viewCollectionPagination, duration: 2.4,
                         // options: .transitionCurlUp,
                          animations: {
            self.bottomConstraintOfLoginView.constant = 0
            self.unhideViewWithAnimation()
//            self.topConstraintOfLoginView.constant = 0
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
