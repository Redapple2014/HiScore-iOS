//
//  RewardPopupView.swift
//  HiScore
//
//  Created by PC-072 on 22/08/23.
//

import UIKit


protocol RewardPopupDelegate {
    func okayTapped()
}
class RewardPopupView: UIView {
    
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
       _ = viewContainer.map({$0.layer.cornerRadius = 10})
       _ = viewContainer.map({$0.clipsToBounds = true})
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
    
    // arrowUp
    
    func showDefaultData(data: RewardsList, type: RewardType) {
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
    private func depositCash() {
        labelDepositCash.text = self.dataDepositCash?.rewardDesc
        viewDepositCash.backgroundColor = .HSLightBlackColor
    }
    private  func winningCash() {
        labelWinningCash.text = self.dataWinningCash?.rewardDesc
        viewWinningCash.backgroundColor = .HSLightBlackColor
    }
    private func rummyCash() {
        labelRummyCashCash.text = self.dataRummyCash?.rewardDesc
        viewRummyCashCash.backgroundColor = .HSLightBlackColor
    }
    private func freeEntryTickets() {
        labelFreeEntryTickets.text = self.dataFreeTicket?.rewardDesc
        viewFreeEntryTickets.backgroundColor = .HSLightBlackColor
    }
    private func vouchersAndOffers() {
        labelVouchersAndOffers.text = self.dataVouchers?.rewardDesc
        viewVouchersAndOffers.backgroundColor = .HSLightBlackColor

    }
    @IBAction func buttonDepositCash(_ sender: Any) {
        selectedUI(type: .depositCash)
    }
    @IBAction func buttonWinningCash(_ sender: Any) {
        selectedUI(type: .winningCash)
    }
    @IBAction func buttonRummyCash(_ sender: Any) {
        selectedUI(type: .rummyCash)
    }
    @IBAction func buttonFreeEntryTickets(_ sender: Any) {
        selectedUI(type: .freeEntryTickets)
    }
    @IBAction func buttonVouchers(_ sender: Any) {
        selectedUI(type: .vouchersAndOffers)
    }
}

enum RewardType {
    case depositCash
    case winningCash
    case rummyCash
    case freeEntryTickets
    case vouchersAndOffers
}
