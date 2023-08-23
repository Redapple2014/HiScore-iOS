//
//  RewardPopupView.swift
//  HiScore
//
//  Created by PC-072 on 22/08/23.
//

import UIKit

class RewardPopupView: UIView {
    
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
    
    let nibName = "RewardPopupView"

   // let data: RewardsList?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
//    init(data: RewardsList) {
//        self.data = data
//    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
      //  designView()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    @IBAction func buttonOkPressed(_ sender: Any) {
    }
    
    @IBAction func closePopup(_ sender: Any) {
        self.isHidden = true
    }
    //
    
   // arrowUp
    func clearAllText() {
       _ = labelDescCollection.map({$0.text = ""})
        _ = imageArrow.map({$0.image = UIImage(named: "arrowDownHS")})
    }
    func selectedUI() {
        
    }
    @IBAction func buttonDepositCash(_ sender: Any) {
        clearAllText()
    }
    @IBAction func buttonWinningCash(_ sender: Any) {
        clearAllText()
    }
    @IBAction func buttonRummyCash(_ sender: Any) {
        clearAllText()
    }
    @IBAction func buttonFreeEntryTickets(_ sender: Any) {
        clearAllText()
    }
    @IBAction func buttonVouchers(_ sender: Any) {
        clearAllText()
    }
}

enum RewardType {
    case depositCash
    case winningCash
    case rummyCash
    case freeEntryTickets
    case vouchersAndOffers
}
