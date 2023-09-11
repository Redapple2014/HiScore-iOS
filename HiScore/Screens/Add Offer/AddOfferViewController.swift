//
//  AddOfferViewController.swift
//  HiScore
//
//  Created by PC-072 on 07/09/23.
//

import UIKit

protocol AddOfferDelegate {
    func couponApplied(index:Int, data: OfferData)
    func manualCouponApplied(data: OfferData, text: String)
}
class AddOfferViewController: BaseViewController {
    
    @IBOutlet weak var viewNoMore: UIView!
    @IBOutlet weak var labelCouponCode: UILabel!
    @IBOutlet weak var viewCoupunAppliedSuccess: UIView!
    
    @IBOutlet weak var couponDetails: UILabel!
    @IBOutlet weak var vwHeadache: UIView!
    @IBOutlet weak var tableOffers: UITableView!
    @IBOutlet weak var textEnterCouponCode: UITextField!
    @IBOutlet weak var vwApply: UIView!
    @IBOutlet weak var viwTextField: UIView!
    var offerData: [OfferData] = []
    var amount = 0
    let iceCream = "🎉"
    var delegate: AddOfferDelegate?
    var viewModel: AddOfferViewModel!
}
extension AddOfferViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        let networkService = HiScoreNetworkRepository()
        viewModel = AddOfferViewModel(networkService: networkService)

        if self.offerData.count == 0 {
            viewNoMore.isHidden = false
            tableOffers.isHidden = true
            return
        }
        checkPreSelectedvalue()
        checkSelectedCoupon()
    }
}
extension AddOfferViewController {
    @IBAction func applyCouponTapped(_ sender: Any) {
        guard let text = textEnterCouponCode.text else {
            return
        }
        viewModel.getAddMoneyScreenData(value: text,
                                         completion: { response in
            switch response {
            case .success(let response):
                Log.d(response)
                if response.data?.extraInfo?.isValidCode ?? true {
//                    let array =  check rummy. promo 
                    self.delegate?.manualCouponApplied(data: <#T##OfferData#>, text: response.data?.extraInfo?.voucherCode ?? "")
                   // self.showSnackbarError(title: "", subtitle: "")
                }
                break
            case .failure(let error):
                self.showSnackbarError(title: "", subtitle: error.localizedDescription)
                Log.d(error)
                
                break
            }
        })
    }

    @IBAction func buttonRemoveCoupon(_ sender: Any) {
        for i in 0..<self.offerData.count {
            self.offerData[i].isSelected = false
        }
        self.tableOffers.reloadData()
        viewCoupunAppliedSuccess.isHidden = true
        viwTextField.isHidden = false
    }
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension AddOfferViewController {
    private func checkPreSelectedvalue() {
//        let data = self.offerData.map({$0.isSelected = false})
        for index in 0..<self.offerData.count {
            offerData[index].isSelected = false
        }
      let indx =  self.offerData.firstIndex { amount >= $0.minLimit ?? 0 && amount <= $0.maxLimit ?? 0 }
        guard let index = indx else { return }
        offerData[index].isSelected = true




    }
    private func checkSelectedCoupon() {
        let array = offerData.filter({$0.isSelected == true})
        if array.count > 0 {
            labelCouponCode.text = "\(array[0].offerCode ?? "") \(iceCream)"//"IOSOFFERALL Applied \(iceCream)"
            couponDetails.text = array[0].offerDesc?.count ?? 0 > 0 ? array[0].offerDesc?[0] : ""
            viewCoupunAppliedSuccess.isHidden = false
            viwTextField.isHidden = true
        } else {
            viewCoupunAppliedSuccess.isHidden = true
            viwTextField.isHidden = false
        }
    }
    func loadUI() {
        UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.light
        textEnterCouponCode.addTarget(self, action: #selector(editingText(_:)), for: .editingChanged)
        vwApply.layer.cornerRadius = 10
        viwTextField.layer.cornerRadius = 8
        shadowView(vw: vwApply)
        shadowView(vw: viwTextField)
        tableOffers.estimatedRowHeight = 999
        tableOffers.rowHeight = UITableView.automaticDimension
        
    }
    func shadowView(vw:UIView) {
        vw.layer.borderWidth = 1.0
        vw.layer.borderColor = UIColor.HSWhiteColor.withAlphaComponent(0.5).cgColor
        vw.layer.shadowColor = UIColor.HSWhiteColor.withAlphaComponent(0.2).cgColor
        vw.layer.shadowOffset = CGSize(width: 3, height: 3)
        vw.layer.shadowOpacity = 0.7
        vw.layer.shadowRadius = 4.0
    }
}
extension AddOfferViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.offerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddOffersTableViewCell else { return AddOffersTableViewCell() }
        cell.loadCell(data: self.offerData[indexPath.row], index: indexPath.row)
        cell.buttonTapped = { data, index  in
            for i in 0..<self.offerData.count {
                self.offerData[i].isSelected = false
            }
            self.offerData[index].isSelected = true
            self.delegate?.couponApplied(index: index, data: self.offerData[index])
            self.navigationController?.popViewController(animated: true)
           // self.tableOffers.reloadData()
        }
        return cell
    }
}

// MARK: - UITextFieldDelegate -
extension AddOfferViewController: UITextFieldDelegate {
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
        if textField.text?.count ?? 0 > 0 {

        } else {

        }
    }
    @objc func editingText(_ textField: UITextField) {
        let amount = textField.text ?? "0"
//        if (textField.text?.count ?? 0) == 0 {
//
//        } else {
//            viewModel?.getAddMoneyScreenData(value: amount,
//                                             completion: { response in
//                switch response {
//                case .success(let response):
//                    Log.d(response)
//                    break
//                case .failure(let error):
//                    self.showSnackbarError(title: "", subtitle: error.localizedDescription)
//                    Log.d(error)
//
//                    break
//                }
//            })
//        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
}
