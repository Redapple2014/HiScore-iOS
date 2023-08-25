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
        setTabBarItems()
        self.view.backgroundColor = .HSAppThemeColor
        self.tabBar.backgroundColor = UIColor.HSTabbarColor
        self.tabBar.tintColor = .HSYellowTextColor
        self.tabBar.unselectedItemTintColor = .white
        self.tabBar.isTranslucent = false
        self.tabBar.layer.masksToBounds = true
        self.tabBar.layer.cornerRadius = 16
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.tabBar.layer.borderColor = UIColor.HSWhiteColor.withAlphaComponent(0.3).cgColor
        self.tabBar.layer.borderWidth = 0.3
    }
    func setTabBarItems(){
          let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
          myTabBarItem1.image = UIImage(named: "home-deselect")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
          myTabBarItem1.selectedImage = UIImage(named: "home-select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
          myTabBarItem1.title = "Home"

          let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
          myTabBarItem2.image = UIImage(named: "wallet-deselect")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
          myTabBarItem2.selectedImage = UIImage(named: "wallet-select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
          myTabBarItem2.title = "Wallet"

          let myTabBarItem3 = (self.tabBar.items?[2])! as UITabBarItem
          myTabBarItem3.image = UIImage(named: "more-deselect")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
          myTabBarItem3.selectedImage = UIImage(named: "more-select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
          myTabBarItem3.title = "More"
     }
}
