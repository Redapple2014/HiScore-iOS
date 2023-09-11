//
//  WalletViewController.swift
//  HiScore
//
//  Created by PC-072 on 28/08/23.
//

import UIKit
import MHLoadingButton
import EasyTipView

class WalletViewController: BaseViewController {
    @IBOutlet weak var buttonAddCash: LoadingButton!
    @IBOutlet weak var buttonWithdraw: LoadingButton!
    @IBOutlet weak var heightwalletBreakdownView: NSLayoutConstraint!
    @IBOutlet weak var walletView: HSShadowView!
    @IBOutlet weak var detailsView: HSShadowView!
    @IBOutlet weak var hiscoreWallet: UILabel!
    @IBOutlet weak var transactionProgress: UILabel!
    @IBOutlet weak var accountAdded: UILabel!
    @IBOutlet weak var kycStatus: UILabel!
    @IBOutlet weak var subkycStatus: UILabel!
    @IBOutlet weak var kycStatusIcon: UIImageView!
    
    @IBOutlet weak var buttonDepositeHint: UIButton!
    @IBOutlet weak var buttonRummyCashHint: UIButton!
    @IBOutlet weak var buttonWinningHint: UIButton!
    
    @IBOutlet weak var labelDepositAmount: UILabel!
    @IBOutlet weak var labelWinningAmount: UILabel!
    @IBOutlet weak var labelRummyCashAmount: UILabel!
    
    
    private var viewModel: WalletViewModel!
    weak var tipView: EasyTipView?
    
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
        getWalletDetails()
        getKYCStatus()
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
    }
}
//MARK: - Button actions -
extension WalletViewController {
    @IBAction func addCash(_ sender: Any) {
        guard let viewController = self.storyboard(name: .addCash).instantiateViewController(withIdentifier: "AddCashViewController") as? AddCashViewController else {
            return
        }
        viewController.walletBalance = (self.viewModel.walletData?.depositAmount ?? 0) + (self.viewModel.walletData?.winningsAmount ?? 0) + Int((self.viewModel.walletData?.rummyCash ?? 0.0))
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func buttonTDSPolicyTapped(_ sender: Any) {
        guard let viewController = self.storyboard(name: .webview).instantiateViewController(withIdentifier: "WebviewViewController") as? WebviewViewController else {
            return
        }
        guard let urlstring = self.viewModel.walletData?.tdsKnowMoreURL,
              let  url = URL(string: urlstring) else { return }
        viewController.url = url
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

private extension WalletViewController {
    
    func loadData() {
        let depositAmt = self.viewModel.walletData?.depositAmount ?? 0
        let winningAmt = self.viewModel.walletData?.winningsAmount ?? 0
        let rummyCash =  self.viewModel.walletData?.rummyCash ?? 0.0
        let totalBalance = Double(depositAmt) + Double(winningAmt) + rummyCash
        self.hiscoreWallet.text = totalBalance.description
        self.transactionProgress.text = "\(self.viewModel.walletData?.withdrawalProgress ?? 0) Transaction in progress"
        self.labelDepositAmount.text = self.viewModel.walletData?.depositAmount.description
        self.labelWinningAmount.text = self.viewModel.walletData?.winningsAmount.description
        self.labelRummyCashAmount.text = self.viewModel.walletData?.rummyCash.description
    }
    func getKYCStatus() {
        viewModel.getKycStatus { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    Log.d(data)
                    if data.data.info.kycstatus == .required {
                        self.kycStatus.text = "KYC Pending"
                        self.subkycStatus.text = "Verify to make withdrawals"
                        self.kycStatusIcon.image = UIImage(named: "errorIcon")
                    } else {
                        self.kycStatus.text = ""
                        self.subkycStatus.text = ""
                        //  self.kycStatusIcon.image = UIImage(named: "errorIcon")
                    }
                case .failure(let error):
                    Log.d(error)
                }
            }
        }
    }
    func getWalletDetails() {
        viewModel.getWalletDetails { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let response):
                    Log.d(response)
                    self.loadData()
                case .failure(let error):
                    Log.d(error.localizedDescription)
                }
            }
        }
    }
}

extension WalletViewController: EasyTipViewDelegate {
    func easyTipViewDidTap(_ tipView: EasyTipView) {
        Log.d("\(tipView) did tap!")
    }
    
    func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        Log.d("\(tipView) did dismiss!")
    }
    @IBAction func buttonAction(sender : UIButton) {
        showDepositHint()
    }
    @objc func showDepositHint() {
        let customHintView = TipView()
        customHintView.setMessage(title: "Deposit",
                                  message: "Cash that you deposit into your HiScore wallet. You cannot withdraw it but can use it to join contests",
                                  image: UIImage(named: "bankNotes")!)
        
        var preferences = EasyTipView.globalPreferences
        preferences.drawing.backgroundColor = .clear
        
        preferences.animating.dismissTransform = CGAffineTransform(translationX: 0, y: -15)
        preferences.animating.showInitialTransform = CGAffineTransform(translationX: 0, y: 15)
        preferences.animating.showInitialAlpha = 0
        preferences.animating.showDuration = 1
        preferences.animating.dismissDuration = 1
        preferences.drawing.arrowPosition = .any
        
        let easyTip = EasyTipView(contentView: customHintView, preferences: preferences, delegate: self)
        easyTip.show(forView: buttonDepositeHint, withinSuperview: walletView.self)
    }
}
