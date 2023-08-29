//
//  RewardPopupView.swift
//  HiScore
//
//  Created by PC-072 on 22/08/23.
//

import UIKit
import MHLoadingButton


protocol RewardPopupDelegate {
    func okayTapped()
}
class RewardPopupView: UIView {
    @IBOutlet weak var viewCintainer: UIView!
    @IBOutlet weak var buttonCross: UIButton!
    
    var delegate: RewardPopupDelegate?
    @IBOutlet var labelDescCollection: [UILabel]!
    
    @IBOutlet weak var labelTitleDepositCash: UILabel!
    @IBOutlet weak var labelTitleWinningCash: UILabel!
    @IBOutlet weak var labelTitleRummyCashCash: UILabel!
    @IBOutlet weak var labelTitleFreeEntryTickets: UILabel!
    @IBOutlet weak var labelTitleVouchersAndOffers: UILabel!
    
    @IBOutlet weak var imageIconDepositCash: UIImageView!
    @IBOutlet weak var imageIconWinningCash: UIImageView!
    @IBOutlet weak var imageIconRummyCashCash: UIImageView!
    @IBOutlet weak var imageIconFreeEntryTickets: UIImageView!
    @IBOutlet weak var imageIconVouchersAndOffers: UIImageView!
    
    @IBOutlet var imageArrow:[ UIImageView]!
    @IBOutlet weak var imageArrowDepositCash: UIImageView!
    @IBOutlet weak var imageArrowWinningCash: UIImageView!
    @IBOutlet weak var imageArrowRummyCashCash: UIImageView!
    @IBOutlet weak var imageArrowFreeEntryTickets: UIImageView!
    @IBOutlet weak var imageArrowVouchersAndOffers: UIImageView!
    
    @IBOutlet var viewContainer:[ UIView]!
    @IBOutlet weak var viewDepositCash: UIView!
    @IBOutlet weak var viewWinningCash: UIView!
    @IBOutlet weak var viewRummyCashCash: UIView!
    @IBOutlet weak var viewFreeEntryTickets: UIView!
    @IBOutlet weak var viewVouchersAndOffers: UIView!
    
    @IBOutlet weak var labelDepositCash: UILabel!
    @IBOutlet weak var labelWinningCash: UILabel!
    @IBOutlet weak var labelRummyCashCash: UILabel!
    @IBOutlet weak var labelFreeEntryTickets: UILabel!
    @IBOutlet weak var labelVouchersAndOffers: UILabel!
    
    @IBOutlet weak var buttonVerify: LoadingButton!
    private let nibName = "RewardPopupView"
    
    private var dataDepositCash: RewardsList?
    private var dataRummyCash: RewardsList?
    private var dataWinningCash: RewardsList?
    private var dataFreeTicket: RewardsList?
    private var dataVouchers: RewardsList?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
   private func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    private func loadUI() {
        _ = viewContainer.map({$0.layer.cornerRadius = 10})
        _ = viewContainer.map({$0.clipsToBounds = true})
        buttonVerify.setCornerBorder(color: .HSYellowButtonColor,
                                         cornerRadius: 10,
                                         borderWidth: 0.8)
        buttonVerify.setUpButtonWithGradientBackground(type: .yellow)
        viewCintainer.setGradientBackground(colorTop: UIColor(hex: "393D51"), colorBottom: UIColor(hex: "14182A"))
    }
    private func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
        
    @IBAction func buttonOkPressed(_ sender: Any) {
        delegate?.okayTapped()
    }
    
