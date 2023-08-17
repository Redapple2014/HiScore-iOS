//
//  CustomTabBarController.swift
//  HiScore
//
//  Created by RATPC-043 on 17/08/23.
//

import Foundation
import UIKit
class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tabBar.backgroundColor = UIColor.HSTabbarColor.withAlphaComponent(0.8)
        self.tabBar.layer.masksToBounds = true
        self.tabBar.layer.cornerRadius = 16
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
}
