//
//  AddOfferViewController.swift
//  HiScore
//
//  Created by PC-072 on 07/09/23.
//

import UIKit

protocol AddOfferDelegate {
    func couponApplied(index:Int)
}
class AddOfferViewController: BaseViewController {

    @IBOutlet weak var labelCouponCode: UILabel!
    @IBOutlet weak var viewCoupunAppliedSuccess: UIView!
    
    @IBOutlet weak var couponDetails: UILabel!
    @IBOutlet weak var vwHeadache: UIView!
    @IBOutlet weak var tableOffers: UITableView!
    @IBOutlet weak var textEnterCouponCode: UITextField!
    @IBOutlet weak var vwApply: UIView!
    @IBOutlet weak var viwTextField: UIView!
    var offerData: [OfferData] = []
    let iceCream = "🎉"
    var delegate: AddOfferDelegate?
}
extension AddOfferViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        checkSelectedCoupon()
    }
}
extension AddOfferViewController {
    @IBAction func buttonRemoveCoupon(_ sender: Any) {
        for i in 0..<self.offerData.count {
            self.offerData[i].isSelected = false
        }
        self.tableOffers.reloadData()
        viewCoupunAppliedSuccess.isHidden = true
        viwTextField.isHidden = false
    }

}
extension AddOfferViewController {
    private func checkSelectedCoupon() {
        let array = offerData.filter({$0.isSelected == true})
        if array.count > 0 {
            labelCouponCode.text = "IOSOFFERALL Applied \(iceCream)"
            couponDetails.text = array[0].offerDesc?.count ?? 0 > 0 ? array[0].offerDesc?[0] : ""
            viewCoupunAppliedSuccess.isHidden = false
            viwTextField.isHidden = true
        } else {
            viewCoupunAppliedSuccess.isHidden = true
            viwTextField.isHidden = false
        }
    }
    func loadUI() {
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
            self.delegate?.couponApplied(index: index)
            self.navigationController?.popViewController(animated: true)
           // self.tableOffers.reloadData()
        }
        return cell
    }
}
