//
//  AddOfferViewController.swift
//  HiScore
//
//  Created by PC-072 on 07/09/23.
//

import UIKit

class AddOfferViewController: BaseViewController {

    @IBOutlet weak var vwApply: UIView!
    @IBOutlet weak var viwTextField: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // corner radius
        viwTextField.layer.cornerRadius = 10

        // border
        viwTextField.layer.borderWidth = 1.0
        viwTextField.layer.borderColor = UIColor.HSWhiteColor.withAlphaComponent(0.5).cgColor

        // shadow
        viwTextField.layer.shadowColor = UIColor.HSWhiteColor.withAlphaComponent(0.2).cgColor
        viwTextField.layer.shadowOffset = CGSize(width: 3, height: 3)
        viwTextField.layer.shadowOpacity = 0.7
        viwTextField.layer.shadowRadius = 4.0
    }
}