    @IBAction func closePopup(_ sender: Any) {
        self.isHidden = true
        clearAllText()
    }
    //
    func showDefaultData(data: RewardsList, type: RewardType) {
        loadUI()
        switch type {
        case .depositCash:
            dataDepositCash = data
            showIcon(data: data, icon: imageIconDepositCash, label: labelTitleDepositCash)
            break
        case .winningCash:
            dataWinningCash = data
            showIcon(data: data, icon: imageIconWinningCash, label: labelTitleWinningCash)
            break
        case .rummyCash:
            dataRummyCash = data
            showIcon(data: data, icon: imageIconRummyCashCash, label: labelTitleRummyCashCash)
            break
        case .freeEntryTickets:
            dataFreeTicket = data
            showIcon(data: data, icon: imageIconFreeEntryTickets, label: labelTitleFreeEntryTickets)
            break
        case .vouchersAndOffers:
            dataVouchers = data
            showIcon(data: data, icon: imageIconVouchersAndOffers, label: labelTitleVouchersAndOffers)
            break
        }
    }
    private func getArrowImage() -> UIImage {
        return UIImage(named: "arrowUp_2")!
    }
    private func showIcon(data: RewardsList, icon: UIImageView, label: UILabel ) {
        label.text = data.rewardTitle
        icon.kf.setImage(with: data.splashScreenUrl,
                                placeholder: UIImage(named: "placeholder"),
                                options: nil,
                                progressBlock: nil,
                                completionHandler: nil)
        
    }
    private func clearAllText() {
        _ = labelDescCollection.map({$0.text = ""})
        _ = imageArrow.map({$0.image = UIImage(named: "arrowDownHS")})
        _ = viewContainer.map({$0.backgroundColor = .clear})
       
    }
   
    private func selectedUI(type: RewardType) {
        clearAllText()
        switch type {
        case .depositCash:
            depositCash()
            break
        case .winningCash:
            winningCash()
            break
        case .rummyCash:
            rummyCash()
            break
        case .freeEntryTickets:
            freeEntryTickets()
            break
        case .vouchersAndOffers:
            vouchersAndOffers()
            break
        }
        
    }
//    private func checkLabelText(label: UILabel, text: String) {
//        if label.text!.isEmpty {
//            label.text = text
//        } else {
//            self.clearAllText()
//        }
//    }
    private func depositCash() {
        labelDepositCash.text = self.dataDepositCash?.rewardDesc
        viewDepositCash.backgroundColor = .HSRewardBlackColor
        imageArrowDepositCash.image = getArrowImage()
    }
    private  func winningCash() {
        labelWinningCash.text = self.dataWinningCash?.rewardDesc
        viewWinningCash.backgroundColor = .HSRewardBlackColor
        imageArrowWinningCash.image = getArrowImage()
    }
    private func rummyCash() {
        let text = self.dataRummyCash?.rewardDesc.replacingOccurrences(of: "\n", with: "\n• ") ?? ""
        labelRummyCashCash.text = "• " + text
        viewRummyCashCash.backgroundColor = .HSRewardBlackColor
        imageArrowRummyCashCash.image = getArrowImage()
    }
    private func freeEntryTickets() {
        labelFreeEntryTickets.text = self.dataFreeTicket?.rewardDesc
        viewFreeEntryTickets.backgroundColor = .HSRewardBlackColor
        imageArrowFreeEntryTickets.image = getArrowImage()
    }
    private func vouchersAndOffers() {
        labelVouchersAndOffers.text = self.dataVouchers?.rewardDesc
        viewVouchersAndOffers.backgroundColor = .HSRewardBlackColor
        imageArrowVouchersAndOffers.image = getArrowImage()

    }
    @IBAction func buttonDepositCash(_ sender: Any) {
        if labelDepositCash.text == "" {
            selectedUI(type: .depositCash)
        } else {
            clearAllText()
        }
    }
    @IBAction func buttonWinningCash(_ sender: Any) {
        if labelWinningCash.text == "" {
            selectedUI(type: .winningCash)
        } else {
            clearAllText()
        }
    }
    @IBAction func buttonRummyCash(_ sender: Any) {
        if labelRummyCashCash.text == "" {
            selectedUI(type: .rummyCash)
        } else {
            clearAllText()
        }
    }
    @IBAction func buttonFreeEntryTickets(_ sender: Any) {
        if labelFreeEntryTickets.text == "" {
            selectedUI(type: .freeEntryTickets)
        } else {
            clearAllText()
        }
    }
    @IBAction func buttonVouchers(_ sender: Any) {
        if labelVouchersAndOffers.text == "" {
            selectedUI(type: .vouchersAndOffers)
        } else {
            clearAllText()
        }
    }
}

enum RewardType {
    case depositCash
    case winningCash
    case rummyCash
    case freeEntryTickets
    case vouchersAndOffers
}
