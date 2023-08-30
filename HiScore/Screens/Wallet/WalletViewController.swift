//
//  WalletViewController.swift
//  HiScore
//
//  Created by PC-072 on 28/08/23.
//

import UIKit
import MHLoadingButton

class WalletViewController: BaseViewController {
    @IBOutlet weak var buttonAddCash: LoadingButton!
    @IBOutlet weak var buttonWithdraw: LoadingButton!
    @IBOutlet weak var tableViewWalletBreakdown: UITableView!
    @IBOutlet weak var tableHeightViewWalletBreakdown: NSLayoutConstraint!
    @IBOutlet weak var heightwalletBreakdownView: NSLayoutConstraint!
    @IBOutlet weak var walletView: HSShadowView!
    override func updateUI() {
        super.updateUI()
    }
}
//MARK: - View Life Cycle -
extension WalletViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        heightwalletBreakdownView.constant =  tableViewWalletBreakdown.contentSize.height
        buttonAddCash.layoutIfNeeded()
        buttonAddCash.setNeedsLayout()
        buttonWithdraw.layoutIfNeeded()
        buttonWithdraw.setNeedsLayout()
        buttonAddCash.setUpButtonWithGradientBackground(type: .yellow)
        buttonWithdraw.setUpButtonWithGradientBackground(type: .yellow)
        tableViewWalletBreakdown.layoutIfNeeded()
        tableViewWalletBreakdown.setNeedsLayout()
        tableViewWalletBreakdown.reloadData()
        
    }
}
//MARK: - Button actions -
extension WalletViewController {
    @IBAction func addCash(_ sender: Any) {
        //        guard let viewController = self.storyboard(name: .addCash).instantiateViewController(withIdentifier: "AddCashViewController") as? AddCashViewController else {
        //            return
        //        }
        //        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
//MARK: - Tableview delegate and datasource

extension WalletViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? WalletBreakDownCell else {
            return WalletBreakDownCell()
        }
        return cell
    }
}


class WalletBreakDownCell: UITableViewCell {
    
}
