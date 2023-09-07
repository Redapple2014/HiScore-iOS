//
//  AddOfferViewController.swift
//  HiScore
//
//  Created by PC-072 on 07/09/23.
//

import UIKit

class AddOfferViewController: BaseViewController {

    @IBOutlet weak var tableOffers: UITableView!
    @IBOutlet weak var textEnterCouponCode: UITextField!
    @IBOutlet weak var vwApply: UIView!
    @IBOutlet weak var viwTextField: UIView!
    
}
extension AddOfferViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()
    }
}
extension AddOfferViewController {
    func loadUI() {
        vwApply.layer.cornerRadius = 10
        viwTextField.layer.cornerRadius = 8
        shadowView(vw: vwApply)
        shadowView(vw: viwTextField)
    }
    func shadowView(vw:UIView) {
        // border
        vw.layer.borderWidth = 1.0
        vw.layer.borderColor = UIColor.HSWhiteColor.withAlphaComponent(0.5).cgColor
        // shadow
        vw.layer.shadowColor = UIColor.HSWhiteColor.withAlphaComponent(0.2).cgColor
        vw.layer.shadowOffset = CGSize(width: 3, height: 3)
        vw.layer.shadowOpacity = 0.7
        vw.layer.shadowRadius = 4.0
    }
}
extension AddOfferViewController: UITableViewDataSource, UITableViewDelegate {
    private func tableView(_ tableView: UITableView, heightForRow section: Int) -> Int {
        return 144
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddOffersTableViewCell else { return AddOffersTableViewCell() }
        return cell
    }
}
