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
    @IBOutlet weak var heightwalletBreakdownView: NSLayoutConstraint!
    @IBOutlet weak var walletView: HSShadowView!
    @IBOutlet weak var detailsView: HSShadowView!
    @IBOutlet weak var hiscoreWallet: UILabel!
    @IBOutlet weak var transactionProgress: UILabel!
    @IBOutlet weak var accountAdded: UILabel!
    @IBOutlet weak var kycStatus: UILabel!
    @IBOutlet weak var kycStatusIcon: UIImageView!
    private var viewModel: WalletViewModel!
    override func updateUI() {
        super.updateUI()
    }
}
//MARK: - View Life Cycle -
extension WalletViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let hiScoreNetworkService = HiScoreNetworkRepository()
        viewModel = WalletViewModel(networkService: hiScoreNetworkService)
        viewModel.getWalletDetails { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let response):
                    Log.d(response)
                    //self.hiscoreWallet.text = self.viewModel.walletData.
                case .failure(let error):
                    Log.d(error.localizedDescription)
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        heightwalletBreakdownView.constant =  3 * 60 // arrayCount * tablerowHeight
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
        switch indexPath.row {
        case 0:
            cell.type.text = "Deposit"
        case 1:
            cell.type.text = "Winnings"
        default:
            cell.type.text = "Rummycash"
        }
        return cell
    }
}


class WalletBreakDownCell: UITableViewCell {
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var amount: UILabel!
}
