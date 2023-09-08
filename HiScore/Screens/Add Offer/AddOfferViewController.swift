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
    var offerData: [OfferData]?
    
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
        tableOffers.estimatedRowHeight = 999
        tableOffers.rowHeight = UITableView.automaticDimension
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
        return Int(UITableView.automaticDimension)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.offerData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddOffersTableViewCell else { return AddOffersTableViewCell() }
        guard var array = self.offerData else { return AddOffersTableViewCell() }
        cell.loadCell(data: array[indexPath.row], index: indexPath.row)
        cell.buttonTapped = { data, index  in
            self.offerData?[index].isSelected = true
            self.tableOffers.reloadData()
        }
        return cell
    }
}
