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

    @IBOutlet weak var imageVwAmount: UIImageView!
    @IBOutlet weak var labelbalance: UILabel!
    @IBOutlet weak var viewNoOffers: UIView!
    @IBOutlet weak var stackAmountDetails: UIStackView!
    @IBOutlet weak var viewYouGot: UIView!
    @IBOutlet weak var imageBGContinue: UIImageView!
    @IBOutlet weak var constantOfbuttonContainerViewBottom: NSLayoutConstraint!
    @IBOutlet weak var labelUptoCash: UILabel!
    @IBOutlet weak var labelOfferTotal: UILabel!
    @IBOutlet weak var collectionOfCashOffers: UICollectionView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var enterAmountTextField: UITextField!
    @IBOutlet weak var buttonContinue: LoadingButton!
    @IBOutlet weak var viewTextField: UIView!
    var viewModel: AddCashViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let networkService = HiScoreNetworkRepository()
        viewModel = AddCashViewModel(networkService: networkService)
        getScreenDataData()
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
    private func getScreenDataData() {
        viewModel.getAddMoneyScreenData { response in
            switch response {
            case .success(let response):
                Log.d(response)
                break
            case .failure(let error):
                self.showSnackbarError(title: "", subtitle: error.localizedDescription)
                Log.d(error)
                
                break
            }
        }
    }

    func initSettings() {
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        IQKeyboardManager.shared().isEnabled = false
        UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.light
        enterAmountTextField.addTarget(self, action: #selector(editingText(_:)), for: .editingChanged)
        enterAmountTextField.delegate  = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
    }
    func initUI() {
        imageBGContinue.isHidden = true
        collectionOfCashOffers.isHidden = false//true
        viewNoOffers.isHidden = true//false
        stackAmountDetails.isHidden = true
        viewYouGot.isHidden = true
        buttonContinue.initLoadingButton()
        viewTextField.layer.borderColor = UIColor.HSWhiteColor.withAlphaComponent(0.75).cgColor
        viewTextField.layer.cornerRadius = 8
        viewTextField.layer.borderWidth = 1.0
        viewTextField.backgroundColor = UIColor.HSWhiteColor.withAlphaComponent(0.1)
        enterAmountTextField.clearButtonMode = .never
        enterAmountTextField.textColor = UIColor.HSWhiteColor
        enterAmountTextField.font = UIFont.Rajdhani.Bold.withSize(18)
        enterAmountTextField.tintColor = .HSWhiteColor
        collectionOfCashOffers.delegate = self
        collectionOfCashOffers.dataSource = self
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
        imageBGContinue.isHidden = false
        constantOfbuttonContainerViewBottom.constant = 216
        imageVwAmount.isHidden = true
        self.view.layoutIfNeeded()
        
    }
    @objc func editingText(_ textField: UITextField) {  }
    func textFieldDidEndEditing(_ textField: UITextField) {
        clearButton.isHidden = true
        imageBGContinue.isHidden = true
        constantOfbuttonContainerViewBottom.constant = 0
        imageVwAmount.isHidden = false
    }
}
// MARK: - CollectionView UICollectionViewDataSource -
extension AddCashViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AddCashCollectionViewCell else { return AddCashCollectionViewCell() }
       // cell.images = self.viewModel.slides[indexPath.row]
        return cell
    }
}
// MARK: - CollectionView UICollectionViewDelegateFlowLayout -
extension AddCashViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 85, height: 137)
    }
}
